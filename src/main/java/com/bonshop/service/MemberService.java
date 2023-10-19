package com.bonshop.service;

import com.bonshop.vo.MemberVO;

public interface MemberService {

	//아이디를 기준으로 회원정보를 가져옴
	MemberVO getMemberInfo(String m_id);

	//회원가입 (계정추가)
	void addMember(MemberVO memberInfo);

}
