package com.example.seunghyun.guardowl;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;


public class ReviseFragment extends Fragment {
    String sSavedPwd;
    EditText etPwd;

    public static ReviseFragment newInstance() {
        ReviseFragment fragment = new  ReviseFragment();
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_revise, container, false);
        etPwd = view.findViewById(R.id.revise_pwd);
        sSavedPwd = SharedPreference.getAttribute(getContext(), "userPwd");

        Button btnConfirm = view.findViewById(R.id.revise_btn_confirm);
        btnConfirm.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v){
                String sPwd = etPwd.getText().toString();
                if(sPwd.equals(sSavedPwd)){
                    Intent intent = new Intent(getActivity(), ReviseActivity.class);
                    startActivity(intent);
                }
                else{
                    Activity root = getActivity();
                    Toast.makeText(root, "비밀번호를 잘못 입력하셨습니다.", Toast.LENGTH_SHORT).show();
                }
            }
        });
        return view;
    }
}
