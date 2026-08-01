// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial

package io.qt.demo.outpace.square;

import android.app.Service;
import android.content.Intent;
import android.os.Bundle;
import android.os.IBinder;
import android.os.RemoteCallbackList;
import android.os.RemoteException;
import android.util.Log;
import android.view.MotionEvent;
import android.view.Surface;

import java.util.HashMap;
import java.util.Map;

import io.qt.androidautomotive.raas.QtRaaSApplication;
import org.qtproject.qt.android.QtQmlStatus;
import org.qtproject.qt.android.QtQmlStatusChangeListener;

//! [service-class]
public class RenderingService extends Service {

    private static final String TAG = "RenderService";
    private QtRaaSApplication qtService;
    private volatile boolean mQtReady = false;

    // Cache stores raw unwrapped values (Boolean, Integer, etc.) for Qt replay
    private final Map<String, Object> mPropertyCache = new HashMap<>();
    // Bundle cache for AIDL clients
    private final Map<String, Bundle> mBundleCache = new HashMap<>();

    private final RemoteCallbackList<IRenderingCallback> callbacks = new RemoteCallbackList<>();

    // Single Binder instance exposed to all clients
    private final IRenderingService.Stub binder = new IRenderingService.Stub() {
        @Override
        public void setSurface(Surface surface, String itemId) {
            qtService.setSurface(surface, itemId);
        }

        @Override
        public void unsetSurface(String itemId) {
            qtService.unsetSurface(itemId);
        }

        @Override
        public void motionEvent(MotionEvent event, String itemId) {
            qtService.sendTouchEvent(event, itemId);
        }

        @Override
        public void setProperty(String name, Bundle value) {
            if (qtService == null || value == null || !value.containsKey("value"))
                return;
            // Unwrap the scalar value from the {value: <val>} bundle
            Object payload = value.get("value");
            if (payload == null)
                return;
            Log.d(TAG, "setProperty: " + name + " = " + payload);
            mBundleCache.put(name, value);
            mPropertyCache.put(name, payload);
            if (mQtReady) {
                qtService.setProperty(name, payload);
            } else {
                Log.d(TAG, "setProperty: Qt not ready yet, property " + name + " will be applied when Qt is ready");
            }
            notifyPropertyChanged(name, value);
        }

        @Override
        public Bundle getProperty(String name) {
            Bundle cached = mBundleCache.get(name);
            if (cached != null) {
                return cached;
            }
            if (qtService == null)
                return new Bundle();
            Bundle bundle = new Bundle();
            Object value = qtService.getProperty(name);
            if (value instanceof Integer) bundle.putInt("value", (Integer) value);
            else if (value instanceof Boolean) bundle.putBoolean("value", (Boolean) value);
            else if (value instanceof String) bundle.putString("value", (String) value);
            else if (value instanceof Double) bundle.putDouble("value", (Double) value);
            else if (value instanceof Float) bundle.putFloat("value", (Float) value);
            else if (value instanceof Long) bundle.putLong("value", (Long) value);
            return bundle;
        }

        @Override
        public void registerCallback(IRenderingCallback callback) {
            if (callback != null) {
                callbacks.register(callback);
                // Send all cached properties to the new subscriber
                for (Map.Entry<String, Bundle> entry : mBundleCache.entrySet()) {
                    try {
                        callback.onPropertyChanged(entry.getKey(), entry.getValue());
                    } catch (RemoteException e) {
                        Log.w(TAG, "Failed to send initial property to new callback", e);
                    }
                }
            }
        }

        @Override
        public void unregisterCallback(IRenderingCallback callback) {
            if (callback != null) {
                callbacks.unregister(callback);
            }
        }
    };
//! [service-class]

    private void notifyPropertyChanged(String name, Bundle value) {
        int count = callbacks.beginBroadcast();
        for (int i = 0; i < count; i++) {
            try {
                callbacks.getBroadcastItem(i).onPropertyChanged(name, value);
            } catch (RemoteException e) {
                Log.w(TAG, "Failed to notify callback of property change: " + name, e);
            }
        }
        callbacks.finishBroadcast();
    }

    @Override
    public void onCreate() {
        super.onCreate();
        Log.d(TAG, "RenderingService.onCreate");
        qtService = new QtRaaSApplication(this, "OutpaceSquare");
        qtService.setStatusChangeListener(new QtQmlStatusChangeListener() {
            @Override
            public void onStatusChanged(QtQmlStatus status) {
                Log.d(TAG, "Qt status changed: " + status);
                if (status == QtQmlStatus.READY && !mQtReady) {
                    mQtReady = true;
                    Log.d(TAG, "Qt is READY — flushing " + mPropertyCache.size() + " cached properties");
                    flushCachedProperties();
                } else if (status == QtQmlStatus.ERROR) {
                    Log.e(TAG, "Qt reported ERROR status");
                }
            }
        });
    }

    private void flushCachedProperties() {
        for (Map.Entry<String, Object> entry : mPropertyCache.entrySet()) {
            try {
                Log.d(TAG, "Flushing cached property: " + entry.getKey() + " = " + entry.getValue());
                qtService.setProperty(entry.getKey(), entry.getValue());
            } catch (Exception e) {
                Log.e(TAG, "Failed to flush property " + entry.getKey(), e);
            }
        }
    }

    @Override
    public IBinder onBind(Intent intent) {
        Log.d(TAG, "onBind: client connected");
        return binder; // same binder instance for all bindings
    }

    @Override
    public boolean onUnbind(Intent intent) {
        Log.d(TAG, "onUnbind: client disconnected");
        return super.onUnbind(intent);
    }

    @Override
    public void onDestroy() {
        callbacks.kill();
        super.onDestroy();
    }
//! [service-class-end]
}
//! [service-class-end]
