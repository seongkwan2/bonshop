package com.bonshop.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {
	
	private int m_num;
	private String m_id;
	private String m_pwd;
	private String m_name;
	private String m_birth;
	private String m_email;
	private String m_phone;
	private String m_tel;
	private int m_state;
	private Date m_regdate;
	
	public MemberVO() {}	//에러 방지용 기본생성자
}


