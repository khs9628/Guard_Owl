package com.example.seunghyun.guardowl;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.GridView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

public class InquireItemFragment extends Fragment {
    int i, n, size, fullSafe;
    InquireItemData oItem;
    Activity root;
    ArrayList<InquireItemData> oData;
    String sendmsg, id;

    public static  InquireItemFragment newInstance() {
        InquireItemFragment fragment = new  InquireItemFragment();
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        root = getActivity();
        View view =  inflater.inflate(R.layout.fragment_inquire_item, container, false);

        id = SharedPreference.getAttribute(getContext(), "userId");
        sendmsg = "inquire_list";

        try{
            String result = new Task(sendmsg).execute(id, "inquire_list").get();

            String [] element = result.split("_");

            n=1; fullSafe=0;
            size = Integer.parseInt(element[0]);

            oData= new ArrayList<>();
            for(i=0;i<size;i++){
                oItem = new InquireItemData();
                oItem.safe_no = element[n++];
                oItem.item_name = element[n++];
                oItem.start_date = element[n++];
                oItem.end_date = element[n++];
                oItem.item_class = element[n++];
                oItem.item_remark= element[n++];
                oItem.item_stat = element[n];
                if(element[n].trim().equals("F")){
                    fullSafe++;
                }n++;
                oData.add(oItem);
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        GridView gridView = (GridView)view.findViewById(R.id.inquire_grid);
        final InquireGridAdapter oAdapter = new InquireGridAdapter(oData);
        gridView.setAdapter(oAdapter);

        TextView tFullSafe = (TextView) view.findViewById(R.id.inquire_full);
        TextView tTotalSafe = (TextView) view.findViewById(R.id.inquire_total);

        tFullSafe.setText(Integer.toString(fullSafe));
        tTotalSafe.setText(Integer.toString(size));

        gridView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                if(oData.get(position).item_stat.equals("F")){
                    Intent intent = new Intent(getActivity(), InquirePopupActivity.class);
                    intent.putExtra("safe_no", oData.get(position).safe_no);
                    intent.putExtra("item_name", oData.get(position).item_name);
                    intent.putExtra("start_date", oData.get(position).start_date);
                    intent.putExtra("end_date", oData.get(position).end_date);
                    intent.putExtra("item_class", oData.get(position).item_class);
                    intent.putExtra("item_remark", oData.get(position).item_remark);
                    startActivity(intent);
                }
            }
        });

        Button btnLogOut = (Button) view.findViewById(R.id.inquire_btn_logout);
        btnLogOut.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){

                SharedPreference.removeAttribute(getActivity(),"userId");
                SharedPreference.removeAttribute(getActivity(), "userPw");

                Intent intent = new Intent(getActivity(), MainActivity.class);
                startActivity(intent);
            }
        });
        return view;
    }
}