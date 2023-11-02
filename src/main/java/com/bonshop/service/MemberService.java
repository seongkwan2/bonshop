package com.bonshop.service;

import java.util.List;

import com.bonshop.vo.MemberVO;
import com.bonshop.vo.ZipCodeVO;

public interface MemberService {

	//아이디 검색
	MemberVO findById(String id);
	//회원저장
	void insertMember(MemberVO m);
	//주소찾기
	List<ZipCodeVO> zipFind(String dong);
	MemberVO pwdMember(MemberVO m);
	void updatePwd(MemberVO m);
	MemberVO getMember(String id);
	//회원 정보 수정
	void updateMember(MemberVO m);
	//회원 탈퇴
	void deleteById(String loginId);

}
