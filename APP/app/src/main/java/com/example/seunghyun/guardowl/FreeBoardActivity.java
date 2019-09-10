package com.example.seunghyun.guardowl;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class FreeBoardActivity extends AppCompatActivity {
    String brd_id;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_free_board);
        String subject = getIntent().getExtras().getString("subject");
        String writer = getIntent().getExtras().getString("writer");
        String date = getIntent().getExtras().getString("date");
        String cnt = getIntent().getExtras().getString("cnt");
        String content = getIntent().getExtras().getString("content");

        brd_id = getIntent().getExtras().getString("brd_id");


        TextView tSubject = (TextView)findViewById(R.id.free_board_tv_subject_act);
        TextView tWriter = (TextView)findViewById(R.id.free_board_tv_writer_act);
        TextView tDate = (TextView)findViewById(R.id.freee_board_tv_date_act);
        TextView tCnt = (TextView)findViewById(R.id.free_board_tv_cnt_act);
        TextView tContent = (TextView)findViewById(R.id.free_board_tv_content_act);

        tSubject.setText(subject);
        tWriter.setText(writer);
        tDate.setText(date);
        tCnt.setText(cnt);
        tContent.setText(content);

        Button btnComment = (Button)findViewById(R.id.free_board_btn_comment_act);
        btnComment.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                Intent intent = new Intent(FreeBoardActivity.this, FreeBoardCommentActivity.class);
                SharedPreference.setAttribute(getApplicationContext(),"brd_id", brd_id);
                startActivity(intent);
            }
        });
        Button btnFinish = (Button)findViewById(R.id.free_board_btn_finish_act);
        btnFinish.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                finish();
            }
        });
    }
}
