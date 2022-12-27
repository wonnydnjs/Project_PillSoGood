package com.kh.pill.magazine.model.service;

import java.util.ArrayList;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.magazine.model.vo.Magazine;
import com.kh.pill.magazine.model.vo.MagazineLike;
import com.kh.pill.magazine.model.vo.MagazinePage;

public interface MagazineService {

	int selectListCount();
	
	int selectListCount1();
	int selectListCount2();
	int selectListCount3();
	
	ArrayList<Magazine> selectMagazineList(PageInfo pi);
	
	Magazine selectMagazine(int magazineNo);

	int insertMagazine(Magazine mag);
	
	int deleteMagazine(int magazineNo);
	
	int updateMagazine(Magazine mag);

	// 조회수
	int updateViewCount(int magazineNo);
	
	// 이전글 최신글
	MagazinePage magazinePage(int magazineNo);

	// 인기순
	ArrayList<Magazine> selectPopularList(PageInfo pi);
	
	// 카테고리별
	ArrayList<Magazine> selectLifeList(PageInfo pi);
	
	ArrayList<Magazine> selectSeasonList(PageInfo pi);
	
	ArrayList<Magazine> selectIssueList(PageInfo pi);

	// 좋아요 insert
	int insertMagazineLike(MagazineLike magL);

	// 좋아요 조회
	MagazineLike selectMagazineLike(MagazineLike magLselect);

	// 좋아요 업데이트 
	int updateMagazineLikeCount(int magazineNo);

	// 좋아요 삭제 
	int deleteMagazineLike(MagazineLike magL);
	
	// 좋아요 카운트
	int selectMagazineLikeCount(int magazineNo);
}
