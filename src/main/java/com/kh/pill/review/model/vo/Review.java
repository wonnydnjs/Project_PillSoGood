package com.kh.pill.review.model.vo;

import java.sql.Date;
import java.util.ArrayList;

import com.kh.pill.product.model.vo.Product;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor //기본생성자
@Setter // setter메소드들
@Getter // getter메소드들
@ToString //toString메소드
public class Review {

	private int reviewNo; // REVIEW_NO	NUMBER
	private String reviewTitle; // REVIEW_TITLE	VARCHAR2(100 BYTE)
	private String reviewContent; // REVIEW_CONTENT	VARCHAR2(3000 BYTE)
	private Date reviewDate; // REVIEW_DATE	DATE
	private int reviewCount; // REVIEW_COUNT	NUMBER
	private String reviewGrade; // REVIEW_GRADE	NUMBER
	private String reviewStatus; // REVIEW_STATUS	CHAR(1 BYTE)
	
	// 일반 리뷰 조회용 VO
	private int memberNo;
	private String memberName;
	private String memberId;
	private String subsStatus;
	private int replyCount;
	private ArrayList<ReviewFile> flist; // REVIEW_FILE 테이블에서 List 뽑아와서 List<Review>에 담을 변수
	private long orderNo;
	private String filePath; // FILE_PATH	VARCHAR2(1000 BYTE)
	private String productName;
	private ArrayList<Review> rOrderList; // 리뷰 작성 시 결제 건들이 들어있는 리스트
	private int productNo;
	private int cartNo;
	private ArrayList<String> rOrderProductNameList;
	private String rOrderProductNames;
	private ArrayList<Integer> pNoList;
	private ArrayList<Product> pList;
}
