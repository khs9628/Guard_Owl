package com.example.seunghyun.guardowl;

import android.os.AsyncTask;
import android.util.Log;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class Task extends AsyncTask<String, Void, String> {
    //public  static String ip ="192.168.43.61:8083";
    //public static  String ip = "192.168.43.8:8090";
    public static  String ip = "192.168.43.99:8181";
    String sendMsg, receiveMsg;
    //String serverip = "http://"+ip+"/GuardOwl/Android.jsp";
    //String serverip = "http://"+ip+"/android/Android";
    String serverip = "http://ec2-52-79-50-43.ap-northeast-2.compute.amazonaws.com:8080/android/Android"; // 연결할 jsp주소

    Task(String sendmsg){
        this.sendMsg = sendmsg;
    }
    @Override
    protected String doInBackground(String... strings) {
        try {
            String str;
            URL url = new URL(serverip);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestMethod("POST");
            OutputStreamWriter osw = new OutputStreamWriter(conn.getOutputStream());

            if(sendMsg.equals("login_list")){ //TaskLogin
                sendMsg = "login_list="+strings[0]
                        +"&pw_list="+strings[1]
                        +"&type="+strings[2];
            } else if(sendMsg.equals("signUp_write")){  //TaskSignUp
                sendMsg = "signUp_write="+strings[0]
                        + "&id_write="+strings[1]
                        + "&email_write="+strings[2]
                        + "&pw_write="+strings[3]
                        + "&phone_write="+strings[4]
                        + "&type="+strings[5];
            } else if(sendMsg.equals("signUp_list")){
                sendMsg = "signUp_list="+strings[0]
                        +"&type="+strings[1];
            } else if(sendMsg.equals("findPw_write")){  //TaskFindPw
                sendMsg = "findPw_write="+strings[0] //임시비밀번호 저장
                        +"&id_write="+strings[1]
                        +"&type="+strings[2];
            } else if(sendMsg.equals("findPw_list")){
                sendMsg = "findPw_list="+strings[0]
                        +"&name_list="+strings[1]
                        +"&phone_list="+strings[2]
                        +"&type="+strings[3];
            } else if(sendMsg.equals("reviseInfo_write")){  //TaskReviseInfo
                sendMsg = "reviseInfo_write="+strings[0]
                        + "&index_write="+strings[1]
                        + "&mem_no_write="+strings[2]
                        + "&type="+strings[3];
            } else if(sendMsg.equals("reviseInfo_list")){
                sendMsg = "reviseInfo_list="+strings[0]
                        +"&type="+strings[1];
            }  else if(sendMsg.equals("inquire_list")){
                sendMsg = "inquire_list="+strings[0]
                        +"&type="+strings[1];
            }  else if(sendMsg.equals("notification_list")){
                sendMsg = "notification_list="+strings[0]
                        +"&type="+strings[1];
            }  else if(sendMsg.equals("free_board_list")){
                sendMsg = "free_board_list="+strings[0]
                        +"&type="+strings[1];
            }  else if(sendMsg.equals("board_write")){
            sendMsg = "board_write="+strings[0]
                    +"&type="+strings[1];
            }  else if(sendMsg.equals("comment_list")){
                sendMsg = "comment_list="+strings[0]
                        +"&type="+strings[1];
            }  else if(sendMsg.equals("comment_write")){
                sendMsg = "comment_write="+strings[0]
                        +"&cmt_writer="+strings[1]
                        +"&cmt_content="+strings[2]
                        +"&type="+strings[3];
            }  else if(sendMsg.equals("free_board_write")){
                sendMsg = "free_board_write="+strings[0]
                        +"&subject="+strings[1]
                        +"&content="+strings[2]
                        +"&type="+strings[3];
            }  else if(sendMsg.equals("safe_list")){
                sendMsg = "safe_list="+strings[0]
                        +"&type="+strings[1];
            }  else if(sendMsg.equals("receipt_write")){
                sendMsg = "receipt_write="+strings[0]
                        +"&safe_no="+strings[1]
                        +"&content="+strings[2]
                        +"&type="+strings[3];
            }  else if(sendMsg.equals("receipt_list")){
                sendMsg = "receipt_list="+strings[0]
                        +"&type="+strings[1];
            }  else if(sendMsg.equals("keep_write")){
                sendMsg = "keep_write="+strings[0]
                        +"&safe_no="+strings[1]
                        +"&name="+strings[2]
                        +"&class="+strings[3]
                        +"&remark="+strings[4]
                        +"&content="+strings[5]
                        +"&type="+strings[6];
            }  else if(sendMsg.equals("keep_list")){
                sendMsg = "keep_list="+strings[0]
                        +"&type="+strings[1];
            }  else if(sendMsg.equals("record_list")){
                sendMsg = "record_list="+strings[0]
                        +"&type="+strings[1];
            }  else if(sendMsg.equals("record_write")){
                sendMsg = "record_write="+strings[0]
                        +"&type="+strings[1];
            }  else if(sendMsg.equals("service_list")){
                sendMsg = "service_list="+strings[0]
                        +"&type="+strings[1];
            } else if(sendMsg.equals("nfc_list")){
                sendMsg = "nfc_list="+strings[0]
                        +"&type="+strings[1];
            } else if(sendMsg.equals("nfc_write")){
                sendMsg = "nfc_write="+strings[0]
                        +"&type="+strings[1];
            }

            osw.write(sendMsg);
            osw.flush();
            if(conn.getResponseCode() == conn.HTTP_OK) {
                InputStreamReader tmp = new InputStreamReader(conn.getInputStream(), "UTF-8");
                BufferedReader reader = new BufferedReader(tmp);
                StringBuffer buffer = new StringBuffer();
                while ((str = reader.readLine()) != null) {
                    buffer.append(str);
                }
                receiveMsg = buffer.toString();
            } else {
                Log.i("통신 결과", conn.getResponseCode()+"에러");
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return receiveMsg;
    }
}
