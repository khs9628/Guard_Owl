package com.example.seunghyun.guardowl;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.os.Build;
import android.os.Handler;
import android.os.IBinder;
import android.support.v4.app.NotificationCompat;
import android.util.Log;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class GoService extends Service {
    NotificationManager Notifi_M;
    myServiceHandler handler;
    ServiceThread thread;
    Notification Notifi;
    String sendmsg;

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId){
        Notifi_M = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);
        myServiceHandler handler = new myServiceHandler();
        thread = new ServiceThread(handler);
        thread.start();
        return START_STICKY;
    }

    public void onDestroy(){
        thread = new ServiceThread(handler);
        thread.stopForever();
        thread = null;
        //super.onDestroy();
    }

    class myServiceHandler extends Handler{
        @Override
        public void handleMessage(android.os.Message msg){
            sendmsg = "service_list";
            String id = SharedPreference.getAttribute(getApplicationContext(), "userId");
            try{
                String result = new Task(sendmsg).execute(id, "service_list").get();
                String [] element = result.split("_");

                if(element[0].equals("Y")) {
                    Intent intent = new Intent(GoService.this, MainActivity.class);
                    PendingIntent pendingIntent = PendingIntent.getActivity(GoService.this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT);
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        Log.e("oreo", "oreo");
                        NotificationChannel mChannel = new NotificationChannel("guard_owl", "guard_owl", NotificationManager.IMPORTANCE_DEFAULT);
                        mChannel.setDescription("Notification channel for Guard_Owl application");
                        mChannel.enableLights(true);
                        mChannel.setLightColor(Color.GREEN);
                        mChannel.enableVibration(true);
                        mChannel.setVibrationPattern(new long[]{100, 200, 100, 200});
                        mChannel.setLockscreenVisibility(Notification.VISIBILITY_PRIVATE);
                        Notifi_M.createNotificationChannel(mChannel);

                        Notification.Builder builder = new Notification.Builder(getApplicationContext(), "guard_owl")
                                .setContentTitle("관리자가 "+element[1]+"번 보관함에 대한 신청을 승인하였습니다.")
                               // .setContentText("관리자가 " + safe_no[i] + "번 보관함에 대한 " + app_type[i] + "을 승인하였습니다.")
                                .setSmallIcon(R.drawable.proto_logo)
                                .setAutoCancel(true)
                                .setContentIntent(pendingIntent);

                        Notifi_M.notify(7597, builder.build());
                    } else {
                        Notifi = new Notification.Builder(getApplicationContext())
                                .setContentTitle("Content Title")
                                .setContentText("Content text")
                                .setSmallIcon(R.drawable.proto_logo)
                                .setTicker("알림")
                                .setContentIntent(pendingIntent)
                                .build();

                        Notifi.defaults = Notification.DEFAULT_SOUND;
                        Notifi.flags = Notification.FLAG_ONLY_ALERT_ONCE;
                        Notifi.flags = Notification.FLAG_AUTO_CANCEL;
                        Notifi_M.notify(7597, Notifi);
                    }
                }
            }catch (Exception e){ }

        }
    }

}


