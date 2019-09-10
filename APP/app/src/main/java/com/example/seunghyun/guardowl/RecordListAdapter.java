package com.example.seunghyun.guardowl;

import android.content.Context;
import android.graphics.Color;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

public class RecordListAdapter extends BaseAdapter {
    LayoutInflater inflater = null;
    RecordItemData item = new RecordItemData();
    private ArrayList<RecordItemData> m_oData = null;
    Context context;
    String sendmsg;

    public RecordListAdapter(ArrayList<RecordItemData> _oData){
        m_oData = _oData;
    }

    @Override
    public int getCount(){
        Log.i("Tag", "getCount");
        return m_oData.size();
    }

    @Override
    public Object getItem(int position){return null;}

    @Override
    public long getItemId(int position){return 0;}

    @Override
    public View getView(final int position, View convertView, ViewGroup parent){
        if (convertView == null){
            context = parent.getContext();

            if(inflater == null){
                inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            }
            convertView = inflater.inflate(R.layout.record_list_item, parent, false);
        }

        TextView tSafe_no = (TextView) convertView.findViewById(R.id.record_tv_safe_no);
        TextView tType = (TextView) convertView.findViewById(R.id.record_tv_type);
        TextView tDate = (TextView) convertView.findViewById(R.id.record_tv_date);
        final Button btnStat = (Button) convertView.findViewById(R.id.record_btn_stat);

        tSafe_no.setText(m_oData.get(position).app_safe_no);
        tDate.setText(m_oData.get(position).app_date);
        btnStat.setOnClickListener(new Button.OnClickListener(){
            public void onClick(View v){
                sendmsg = "record_write";
                try{
                    String result = new Task(sendmsg).execute(m_oData.get(position).app_no, "record_write").get();
                    if(result.trim().equals("success")) {
                        Toast.makeText(context, "nfc 인증 버튼을 눌러 리더기에 태그해주세요.", Toast.LENGTH_SHORT).show();
                    }
                    else{
                        Toast.makeText(context, "nfc 인증을 대기 중인 승인 신청이 이미 있습니다.", Toast.LENGTH_SHORT).show();
                    }
                }catch (Exception e){

                }

            }
        });

        if(m_oData.get(position).app_type.trim().equals("K")) {
            tType.setText(" (보관)");
        } else{
            tType.setText(" (수령)");
        }

        if(m_oData.get(position).app_stat.trim().equals("N")) {
            btnStat.setText("미승인");
            btnStat.setClickable(false);
        }else if(m_oData.get(position).app_stat.trim().equals("R")){
        btnStat.setText("승인거절");
        btnStat.setClickable(false);
    }
        else if (m_oData.get(position).app_stat.trim().equals("E")) {
            btnStat.setText("인증");
            btnStat.setClickable(true);
        } else {
            btnStat.setText("완료");
            btnStat.setClickable(false);
        }

        return convertView;
    }
}

