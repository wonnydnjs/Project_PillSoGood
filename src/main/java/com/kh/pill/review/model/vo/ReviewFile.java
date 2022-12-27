package com.kh.pill.review.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor //기본생성자
@Setter // setter메소드들
@Getter // getter메소드들
@ToString //toString메소드
public class ReviewFile {

	private int reviewFileNo; // REVIEW_FILE_NO	NUMBER
	private String changeName; // CHANGE_NAME	VARCHAR2(1000 BYTE)
	private String filePath; // FILE_PATH	VARCHAR2(1000 BYTE)
	private Date uploadDate; // UPLOAD_DATE	DATE
	private int fileLevel; // FILE_LEVEL	NUMBER
	private String fileStatus; // FILE_STATUS	CHAR(1 BYTE)
	private int reviewNo;
	
}
