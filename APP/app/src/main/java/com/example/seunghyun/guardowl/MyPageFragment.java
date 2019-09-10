package com.example.seunghyun.guardowl;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;


public class MyPageFragment extends Fragment {

    ViewPager viewPager;
    MyPageFragment.ViewPagerAdapter viewPagerAdapter;

    public static  MyPageFragment newInstance() {
        MyPageFragment fragment = new  MyPageFragment();
        return fragment;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_my_page, container, false);
        viewPager = (ViewPager) view.findViewById(R.id.viewpager_my_page);
        viewPagerAdapter = new MyPageFragment.ViewPagerAdapter(getChildFragmentManager());
        viewPager.setAdapter(viewPagerAdapter);
        return view;
    }

    private static class ViewPagerAdapter extends FragmentStatePagerAdapter {
        private static final int NUM_ITEM = 2;

        public ViewPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public int getCount() {
            return NUM_ITEM;
        }

        @Override
        public Fragment getItem(int position) {
            if (position == 0) {
                return RecordFragment.newInstance();
            } else {
                return ReviseFragment.newInstance();
            }
        }

        @Override
        public CharSequence getPageTitle(int position) {
            if (position == 0) {
                return "나의 열람기록";
            } else {
                return "개인정보 수정";
            }
        }
    }
}