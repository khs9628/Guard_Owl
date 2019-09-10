package com.example.seunghyun.guardowl;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

public class BoardFragment extends Fragment {

    ViewPager viewPager;
    ViewPagerAdapter viewPagerAdapter;

    public static BoardFragment newInstance() {
        BoardFragment fragment = new BoardFragment();
        return fragment;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_board, container, false);
        viewPager = (ViewPager) view.findViewById(R.id.viewpager_board);
        viewPagerAdapter = new ViewPagerAdapter(getChildFragmentManager());
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
                return NoticificationFragment.newInstance();
            } else {
                return FreeBoardFragment.newInstance();
            }
        }

        @Override
        public CharSequence getPageTitle(int position) {
            if (position == 0) {
                return "공지사항";
            } else {
                return "자유게시판";
            }
        }
    }
}