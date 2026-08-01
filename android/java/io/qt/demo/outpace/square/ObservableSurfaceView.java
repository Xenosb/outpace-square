// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial

package io.qt.demo.outpace.square;

import android.content.Context;
import android.util.AttributeSet;
import android.view.Surface;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

import androidx.annotation.Nullable;


public class ObservableSurfaceView extends SurfaceView implements SurfaceHolder.Callback {

    @FunctionalInterface
    public interface SurfaceListener {
        void onSurfaceChanged(@Nullable Surface surface);
    }

    @Nullable
    private SurfaceListener surfaceListener;

    public ObservableSurfaceView(Context context) {
        super(context);
    }

    public ObservableSurfaceView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public ObservableSurfaceView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    public void setSurfaceListener(@Nullable SurfaceListener listener) {
        getHolder().addCallback(this);
        this.surfaceListener = listener;
    }

    @Nullable
    public Surface getSurface() {
        Surface surface = getHolder().getSurface();
        return (surface != null && surface.isValid()) ? surface : null;
    }

    @Override
    public void surfaceCreated(SurfaceHolder holder) {
        // The surface is not yet populated here. Notifying from surfaceChanged is enough.
    }

    @Override
    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
        if (surfaceListener != null) {
            surfaceListener.onSurfaceChanged(holder.getSurface());
        }
    }

    @Override
    public void surfaceDestroyed(SurfaceHolder holder) {
        if (surfaceListener != null) {
            surfaceListener.onSurfaceChanged(null);
        }
    }
}
