package com.bonshop.dao;

import java.util.List;

import com.bonshop.vo.MemberVO;
import com.bonshop.vo.ZipCodeVO;

public interface MemberDAO {

	//아이디 중복확인
	MemberVO idCheck(String id);
	//회원 저장
	void insertMember(MemberVO m);
	//주소 찾기
	List<ZipCodeVO> zipFind(String dong);
	MemberVO pwdMember(MemberVO m);
	void updatePwd(MemberVO m);
	MemberVO getMember(String id);
	void updateMember(MemberVO m);

}
