package com.kh.pill.magazine.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.magazine.model.dao.MagazineDao;
import com.kh.pill.magazine.model.vo.Magazine;
import com.kh.pill.magazine.model.vo.MagazineLike;
import com.kh.pill.magazine.model.vo.MagazinePage;

@Service
public class MagazineServiceImpl implements MagazineService {

	@Autowired
	private MagazineDao magazineDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount() {
		
		return magazineDao.selectListCount(sqlSession);
	}
	
	@Override
	public int selectListCount1() {
		
		return magazineDao.selectListCount1(sqlSession);
	}
	
	@Override
	public int selectListCount2() {
		
		return magazineDao.selectListCount2(sqlSession);
	}
	
	@Override
	public int selectListCount3() {
		
		return magazineDao.selectListCount3(sqlSession);
	}

	@Override
	public ArrayList<Magazine> selectMagazineList(PageInfo pi) {

		return magazineDao.selectMagazineList(sqlSession, pi);		
	}

	@Override
	public Magazine selectMagazine(int magazineNo) {

		return magazineDao.selectMagazine(sqlSession, magazineNo);
	}

	@Override
	public int insertMagazine(Magazine mag) {

		return magazineDao.insertMagazine(sqlSession, mag);
	}

	@Override
	public int deleteMagazine(int magazineNo) {

		return magazineDao.deleteMagazine(sqlSession, magazineNo);
	}

	@Override
	public int updateMagazine(Magazine mag) {
		
		return magazineDao.updateMagazine(sqlSession, mag);
	}

	@Override
	public int updateViewCount(int magazineNo) {
		
		return magazineDao.updateViewCount(sqlSession, magazineNo);
	}

	@Override
	public MagazinePage magazinePage(int magazineNo) {
		
		return magazineDao.magazinePage(sqlSession, magazineNo);
	}

	// 인기순
	@Override
	public ArrayList<Magazine> selectPopularList(PageInfo pi) {
		
		return magazineDao.selectPopularList(sqlSession, pi);
	}

	// 카테고리
	@Override
	public ArrayList<Magazine> selectLifeList(PageInfo pi) {

		return magazineDao.selectLifeList(sqlSession, pi);
	}

	@Override
	public ArrayList<Magazine> selectSeasonList(PageInfo pi) {

		return magazineDao.selectSeasonList(sqlSession, pi);
	}

	@Override
	public ArrayList<Magazine> selectIssueList(PageInfo pi) {

		return magazineDao.selectIssueList(sqlSession, pi);
	}

	// 좋아요 insert
	@Override
	public int insertMagazineLike(MagazineLike magL) {

		return magazineDao.insertMagazineLike(sqlSession, magL);
	}
	
	// 좋아요 조회
	@Override
	public MagazineLike selectMagazineLike(MagazineLike magLselect) {

		return magazineDao.selectMagazineLike(sqlSession, magLselect);
	}

	// 좋아요 카운트 업데이트 
	@Override
	public int updateMagazineLikeCount(int magazineNo) {

		return magazineDao.updateMagazineLikeCount(sqlSession, magazineNo);
	}

	// 좋아요 삭제 
	@Override
	public int deleteMagazineLike(MagazineLike magL) {

		return magazineDao.deleteMagazineLike(sqlSession, magL);
	}
	
	// 좋아요 카운트
	@Override
	public int selectMagazineLikeCount(int magazineNo) {

		return magazineDao.selectMagazineLikeCount(sqlSession, magazineNo);
	}

	

}
