package com.kh.pill.magazine.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.magazine.model.vo.Magazine;
import com.kh.pill.magazine.model.vo.MagazineLike;
import com.kh.pill.magazine.model.vo.MagazinePage;

@Repository
public class MagazineDao {


	public int selectListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("magazineMapper.selectListCount");
	}

	public int selectListCount1(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("magazineMapper.selectListCount1");
	}

	public int selectListCount2(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("magazineMapper.selectListCount2");
	}
	
	public int selectListCount3(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("magazineMapper.selectListCount3");
	}
	
	public ArrayList<Magazine> selectMagazineList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);
		
		ArrayList<Magazine> list = (ArrayList)sqlSession.selectList("magazineMapper.selectMagazineList", null, rowBounds);

		return list;
	}

	
	public Magazine selectMagazine(SqlSessionTemplate sqlSession, int magazineNo) {
		
		return sqlSession.selectOne("magazineMapper.selectMagazine", magazineNo);
	}
	

	public int insertMagazine(SqlSessionTemplate sqlSession, Magazine mag) {
		
		return sqlSession.insert("magazineMapper.insertMagazine", mag);
	}
	

	public int deleteMagazine(SqlSessionTemplate sqlSession, int magazineNo) {
		
		return sqlSession.update("magazineMapper.deleteMagazine", magazineNo);
	}

	
	public int updateMagazine(SqlSessionTemplate sqlSession, Magazine mag) {
		
		return sqlSession.update("magazineMapper.updateMagazine", mag);
	}
	

	// 좋아요 insert
	public int insertMagazineLike(SqlSessionTemplate sqlSession, MagazineLike magL) {
		
		return sqlSession.insert("magazineMapper.insertMagazineLike", magL);
	}


	// 좋아요 조회
	public MagazineLike selectMagazineLike(SqlSessionTemplate sqlSession, MagazineLike magLselect) {
		
		return sqlSession.selectOne("magazineMapper.selectMagazineLike", magLselect);
	}


	// 좋아요 카운트 업데이트 
	public int updateMagazineLikeCount(SqlSessionTemplate sqlSession, int magazineNo) {
		
		return sqlSession.update("magazineMapper.updateMagazineLikeCount", magazineNo);
	}

	// 좋아요 삭제 
	public int deleteMagazineLike(SqlSessionTemplate sqlSession, MagazineLike magL) {
		
		return sqlSession.delete("magazineMapper.deleteMagazineLike", magL);
	}

	
	 // 좋아요 카운트
	 public int selectMagazineLikeCount(SqlSessionTemplate sqlSession, int magazineNo) {
		
		return sqlSession.selectOne("magazineMapper.selectMagazineLikeCount", magazineNo);
	}

	// 조회수
	public int updateViewCount(SqlSessionTemplate sqlSession, int magazineNo) {
		
		return sqlSession.update("magazineMapper.updateViewCount", magazineNo);
	}
	
	// 이전글 다음글
	public MagazinePage magazinePage(SqlSessionTemplate sqlSession, int magazineNo) {
		
		return sqlSession.selectOne("magazineMapper.magazinePage", magazineNo);
	}

	// 인기순
	public ArrayList<Magazine> selectPopularList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("magazineMapper.selectPopularList", null, rowBounds);
	}
	
	// 카테고리
	public ArrayList<Magazine> selectLifeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("magazineMapper.selectLifeList", null, rowBounds);
	}
	
	public ArrayList<Magazine> selectSeasonList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("magazineMapper.selectSeasonList", null, rowBounds);
	}
	
	public ArrayList<Magazine> selectIssueList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("magazineMapper.selectIssueList", null, rowBounds);
	}

	
}
