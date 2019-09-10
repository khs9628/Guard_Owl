package com.example.seunghyun.guardowl;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.TextView;
import android.widget.ThemedSpinnerAdapter;

import org.w3c.dom.Text;

import java.io.File;
import java.util.ArrayList;

public class NotificationListAdapter extends BaseAdapter{
    LayoutInflater inflater = null;
    NotificationItemData item = new NotificationItemData();
    private ArrayList<NotificationItemData> m_oData = null;

    public NotificationListAdapter(ArrayList<NotificationItemData> _oData) {
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
        }
        convertView = inflater.inflate(R.layout.board_list_item, parent, false);

        TextView tSubject = (TextView) convertView.findViewById(R.id.notification_tv_subject);
        TextView tWriter = (TextView) convertView.findViewById(R.id.notification_tv_writer);
        TextView tDate = (TextView) convertView.findViewById(R.id.notification_tv_date);
        TextView tCnt = (TextView) convertView.findViewById(R.id.notification_tv_cnt);

        tSubject.setText(m_oData.get(position).subject);
        tWriter.setText((m_oData.get(position).writer));
        tDate.setText(m_oData.get(position).date);
        tCnt.setText(m_oData.get(position).cnt);

        return convertView;
    }

}
