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
public class Poll {
	
    private int pollNo;// POLL_NO NUMBER PRIMARY KEY,
    private String pollDate; // POLL_DATE DATE DEFAULT SYSDATE NOT NULL,
    private String pollStatus; // POLL_STATUS CHAR(1) DEFAULT 'Y',
    private String memberNo;// MEMBER_NO NUMBER

}
