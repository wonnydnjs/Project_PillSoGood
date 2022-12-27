package com.kh.pill.poll.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class PollResult {
	
    private int pollLevel; // POLL_LEVEL NUMBER,
    private int pollNo; // POLL_NO NUMBER,
    private String productNo; // PRODUCT_NO NUMBER
    
    
    // 결과창 조회 내용
    private String productName;
    private String productExplain;
    private int productPrice;
    private String productImgPath;
    private String productEffect;
    private String productEffectPath;
    
    
    
    
}
