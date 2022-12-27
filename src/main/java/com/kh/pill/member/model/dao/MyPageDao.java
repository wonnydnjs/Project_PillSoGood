package com.kh.pill.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.event.model.vo.Event;
import com.kh.pill.order.model.vo.Cart;
import com.kh.pill.order.model.vo.Order;
import com.kh.pill.poll.model.vo.Poll;
import com.kh.pill.poll.model.vo.PollResult;
import com.kh.pill.product.model.vo.Product;
import com.kh.pill.review.model.vo.Review;
import com.kh.pill.review.model.vo.ReviewFile;

@Repository
public class MyPageDao {
	
	/**
	 * 전체 주문내역 수
	 * @param sqlSession
	 * @param memberNo
	 * @return
	 */
	public int selectMyOrderListCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("orderMapper.selectMyOrderListCount", memberNo);
	}
	
	/**
	 * 주문내역 조회
	 * @param sqlSession
	 * @param pi
	 * @param memberNo
	 * @return
	 */
	public ArrayList<Order> selectMyOrderList(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("orderMapper.selectMyOrderList", memberNo, rowBounds);
	}
	
	/**
	 * 각 주문내역의 제품명들 조회
	 * @param sqlSession
	 * @param orderNo
	 * @return
	 */
	public ArrayList<Product> selectMyOrderProducts(SqlSessionTemplate sqlSession, String orderNo) {
		return (ArrayList)sqlSession.selectList("productMapper.selectMyOrderProducts", orderNo);
	}
	
	public int searchOrderListByDateCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("orderMapper.searchOrderListByDateCount", map);
	}
	
	public ArrayList<Order> searchOrderListByDate(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {

		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("orderMapper.searchOrderListByDate", map, rowBounds);
	}
	
	/**
	 * 주문 상세조회
	 * @param sqlSession
	 * @param orderNo
	 * @return
	 */
	public Order selectMyOrder(SqlSessionTemplate sqlSession, String orderNo) {
		return sqlSession.selectOne("orderMapper.selectMyOrder", orderNo);
	}
	
	public ArrayList<Cart> selectMyOrderCarts(SqlSessionTemplate sqlSession, String orderNo) {
		return (ArrayList)sqlSession.selectList("orderMapper.selectMyOrderCarts", orderNo);
	}
	
	/**
	 * 구독 리스트 조회
	 * @param sqlSession
	 * @param memberNo
	 * @return
	 */
	public ArrayList<Order> selectMySubsList(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("orderMapper.selectMySubsList", memberNo);
	}
	
	public int selectMyCustomerUidCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("orderMapper.selectMyCustomerUidCount", memberNo);
	}
	
	/**
	 * 구독 상세조회
	 * @param memberNo
	 * @return
	 */
	public Order selectMySubs(SqlSessionTemplate sqlSession, String customerUid) {
		return sqlSession.selectOne("orderMapper.selectMySubs", customerUid);
	}
	
	/**
	 * 구독 첫결제일 조회
	 * @param memberNo
	 * @return
	 */
	public String selectMyFirstSubs(SqlSessionTemplate sqlSession, String customerUid) {
		return sqlSession.selectOne("orderMapper.selectMyFirstSubs", customerUid);
	}
	
	
	
	
	
	/**
	 * 설문조사 결과 조회용 메소드
	 * @param sqlSession
	 * @param memberNo
	 * @return
	 */
	public ArrayList<PollResult> selectPollResult(SqlSessionTemplate sqlSession, int memberNo) {

		return (ArrayList)sqlSession.selectList("pollMapper.selectPollResult", memberNo);
		
	}
	
	
	/**
	 * 설문조사 결과 조회용 메소드
	 * @param sqlSession
	 * @param memberNo
	 * @return
	 */
	public ArrayList<Poll> selectPollList(SqlSessionTemplate sqlSession, int memberNo) {
		
		return (ArrayList)sqlSession.selectList("pollMapper.selectPollList", memberNo);
	}
	
	/**
	 * 제품 리스트 카운트 메소드
	 * @param sqlSession
	 * @param memberNo
	 * @return
	 */
	public int selectMyProductListCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("productMapper.selectMyProductListCount", memberNo);
	}
	
	/**
	 * 제품 조회용 메소드
	 * @param sqlSession
	 * @param memberNo
	 * @param pi
	 * @return
	 */
	public ArrayList<Product> selectMyProductList(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("productMapper.selectMyProductList", memberNo, rowBounds);
	}
	
	/**
	 * 후기 리스트 카운트 메소드
	 * @param sqlSession
	 * @param memberNo
	 * @return
	 */
	public int selectMyReviewListCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("reviewMapper.selectMyReviewListCount", memberNo);
	}

	/**
	 * 후기 조회용 메소드
	 * @param sqlSession
	 * @param memberNo
	 * @param pi
	 * @return
	 */
	public ArrayList<Review> selectMyReviewList(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reviewMapper.selectMyReviewList", memberNo, rowBounds);
	}
	/**
	 * 후기 첨부파일 조회용 메소드
	 * @param sqlSession
	 * @param rno
	 * @return
	 */
	public ArrayList<ReviewFile> selectReviewFile(SqlSessionTemplate sqlSession, int rno) {
		return (ArrayList)sqlSession.selectList("reviewMapper.selectReviewFile", rno);
	}

	/**
	 * 후기 조회수 메소드
	 * @param sqlSession
	 * @param rno
	 * @return
	 */
	public int selectReplyCount(SqlSessionTemplate sqlSession, int rno) {
		return sqlSession.selectOne("reviewMapper.selectReplyCount", rno);
	}

	/**
	 * 이벤트 리스트 카운트 메소드
	 * @param sqlSession
	 * @param memberNo
	 * @return
	 */
	public int selectMyEventListCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("eventMapper.selectMyEventListCount", memberNo);
	}
	
	/**
	 * 이벤트 조회용 메소드
	 * @param sqlSession
	 * @param memberNo
	 * @param pi
	 * @return
	 */
	public ArrayList<Event> selectMyEventList(SqlSessionTemplate sqlSession, PageInfo pi, int memberNo) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("eventMapper.selectMyEventList", memberNo, rowBounds);
	}



	
	

}
