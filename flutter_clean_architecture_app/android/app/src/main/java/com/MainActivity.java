package com;

import io.flutter.embedding.android.FlutterActivity;
import android.content.ContentResolver;
import android.content.Context;
import android.media.RingtoneManager;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "dexterx.dev/flutter_local_notifications_example")
                .setMethodCallHandler((call, result) -> {
                    if ("drawableToUri".equals(call.method)) {
                        String resourceName = call.arguments.toString();
                        int resourceId = getResources().getIdentifier(resourceName, "drawable", getPackageName());
                        result.success(resourceToUriString(getApplicationContext(), resourceId));
                    }
                    if ("getAlarmUri".equals(call.method)) {
                        result.success(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM).toString());
                    }
                });
    }

    private String resourceToUriString(Context context, int resId) {
        return ContentResolver.SCHEME_ANDROID_RESOURCE + "://"
                + context.getResources().getResourcePackageName(resId) + "/"
                + context.getResources().getResourceTypeName(resId) + "/"
                + context.getResources().getResourceEntryName(resId);
    }
}
