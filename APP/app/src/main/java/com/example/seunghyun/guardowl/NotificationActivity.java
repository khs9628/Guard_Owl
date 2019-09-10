package com.example.seunghyun.guardowl;

import android.content.Intent;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import org.w3c.dom.Text;

public class NotificationActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_notification);

        String subject = getIntent().getExtras().getString("subject");
        String writer = getIntent().getExtras().getString("writer");
        String date = getIntent().getExtras().getString("date");
        String cnt = getIntent().getExtras().getString("cnt");
        String content = getIntent().getExtras().getString("content");

        TextView tSubject = (TextView)findViewById(R.id.notification_tv_subject_act);
        TextView tWriter = (TextView)findViewById(R.id.notification_tv_writer_act);
        TextView tDate = (TextView)findViewById(R.id.notification_tv_date_act);
        TextView tCnt = (TextView)findViewById(R.id.notification_tv_cnt_act);
        TextView tContent = (TextView)findViewById(R.id.notification_tv_content_act);

        tSubject.setText(subject);
        tWriter.setText(writer);
        tDate.setText(date);
        tCnt.setText(cnt);
        tContent.setText(content);

        Button btnFinish = (Button)findViewById(R.id.notification_btn_finish_act);
        btnFinish.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                finish();
            }
        });
    }
}
