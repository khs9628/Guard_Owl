package com.example.seunghyun.guardowl;

import android.app.Activity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class InquirePopupActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_inquire_popup);

        String safe_no = getIntent().getExtras().getString("safe_no");
        String item_name = getIntent().getExtras().getString("item_name");
        String start_date = getIntent().getExtras().getString("start_date");
        String end_date = getIntent().getExtras().getString("end_date");
        String item_class = getIntent().getExtras().getString("item_class");
        String item_remark = getIntent().getExtras().getString("item_remark");

        TextView tSafeNo = (TextView)findViewById(R.id.popup_no);
        TextView tName = (TextView)findViewById(R.id.popup_name);
        TextView tStart = (TextView)findViewById(R.id.popup_start);
        TextView tEnd = (TextView)findViewById(R.id.popup_end);
        TextView tClass = (TextView)findViewById(R.id.popup_class);
        TextView tRemark = (TextView)findViewById(R.id.popup_remark);

        tSafeNo.setText(safe_no);
        tName.setText(item_name);
        tStart.setText(start_date);
        tEnd.setText(end_date);
        tClass.setText(item_class);
        tRemark.setText(item_remark);

        Button btnConfirm = (Button)findViewById(R.id.popup_btn_confirm);
        btnConfirm.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                finish();
            }
        });


    }
}
