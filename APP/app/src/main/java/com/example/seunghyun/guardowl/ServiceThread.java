package com.example.seunghyun.guardowl;

import android.os.Handler;

public class ServiceThread extends Thread implements Runnable {
    Handler handler;
    boolean isRun = false;

    public ServiceThread(Handler handler){
        this.handler = handler;
    }

    public void stopForever(){
        synchronized (this){
            this.isRun = true;
        }
    }

    public void run() {
        while (!isRun){
            handler.sendEmptyMessage(0);
            try{
                Thread.sleep(5000);
            }catch (Exception e){
            }
        }
    }
}
