package com.kh.pill.product.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor //기본생성자
@Setter // setter메소드들
@Getter // getter메소드들
@ToString //toString메소드
public class Product {
	
	private int productNo; // PRODUCT_NO NUMBER PRIMARY KEY,
	private String productName; // PRODUCT_NAME VARCHAR2(20) NOT NULL,
	private String productExplain; // PRODUCT_EXPLAIN VARCHAR2(60) NOT NULL,
	private int productPrice; // PRODUCT_PRICE NUMBER,
	private int productStock; // PRODUCT_STOCK NUMBER,
	private String productImgPath; // PRODUCT_IMG_PATH VARCHAR2(255) NOT NULL,
	private String productDescription; // PRODUCT_DESCRIPTION VARCHAR2(255) NOT NULL,
	private Date productEnrollDate; // PRODUCT_ENROLL_DATE DATE,
	private String productStatus; // PRODUCT_STATUS CHAR(1) DEFAULT 'Y');
	private int productCount;
}
