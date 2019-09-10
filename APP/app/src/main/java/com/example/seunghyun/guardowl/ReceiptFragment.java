package com.example.seunghyun.guardowl;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

public class ReceiptFragment extends Fragment {
    String safe_no, sendmsg, id, content;
    String [] spinnerItem;
    EditText etContent;
    public static ReceiptFragment newInstance() {
        ReceiptFragment fragment = new  ReceiptFragment();
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_receipt, container, false);

        sendmsg = "safe_list";
        id = SharedPreference.getAttribute(getActivity(), "userId");
        try{
            String result = new Task(sendmsg).execute("R", "safe_list").get();
            spinnerItem = result.split("_");
        }catch (Exception e){
            e.printStackTrace();
        }
        Spinner spinner = (Spinner)view.findViewById(R.id.receipt_spinner);
        ArrayAdapter spinnerAdapter = new ArrayAdapter(getActivity(), R.layout.support_simple_spinner_dropdown_item,spinnerItem);
        spinner.setAdapter(spinnerAdapter);

        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                safe_no = parent.getItemAtPosition(position).toString();
            }
            @Override
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });

        etContent = (EditText)view.findViewById(R.id.receipt_et_content);
        Button btnApplication = (Button)view.findViewById(R.id.receipt_btn_application);
        btnApplication.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                content = etContent.getText().toString();
                sendmsg = "receipt_write";
                try{
                    String result = new Task(sendmsg).execute(id, safe_no, content, "receipt_write", "safe_no", "content").get();

                    if(result.trim().equals("success")){
                        Toast.makeText(getActivity(), "관리자 승인 후, NFC로 인증해주세요", Toast.LENGTH_LONG).show();
                    }
                    else if(result.trim().equals("fail")){
                        Toast.makeText(getActivity(), "신청 중인 수령 신청이 이미 있습니다.", Toast.LENGTH_LONG).show();
                    }

                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        });
        Button btnLogOut = (Button)view.findViewById(R.id.receipt_btn_logout);
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

