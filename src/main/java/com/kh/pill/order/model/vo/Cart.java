package com.kh.pill.order.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Cart {
	
	private int cartNo;
	private int memberNo;
	private int productNo;
	private int cartAmount;
	private String cartStatus;
	
	private String productName; 
	private String productExplain; 
	private int productPrice;
	private String productImgPath; 
}
