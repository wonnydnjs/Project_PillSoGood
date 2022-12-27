package com.kh.pill.question.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Question {
	
	private int questionNo;
	private String questionTitle;
	private String questionContent;
	private String questionImage;
	private String memberNo;
	private String questionDate;
	private String answer;
	private String answerDate;
	private String questionStatus;
}
