package com.example.seunghyun.guardowl;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

public class RequestAdminFragment extends Fragment {

    ViewPager viewPager;
    ViewPagerAdapter viewPagerAdapter;

    public static  RequestAdminFragment newInstance() {
        RequestAdminFragment fragment = new  RequestAdminFragment();
        return fragment;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_request_admin, container, false);
        viewPager = (ViewPager) view.findViewById(R.id.viewpager_request);
        viewPagerAdapter = new RequestAdminFragment.ViewPagerAdapter(getChildFragmentManager());
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
                return ReceiptFragment.newInstance();
            } else {
                return KeepFragment.newInstance();
            }
        }

        @Override
        public CharSequence getPageTitle(int position) {
            if (position == 0) {
                return "수령 신청";
            } else {
                return "보관 신청";
            }
        }
    }
}