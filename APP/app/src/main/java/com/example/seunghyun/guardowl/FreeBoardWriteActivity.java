package com.example.seunghyun.guardowl;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class FreeBoardWriteActivity extends AppCompatActivity {
    EditText etSubject, etContent;
    String sendmsg, id;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_free_board_write);

        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);

        etSubject = (EditText)findViewById(R.id.free_board_write_et_subject_act);
        etContent = (EditText)findViewById(R.id.free_board_write_et_content_act);

        Button btnWrite = (Button)findViewById(R.id.free_board_write_btn_write_act);
        btnWrite.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                String subject = etSubject.getText().toString();
                String content = etContent.getText().toString();
                id = SharedPreference.getAttribute(getApplicationContext(), "userId");

                sendmsg = "free_board_write";
                try{
                    String result = new Task(sendmsg).execute(id, subject, content, "free_board_write", "subject", "content").get();
                    Toast.makeText(getApplicationContext(), "게시글 등록이 완료되었습니다.", Toast.LENGTH_SHORT).show();

                    Intent intent =  new Intent(FreeBoardWriteActivity.this, IntergratedActivity.class );
                    startActivity(intent);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        });

        Button btnFinish = (Button)findViewById(R.id.free_board_write_btn_finish_act);
        btnFinish.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                finish();
            }
        });


    }
}
