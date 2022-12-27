package com.kh.pill.product.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.product.model.vo.Product;
import com.kh.pill.product.model.vo.ProductLike;

@Repository
public class ProductDao {
	
	public ArrayList<Product> selectList(SqlSessionTemplate sqlSession, String filter) {
		
		return (ArrayList)sqlSession.selectList("productMapper.selectList", filter);
	}
	
	public int insertProduct(SqlSessionTemplate sqlSession, Product p) {
		
		return sqlSession.insert("productMapper.insertProduct", p);
	}
	
	public int increaseCount(SqlSessionTemplate sqlSession, int productNo) {
		
		return sqlSession.update("productMapper.increaseCount", productNo);
	}
	
	public Product selectProduct(SqlSessionTemplate sqlSession, int productNo) {
		
	    return sqlSession.selectOne("productMapper.selectProduct", productNo);
	}
	
	public int deleteProduct(SqlSessionTemplate sqlSession, int productNo) {
		
		return sqlSession.update("productMapper.deleteProduct", productNo);
	}
	
	public int updateProduct(SqlSessionTemplate sqlSession, Product p) {
		
		return sqlSession.update("productMapper.updateProduct", p);
	}
	
	public int selectProductLike(SqlSessionTemplate sqlSession, ProductLike pl) {
		
		int count =  sqlSession.selectOne("productMapper.selectProductLike", pl);
		return count;
	}
	
	public int deleteProductLike(SqlSessionTemplate sqlSession, ProductLike pl) {
		
		return sqlSession.delete("productMapper.deleteProductLike", pl);
	}
	
	public int insertProductLike(SqlSessionTemplate sqlSession, ProductLike pl) {
		
		return sqlSession.insert("productMapper.insertProductLike", pl);
	}
	
	/**
	 * 관리자 페이지 리스트 카운트 조회
	 */
	public int adSelectListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("productMapper.adSelectListCount");
	}

	/**
	 * 관리자 제품 전체 리스트 조회
	 */
	public ArrayList<Product> adSelectProductList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("productMapper.adSelectProductList", null, rowBounds);
	}


}
