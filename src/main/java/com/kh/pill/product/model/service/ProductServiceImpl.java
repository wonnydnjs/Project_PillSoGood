package com.kh.pill.product.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.product.model.dao.ProductDao;
import com.kh.pill.product.model.vo.Product;
import com.kh.pill.product.model.vo.ProductLike;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	/**
	 * 상품 리스트 조회
	 */
	@Override
	public ArrayList<Product> selectList(String filter) {
		
		return productDao.selectList(sqlSession, filter);
	}

	/**
	 * 상품 작성
	 */
	@Override
	public int insertProduct(Product p) {
		
		return productDao.insertProduct(sqlSession, p);
	}

	/**
	 * 상품 조회수 상승
	 */
	@Override
	public int increaseCount(int productNo) {
		return productDao.increaseCount(sqlSession, productNo);
	}

	/**
	 * 상품 상세조회
	 */
	@Override
	public Product selectProduct(int productNo) {
		return productDao.selectProduct(sqlSession, productNo);
	}

	/**
	 * 상품 삭제
	 */
	@Override
	public int deleteProduct(int productNo) {
		return productDao.deleteProduct(sqlSession, productNo);
	}

	/**
	 * 상품 수정
	 */
	@Override
	public int updateProduct(Product p) {
		return productDao.updateProduct(sqlSession, p);
	}

	/**
	 * 상품 좋아요 조회
	 */
	@Override
	public int selectProductLike(ProductLike pl) {
		return productDao.selectProductLike(sqlSession, pl);
	}

	/**
	 * 상품 찜하기
	 */
	@Override
	public int deleteProductLike(ProductLike pl) {
		return productDao.deleteProductLike(sqlSession, pl);
	}

	/**
	 * 상품 찜 취소
	 */
	@Override
	public int insertProductLike(ProductLike pl) {
		return productDao.insertProductLike(sqlSession, pl);
	}

	/**
	 * 관리자 리스트 카운트 조회
	 */
	@Override
	public int adSelectListCount() {
		
		return productDao.adSelectListCount(sqlSession);
	}

	/**
	 * 관리자 제품 전체 리스트 조회
	 */
	@Override
	public ArrayList<Product> adSelectProductList(PageInfo pi) {
		
		return productDao.adSelectProductList(sqlSession, pi);
	}



}
