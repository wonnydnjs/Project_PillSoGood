package com.kh.pill.order.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.order.model.vo.Cart;
import com.kh.pill.order.model.vo.Order;
import com.kh.pill.order.model.vo.OrderCart;

@Repository
public class OrderDao {
	
	// order
	
	public int selectCountByCustomerUid(SqlSessionTemplate sqlSession, String customerUid) {
		return sqlSession.selectOne("orderMapper.selectCountByCustomerUid", customerUid);
	}
	
	public int checkSubscribing(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("orderMapper.checkSubscribing", memberNo);
	}
	
	public int insertOrder(SqlSessionTemplate sqlSession, Order o) {
		return sqlSession.insert("orderMapper.insertOrder", o);
	}
	
	public ArrayList<Cart> selectCart(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("orderMapper.selectCart", memberNo);
	}
	
	public int insertOrderCart(SqlSessionTemplate sqlSession, OrderCart oc) {
		return sqlSession.insert("orderMapper.insertOrderCart", oc);
	}

	public int deleteCart(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.update("orderMapper.deleteCart", memberNo);
	}
	
	public int selectDelivery(SqlSessionTemplate sqlSession, String orderNo) {
		return sqlSession.selectOne("orderMapper.selectDelivery", orderNo);
	}

	public int deleteOrder(SqlSessionTemplate sqlSession, Order o) {
		return sqlSession.update("orderMapper.deleteOrder", o);
	}
	
	public int deleteSubs(SqlSessionTemplate sqlSession, Order o) {
		return sqlSession.update("orderMapper.deleteSubs", o);
	}
	
	public ArrayList<OrderCart> selectCartNoForSubs(SqlSessionTemplate sqlSession, int memberNo) {
		return (ArrayList)sqlSession.selectList("orderMapper.selectCartNoForSubs", memberNo);
	}
	
	// ---------------------------------------------------------------
	
	// cart
	
	public int insertCart(SqlSessionTemplate sqlSession, Cart c) {
		return sqlSession.insert("orderMapper.insertCart", c);
	}
	
	public int selectIsCart(SqlSessionTemplate sqlSession, Cart c) {
		return sqlSession.selectOne("orderMapper.selectIsCart", c);
	}
	
	public int updateCart(SqlSessionTemplate sqlSession, Cart c) {
		return sqlSession.update("orderMapper.updateCart", c);
	}
	
	public int removeCart(SqlSessionTemplate sqlSession, Cart c) {
		return sqlSession.delete("orderMapper.removeCart", c);
	}
	
	public int modifyCart(SqlSessionTemplate sqlSession, Cart c) {
		return sqlSession.update("orderMapper.modifyCart", c);
	}
	
	// ---------------------------------------------------------------
	
	// 관리자
	
	public int selectAllListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("orderMapper.selectAllListCount");
	}

	public ArrayList<Order> selectOrderAllList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("orderMapper.selectOrderAllList", null, rowBounds);
	}
	
	public int updateOrder(SqlSessionTemplate sqlSession, Order o) {
		return sqlSession.update("orderMapper.updateOrder", o);
	}

	/**
	 * 관리자 페이지 당해 당월 매출 구하기
	 */
	public ArrayList<Order> selectSalesPerMonth(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("orderMapper.selectSalesPerMonth");
	}

	/**
	 * 관리자 페이지 연간 매출 구하기 
	 */
	public ArrayList<Order> selectSalesPerYear(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("orderMapper.selectSalesPerYear");
	}

	/**
	 * 관리자 페이지 제품 누척 매출 구하기 
	 */
	public ArrayList<Cart> productSalesStatistics(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("orderMapper.productSalesStatistics");
	}
}
