package com.example.seunghyun.guardowl;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.ArrayList;

public class FreeBoardListAdapter extends BaseAdapter {
    LayoutInflater inflater = null;
    FreeBoardItemData item = new FreeBoardItemData();
    private ArrayList<FreeBoardItemData> m_oData = null;

    public FreeBoardListAdapter(ArrayList<FreeBoardItemData> _oData){
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
    public View getView(int position, View convertView, ViewGroup parent){
        if (convertView == null){
            final Context context = parent.getContext();

            if(inflater == null){
                inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            }
            convertView = inflater.inflate(R.layout.board_list_item, parent, false);
        }

        TextView tSubject = (TextView) convertView.findViewById(R.id.notification_tv_subject);
        TextView tWriter = (TextView) convertView.findViewById(R.id.notification_tv_writer);
        TextView tDate = (TextView) convertView.findViewById(R.id.notification_tv_date);
        TextView tCnt = (TextView) convertView.findViewById(R.id.notification_tv_cnt);
        TextView tComment = (TextView)convertView.findViewById(R.id.notification_tv_comment);

        tSubject.setText(m_oData.get(position).subject);
        tWriter.setText((m_oData.get(position).writer));
        tDate.setText(m_oData.get(position).date);
        tCnt.setText(m_oData.get(position).cnt);
        tComment.setText("[ "+m_oData.get(position).comment+" ]");

        return convertView;
    }
}
