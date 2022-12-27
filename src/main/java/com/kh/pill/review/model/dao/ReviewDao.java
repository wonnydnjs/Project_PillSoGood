package com.kh.pill.review.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.review.model.vo.Review;
import com.kh.pill.review.model.vo.ReviewFile;
import com.kh.pill.review.model.vo.ReviewReply;

@Repository
public class ReviewDao {

	// 베스트 리뷰 조회
	public ArrayList<Review> selectBestList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("reviewMapper.selectBestList");
	}
	// 베스트 리뷰 조회시 리뷰 파일 조회
	public ArrayList<ReviewFile> selectBestReviewFile(SqlSessionTemplate sqlSession, int rno) {

		return (ArrayList)sqlSession.selectList("reviewMapper.selectBestReviewFile", rno);
	}
	
	// 일반 리뷰 조회 페이징
	public int selectListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("reviewMapper.selectListCount");
	}
	// 일반 리뷰 조회
	public ArrayList<Review> selectList(SqlSessionTemplate sqlSession, PageInfo pi, String order) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reviewMapper.selectList", order, rowBounds);
	}
	// 일반 리뷰 조회 리뷰 파일 조회
	public ArrayList<ReviewFile> selectReviewFile(SqlSessionTemplate sqlSession, int rno) {

		return (ArrayList)sqlSession.selectList("reviewMapper.selectReviewFile", rno);
	}
	// 일반 리뷰 조회 댓글 개수 조회
	public int selectReplyCount(SqlSessionTemplate sqlSession, int rno) {

		return sqlSession.selectOne("reviewMapper.selectReplyCount", rno);
	}
	
	public int increaseCount(SqlSessionTemplate sqlSession, int reviewNo) {
		return sqlSession.update("reviewMapper.increaseCount", reviewNo);
	}

	public Review selectReview(SqlSessionTemplate sqlSession, int reviewNo) {
		return sqlSession.selectOne("reviewMapper.selectReview", reviewNo);
	}
	
	public ArrayList<Integer> selectProductNoList(SqlSessionTemplate sqlSession, int rno) {
		return (ArrayList)sqlSession.selectList("reviewMapper.selectProductNoList", rno);
	}

	public int deleteReview(SqlSessionTemplate sqlSession, int rno2) {
		return sqlSession.update("reviewMapper.deleteReview", rno2);
	}
	
	public int deleteReviewFile(SqlSessionTemplate sqlSession, int rno2) {
		return sqlSession.update("reviewMapper.deleteReviewFile", rno2);
	}

	public ArrayList<ReviewReply> selectReviewReplyList(SqlSessionTemplate sqlSession, int reviewNo) {
		return (ArrayList)sqlSession.selectList("reviewMapper.selectReviewReplyList", reviewNo);
	}

	public int insertReviewReply(SqlSessionTemplate sqlSession, ReviewReply r) {
		
		return sqlSession.insert("reviewMapper.insertReviewReply", r);
	}
	
	public int deleteReviewReply(SqlSessionTemplate sqlSession, int replyNo) {
		return sqlSession.update("reviewMapper.deleteReviewReply", replyNo);
	}

	public int insertRawReview(SqlSessionTemplate sqlSession, Review r) {
		return sqlSession.insert("reviewMapper.insertRawReview", r);
	}
	
	public Review selectRawReview(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("reviewMapper.selectRawReview", memberNo);
	}
	
	public int insertReviewFile(SqlSessionTemplate sqlSession, ReviewFile reviewFile) {
		return sqlSession.insert("reviewMapper.insertReviewFile", reviewFile);
	}
	
	public ArrayList<ReviewFile> selectNewReviewFile(SqlSessionTemplate sqlSession, int rawReviewNo) {
		return (ArrayList)sqlSession.selectList("reviewMapper.selectNewReviewFile", rawReviewNo);
	}
	
	public ArrayList<Review> selectROrderList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("reviewMapper.selectROrderList", memberNo);
	}
	public ArrayList<Review> selectROrderProductNameList(SqlSessionTemplate sqlSession, long orderNo) {
		return (ArrayList)sqlSession.selectList("reviewMapper.selectROrderProductNameList", orderNo);
	}
	
	
}
