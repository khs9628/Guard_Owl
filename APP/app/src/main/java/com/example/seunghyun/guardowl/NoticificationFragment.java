package com.example.seunghyun.guardowl;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

import java.util.ArrayList;


public class NoticificationFragment extends Fragment {
    NotificationItemData oItem;
    ArrayList<NotificationItemData> oData;
    ArrayList<NotificationItemData> searchData;
    NotificationListAdapter oAdapter;
    String sendmsg, id;
    EditText etSearch;
    TextView textView;
    Activity root;
    int n, size;

    public static NoticificationFragment newInstance() {
        NoticificationFragment fragment = new NoticificationFragment();
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_noticification, container, false);
        root = getActivity();

        id = SharedPreference.getAttribute(getContext(), "userId");
        sendmsg = "notification_list";

        try{
            String result = new Task(sendmsg).execute(id, "notification_list").get();

            String [] element = result.split("_");

            n=1;
            size = Integer.parseInt(element[0]);

            oData= new ArrayList<>();
            for(int i=0;i<size;i++){
                oItem = new NotificationItemData();
                oItem.id = element[n++];
                oItem.subject = element[n++];
                oItem.writer = element[n++];
                oItem.date = element[n++];
                oItem.cnt = element[n++];
                oItem.content = element[n++];
                oData.add(oItem);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        searchData = new ArrayList<>();
        searchData.addAll(oData);

        ListView listView = (ListView)view.findViewById(R.id.notification_list);
        oAdapter = new NotificationListAdapter(searchData);
        listView.setAdapter(oAdapter);

        textView = (TextView)view.findViewById(R.id.notification_tv_test);

        etSearch = view.findViewById(R.id.notification_et_search);
        etSearch.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
            }

            @Override
            public void afterTextChanged(Editable s) {
                String text = etSearch.getText().toString();
                search(text);
            }
        });

        Button btnLogOut = (Button) view.findViewById(R.id.notification_btn_logout);
        btnLogOut.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){

                SharedPreference.removeAttribute(getActivity(),"userId");
                SharedPreference.removeAttribute(getActivity(), "userPw");

                Intent intent = new Intent(getActivity(), MainActivity.class);
                startActivity(intent);
            }
        });

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                sendmsg = "board_write";
                try {
                    String result = new Task(sendmsg).execute(searchData.get(position).id, "board_write").get();
                    searchData.get(position).cnt = result.trim();

                    Intent intent = new Intent(getActivity(), NotificationActivity.class);
                    intent.putExtra("subject", searchData.get(position).subject);
                    intent.putExtra("writer", searchData.get(position).writer);
                    intent.putExtra("date", searchData.get(position).date);
                    intent.putExtra("cnt", searchData.get(position).cnt);
                    intent.putExtra("content", searchData.get(position).content);
                    startActivity(intent);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        });
        return view;
    }

    public void search(String charText) {

        // 문자 입력시마다 리스트를 지우고 새로 뿌려준다.
        searchData.clear();

        // 문자 입력이 없을때는 모든 데이터를 보여준다.
        if (charText.length() == 0) {
            searchData.addAll(oData);
        }
        // 문자 입력을 할때..
        else
        {
            // 리스트의 모든 데이터를 검색한다.
            for(int i = 0;i < oData.size(); i++)
            {
                // arraylist의 모든 데이터에 입력받은 단어(charText)가 포함되어 있으면 true를 반환한다.
                if (oData.get(i).subject.toLowerCase().contains(charText)||oData.get(i).writer.toLowerCase().contains((charText)))
                {
                    // 검색된 데이터를 리스트에 추가한다.
                    searchData.add(oData.get(i));
                }
            }
        }
        // 리스트 데이터가 변경되었으므로 아답터를 갱신하여 검색된 데이터를 화면에 보여준다.
        oAdapter.notifyDataSetChanged();
    }

}