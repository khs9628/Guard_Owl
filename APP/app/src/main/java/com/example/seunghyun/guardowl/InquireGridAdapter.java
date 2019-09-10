package com.example.seunghyun.guardowl;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import org.w3c.dom.Text;

import java.util.ArrayList;

public class InquireGridAdapter extends BaseAdapter {
    LayoutInflater inflater = null;
    InquireItemData item = new InquireItemData();
    private ArrayList<InquireItemData> m_oData = null;
    private int nGridCnt = 0;
    private int fullSafe = 0;

    public InquireGridAdapter(ArrayList<InquireItemData> _oData){
        m_oData = _oData;
        nGridCnt = m_oData.size();
    }

    @Override
    public int getCount(){
        Log.i("Tag", "getCount");
        return nGridCnt;
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
            convertView = inflater.inflate(R.layout.inquire_grid_item, parent, false);
        }
        TextView tText = (TextView) convertView.findViewById(R.id.inquire_item_text);
        tText.setText(m_oData.get(position).safe_no);

        if(m_oData.get(position).item_stat.trim().equals("F")){
            ImageView img = (ImageView) convertView.findViewById(R.id.inquire_item_img);
            img.setImageResource(R.drawable.full);
            fullSafe++;
        }

        return convertView;
    }
}
