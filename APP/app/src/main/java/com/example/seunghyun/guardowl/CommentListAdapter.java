package com.example.seunghyun.guardowl;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.ArrayList;

public class CommentListAdapter extends BaseAdapter {
    LayoutInflater inflater = null;
    CommentItemData item = new CommentItemData();
    private ArrayList<CommentItemData> m_oData = null;

    public CommentListAdapter(ArrayList<CommentItemData> _oData) {
        m_oData = _oData;
    }

    @Override
    public int getCount() {
        Log.i("Tag", "getCount");
        return m_oData.size();
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        if (convertView == null) {
            final Context context = parent.getContext();

            if (inflater == null) {
                inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            }
            convertView = inflater.inflate(R.layout.comment_list_item, parent, false);
        }

        TextView tWriter = (TextView) convertView.findViewById(R.id.free_board_comment_tv_writer_act);
        TextView tDate = (TextView) convertView.findViewById(R.id.free_board_comment_date_act);
        TextView tContent = (TextView) convertView.findViewById(R.id.free_board_comment_content_act);

        tWriter.setText((m_oData.get(position).writer));
        tDate.setText(m_oData.get(position).date);
        tContent.setText(m_oData.get(position).content);

        return convertView;
    }

}

