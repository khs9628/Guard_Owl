package com.example.seunghyun.guardowl;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {
    EditText InputId, InputPw;
    String savedId, oj;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        /****알림 서비스 시작***/
        Intent intent = new Intent(MainActivity.this, GoService.class);
        this.startService(intent);

        /***회원가입 엑티비티로 이동***/
        Button btnSign = (Button)findViewById(R.id.signUp);
        btnSign.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                Intent intent1 = new Intent(MainActivity.this, SignActivity.class);
                startActivity(intent1);
            }
        });

        /***패스워드찾기 엑티비티로 이동***/
        Button btnFind = (Button)findViewById(R.id.findPw);
        btnFind.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                Intent intent2 = new Intent(MainActivity.this, FindPwActivity.class);
                startActivity(intent2);
            }
        });

        /***로그인 작업***/
        InputId = (EditText)findViewById(R.id.userid);
        InputPw = (EditText)findViewById(R.id.userPw);

        Button btnLogin = (Button)findViewById(R.id.login);
        btnLogin.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                String id = InputId.getText().toString();
                String pw = InputPw.getText().toString();
                String sendmsg = "login_list";
                try {
                    String result = new Task(sendmsg).execute(id,pw, "login_list","pw_lsit").get();
                    String oj = result;

                    /***관리자 미승인 계정일 경우***/
                    if(oj.trim().equals("yet")){
                        Toast.makeText(getApplicationContext(), "관리자 승인이 필요한 계정입니다.",
                                Toast.LENGTH_SHORT).show();
                    }
                    /***유효한 사용자일 경우***/
                    else if (oj.trim().length() > 0) {
                        Toast.makeText(getApplicationContext(), oj+"님 환영합니다.",
                                Toast.LENGTH_SHORT).show();

                        SharedPreference.setAttribute(getApplicationContext(),"userId",id);
                        SharedPreference.setAttribute(getApplicationContext(),"userPwd",pw);
                        //SharedPreference.setAttribute(getApplicationContext(),"status","0");

                        Intent intent = new Intent(MainActivity.this, IntergratedActivity.class);
                        startActivity(intent);
                    /***ID나 PW가 일치하지 않을 경우***/
                    } else {
                        Toast.makeText(getApplicationContext(), "아이디 혹은 비밀번호를 잘못 입력하셨습니다.",
                                Toast.LENGTH_SHORT).show();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });

    }
}