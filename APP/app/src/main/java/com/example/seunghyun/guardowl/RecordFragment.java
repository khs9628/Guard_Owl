package com.example.seunghyun.guardowl;

import android.app.Service;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.ListView;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;
import java.util.ArrayList;

import static android.content.ContentValues.TAG;


public class RecordFragment extends Fragment {
    RecordItemData oItem;
    ArrayList<RecordItemData> oData;
    RecordListAdapter oAdapter;
    String sendmsg, id;
    int n, size;

    EditText etTmp;
    TextView tvStatus;
    private static final String TAG = "TcpClient";
    private boolean isConnected = false;

    private String mServerIP = null;
    private Socket mSocket = null;
    private PrintWriter mOut;
    private BufferedReader mIn;
    private Thread mReceiverThread = null;

    String element [];

    public static RecordFragment newInstance() {
        RecordFragment fragment = new RecordFragment();
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_record, container, false);
        id = SharedPreference.getAttribute(getContext(), "userId");
        sendmsg = "record_list";

        try{
            String result = new Task(sendmsg).execute(id, "record_list").get();

            String [] element = result.split("_");

            n=1;
            size = Integer.parseInt(element[0]);

            oData = new ArrayList<>();
            for(int i=0;i<size;i++){
                oItem = new RecordItemData();
                oItem.app_no = element[n++];
                oItem.app_safe_no = element[n++];
                oItem.app_type = element[n++];
                oItem.app_date = element[n++];
                oItem.app_stat = element[n++];
                oData.add(oItem);
            }
        }catch(Exception e){
            e.printStackTrace();
        }

        ListView listView = (ListView)view.findViewById(R.id.record_list);
        oAdapter = new RecordListAdapter(oData);
        listView.setAdapter(oAdapter);

        Button btnLogOut = (Button)view.findViewById(R.id.record_btn_logout);
        btnLogOut.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                SharedPreference.removeAttribute(getActivity(), "userId");
                SharedPreference.removeAttribute(getActivity(), "userPw");

                Intent intent = new Intent(getActivity(), MainActivity.class);
                startActivity(intent);
            }
        });

        etTmp = (EditText)view.findViewById(R.id.record_et_tmp);
        tvStatus = (TextView)view.findViewById(R.id.record_tv_status);

        Button btnOpen = (Button)view.findViewById(R.id.record_btn_open);
        btnOpen.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                String sendMessage = etTmp.getText().toString();
                if(sendMessage.length()>0){
                    if(!isConnected) Toast.makeText(getActivity(), "서버에 접속된 후 시도해주세요.", Toast.LENGTH_SHORT).show();
                    else{
                        new Thread(new SenderThread(sendMessage)).start();
                        Toast.makeText(getActivity(), element[1]+"번 보관함이 열렸습니다.", Toast.LENGTH_SHORT).show();
                        tvStatus.setText("서버에 연결되어 있지 않습니다.");
                    }
                }
            }
        });

        Button btnNfc = (Button)view.findViewById(R.id.record_btn_nfc);
        btnNfc.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                sendmsg = "nfc_list";
                try{
                    String result = new Task(sendmsg).execute(id, "nfc_list").get();
                    if(result.trim().length() == 12){
                        sendmsg = "nfc_write";
                        try{
                            result = new Task(sendmsg).execute(id, "nfc_write").get();
                            element = result.split("_");
                            if(element[0].trim().equals("success")){
                                Toast.makeText(getActivity(), "nfc 인증이 완료되었습니다.open 버튼을 눌러 보관함을 열어주세요.", Toast.LENGTH_LONG).show();
                                new Thread(new ConnectThread("192.168.43.10", 80)).start();
                            } else {
                                Toast.makeText(getActivity(), "신청 내역 중 하나를 선택해주세요.", Toast.LENGTH_SHORT).show();
                            }
                        }catch (Exception e){
                        }
                    }else{
                        Toast.makeText(getActivity(), "아직 관리자 승인을 받지 못했습니다.", Toast.LENGTH_LONG).show();
                    }
                }catch (Exception e){
                    e.printStackTrace();
                }

            }
        });
        return view;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();

        isConnected = false;
    }

    public class ConnectThread implements Runnable {

        private String serverIP;
        private int serverPort;

        ConnectThread(String ip, int port) {
            serverIP = ip;
            serverPort = port;
            tvStatus.setText("서버에 연결 중 입니다.......");
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
                    mIn = new BufferedReader(new InputStreamReader(mSocket.getInputStream(), "UTF-8"));
                    isConnected = true;
                } catch (IOException e) {

                    Log.e(TAG, ("ConnectThread:" + e.getMessage()));
                }
            }


            getActivity().runOnUiThread(new Runnable() {

                @Override
                public void run() {

                    if (isConnected) {

                        Log.d(TAG, "connected to " + serverIP);
                        tvStatus.setText("서버에 연결 되었습니다.");
                        //mReceiverThread = new Thread(new ArduinoActivity.ReceiverThread());
                        //mReceiverThread.start();
                    } else {

                        Log.d(TAG, "failed to connect to server " + serverIP);
                       tvStatus.setText("서버 연결에 실패하였습니다.");
                    }

                }
            });
        }
    }
    class SenderThread implements Runnable {

        private String msg;

        SenderThread(String msg) {
            this.msg = msg;
        }

        @Override
        public void run() {
            mOut.println(this.msg);
            mOut.flush();
            getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Log.d(TAG, "send message: " + msg);
                    //mConversationArrayAdapter.insert("Me - " + msg, 0);
                }
            });
        }
    }

    private class ReceiverThread implements Runnable {

        @Override
        public void run() {

            try {

                while (isConnected) {

                    if ( mIn ==  null ) {

                        Log.d(TAG, "ReceiverThread: mIn is null");
                        break;
                    }

                    final String recvMessage =  mIn.readLine();

                    if (recvMessage != null) {

                        getActivity().runOnUiThread(new Runnable() {

                            @Override
                            public void run() {
                                Log.d(TAG, "recv message: "+recvMessage);
                                //mConversationArrayAdapter.insert(mServerIP + " - " + recvMessage, 0);
                            }
                        });
                    }
                }

                Log.d(TAG, "ReceiverThread: thread has exited");
                if (mOut != null) {
                    mOut.flush();
                    mOut.close();
                }

                mIn = null;
                mOut = null;

                if (mSocket != null) {
                    try {
                        mSocket.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
            catch (IOException e) {

                Log.e(TAG, "ReceiverThread: "+ e);
            }
        }

    }
}

