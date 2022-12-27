package com.kh.pill.product.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor //기본생성자
@AllArgsConstructor
@Setter // setter메소드들
@Getter // getter메소드들
@ToString //toString메소드
public class ProductLike {
	
	private int memberNo;
	private int productNo;
}
