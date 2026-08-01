// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial

package io.qt.demo.outpace.square;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.graphics.Color;
import android.graphics.PixelFormat;
import android.os.Bundle;
import android.os.IBinder;
import android.os.RemoteException;
import android.view.Surface;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.Button;
import android.widget.FrameLayout;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;

public class MainActivity extends Activity
{
    private static final String TAG = "MainActivity";

    private static final String CAR_VIEW_ID = "carView";

    private FrameLayout m_rootLayout;
    private ObservableSurfaceView m_carView;

    private IRenderingService m_renderingService;

    // Keep a reference to our ServiceConnection
    private final ServiceConnection connection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service)
        {
            m_renderingService = IRenderingService.Stub.asInterface(service);

            // If surfaces already exists when we connect, bind it now
            if (m_carView != null)
                updateSurface(m_carView.getSurface(), CAR_VIEW_ID);
        }

        @Override
        public void onServiceDisconnected(ComponentName name)
        {
            m_renderingService = null;
        }

        @Override
        public void onBindingDied(ComponentName name)
        {
            bindToService();
        }

        @Override public void onNullBinding(ComponentName name) { }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        super.onCreate(savedInstanceState);

        // Ensure the background service is started so it keeps running
        // even after we unbind (Activity stops).
        Intent serviceIntent = new Intent(this, RenderingService.class);
        startService(serviceIntent);

        m_rootLayout = new FrameLayout(this);
        m_rootLayout.setLayoutParams(
            new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )
        );

        m_carView = setupSurfaceViewForItem(CAR_VIEW_ID);
        m_rootLayout.addView(
            m_carView,
            new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )
        );

        FrameLayout innerLayout = new FrameLayout(this);
        innerLayout.setLayoutParams(
            new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )
        );
        innerLayout.setFitsSystemWindows(true);
        m_rootLayout.addView(innerLayout);

        setContentView(m_rootLayout);
    }

    private ObservableSurfaceView setupSurfaceViewForItem(String qmlItemId)
    {
        ObservableSurfaceView view = new ObservableSurfaceView(this);

        view.setSurfaceListener(surface -> { updateSurface(surface, qmlItemId); });

        view.setOnTouchListener((v, event) -> {
            sendTouchEvent(event, qmlItemId);
            return true;
        });

        return view;
    }

    @Override
    protected void onStart()
    {
        super.onStart();
        bindToService();
    }

    @Override
    protected void onStop()
    {
        safeUnbind();
        super.onStop();
    }

    @Override
    protected void onDestroy()
    {
        // We intentionally DO NOT stop the service;
        super.onDestroy();
    }

    private void bindToService()
    {
        Intent serviceIntent = new Intent(this, RenderingService.class);
        boolean ok = bindService(serviceIntent, connection, Context.BIND_AUTO_CREATE);
    }

    private void safeUnbind()
    {
        try {
            unbindService(connection);
        } catch (IllegalArgumentException ignored) {
            // Not bound
        } finally {
            m_renderingService = null;
        }
    }

    //! [main-activity]
    private void updateSurface(Surface surface, String qmlItemId)
    {
        if (m_renderingService == null)
            return;

        try {
            if (surface != null)
                m_renderingService.setSurface(surface, qmlItemId);
            else
                m_renderingService.unsetSurface(qmlItemId);
        } catch (RemoteException ignored) {
        }
    }
    //! [main-activity]

    private void sendTouchEvent(MotionEvent event, String qmlItemId)
    {
        if (m_renderingService == null)
            return;

        try {
            m_renderingService.motionEvent(event, qmlItemId);
        } catch (RemoteException ignored) {
        }
    }
}
