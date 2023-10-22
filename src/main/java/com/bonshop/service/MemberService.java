package com.bonshop.service;

import java.util.List;

import com.bonshop.vo.MemberVO;
import com.bonshop.vo.ZipCodeVO;

public interface MemberService {

	MemberVO idCheck(String id);
	void insertMember(MemberVO m);
	List<ZipCodeVO> zipFind(String dong);
	MemberVO pwdMember(MemberVO m);
	void updatePwd(MemberVO m);
	MemberVO getMember(String id);
	void updateMember(MemberVO m);

}
