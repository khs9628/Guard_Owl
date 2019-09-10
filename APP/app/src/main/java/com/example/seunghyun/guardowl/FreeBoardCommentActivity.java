package com.example.seunghyun.guardowl;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

import java.util.ArrayList;

public class FreeBoardCommentActivity extends AppCompatActivity {
    String brd_id, cmt_content, id, sendmsg;
    int n,size;
    CommentItemData oItem;
    ArrayList<CommentItemData> oData = new ArrayList<>();
    CommentListAdapter oAdapter;
    EditText tCommentContent;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_free_board_comment);

        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);

        id = SharedPreference.getAttribute(getApplicationContext(), "userId");
        brd_id = SharedPreference.getAttribute(getApplicationContext(), "brd_id");
        sendmsg = "comment_list";

        try{
            String result = new Task(sendmsg).execute(brd_id, "comment_list").get();
            String [] element = result.split("_");

            n=1;
            size = Integer.parseInt(element[0]);

            for(int i=0;i<size;i++){
                oItem = new CommentItemData();
                oItem.id = element[n++];
                oItem.writer = element[n++];
                oItem.date = element[n++];
                oItem.content = element[n++];
                oData.add(oItem);
            }
        }catch(Exception e){
            e.printStackTrace();
        }


        ListView listView = (ListView)findViewById(R.id.free_board_comment_list_act);
        oAdapter = new CommentListAdapter(oData);
        listView.setAdapter(oAdapter);

        final TextView tCommentCnt = (TextView)findViewById(R.id.free_board_comment_cnt_act);
        tCommentCnt.setText(Integer.toString(size));
        tCommentCnt.setText(Integer.toString(oData.size()));

        tCommentContent = (EditText)findViewById(R.id.free_board_comment_et_input_comment);

        Button btnBack = (Button)findViewById(R.id.free_board_comment_btn_back_act);
        btnBack.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                SharedPreference.removeAttribute(getApplicationContext(), "brd_id");
                finish();
            }
        });
        Button btnWrite = (Button)findViewById(R.id.free_board_comment_btn_write_act);
        btnWrite.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                sendmsg = "comment_write";
                cmt_content = tCommentContent.getText().toString();
                try{
                    String result = new Task(sendmsg).execute(brd_id, id, cmt_content, "comment_write", "cmt_writer", "cmt_content").get();
                    String[] _element = result.split("_");

                    oItem = new CommentItemData();
                    oItem.id = _element[0];
                    oItem.writer = _element[1];
                    oItem.date = _element[2];
                    oItem.content = _element[3];
                    oData.add(oItem);

                    oAdapter.notifyDataSetChanged();

                }catch(Exception e){
                    e.printStackTrace();
                }
            }
        });

    }
}
