package com.example.seunghyun.guardowl;

import android.util.Log;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;

public class ArduinoThread extends Thread implements Runnable{

    private  static final String TAG = "TCPClient";
    private  boolean isConnected = false;

    private String mServerIP = null;
    private Socket mSocket = null;
    private PrintWriter mOut;

    private static  final String SERVER_IP="192.168.43.10";
    private  static final int SERVER_PORT = 80;

    public void stopForever(){
        synchronized (this){
            this.isConnected = false;
        }
    }

    public void run(){
        Socket socket = null;

        try{
            socket = new Socket();
            socket.connect(new InetSocketAddress(SERVER_IP, SERVER_PORT));

            String message = "T";
            byte[] as = message.getBytes("UTF-8");
            OutputStream os = mSocket.getOutputStream();
            os.write(as);

        }catch (IOException e){
            e.printStackTrace();
        }finally {
            try{
                if(socket != null && !socket.isClosed()){
                    socket.close();
                }
            }catch (IOException e){
                e.printStackTrace();
            }
        }
        /*
       new Thread(new ConnectThread("192,168.43.10", 80)).start();
            String sendMessage = "T";
            if(!isConnected) stopForever();
            else{
                new Thread(new SenderThread(sendMessage)).start();
            }
        */
    }

    public class ConnectThread implements Runnable {

        private String serverIP;
        private int serverPort;

        ConnectThread(String ip, int port) {
            serverIP = ip;
            serverPort = port;
        }
        @Override
        public void run() {
            try {
                mSocket = new Socket(serverIP, serverPort);
                //ReceiverThread: java.net.SocketTimeoutException: Read timed out 때문에 주석처리
                //mSocket.setSoTimeout(3000);
                mServerIP = mSocket.getRemoteSocketAddress().toString();

            } catch( UnknownHostException e )
            {
                Log.d(TAG,  "ConnectThread: can't find host");
            }
            catch( SocketTimeoutException e )
            {
                Log.d(TAG, "ConnectThread: timeout");
            }
            catch (Exception e) {

                Log.e(TAG, ("ConnectThread:" + e.getMessage()));
            }

            if (mSocket != null) {
                try {
                    mOut = new PrintWriter(new BufferedWriter(new OutputStreamWriter(mSocket.getOutputStream(), "UTF-8")), true);
                    //mIn = new BufferedReader(new InputStreamReader(mSocket.getInputStream(), "UTF-8"));

                    isConnected = true;
                } catch (IOException e) {
                    Log.e(TAG, ("ConnectThread:" + e.getMessage()));
                }
            }
        }
    }

    public class SenderThread implements Runnable {

        private String msg;

        SenderThread(String msg) {
            this.msg = msg;
        }

        @Override
        public void run() {
            mOut.println(this.msg);
            mOut.flush();
        }
    }
}
