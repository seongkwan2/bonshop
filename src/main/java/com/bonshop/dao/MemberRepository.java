package com.bonshop.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.bonshop.vo.MemberVO;

public interface MemberRepository extends JpaRepository<MemberVO, String> {

	@Query("select m from MemberVO m where m.m_id=?1 and m.m_name=?2")
	public MemberVO pwdFind(String id,String name); //아이디와 회원이름을 기준으로 DB로 부터 비번을 검색
	
	@Modifying //@Query 애노테이션은 select문만 가능하지만 @Modifying을 이용해서 DML(insert,update,delete)문 작업 처리가 가능하다.
	@Query("update MemberVO m set m.m_pwd=?1 where m.m_id=?2") //?1은 첫번째로 전달되는 피라미터 값 ,?2은 두번째로 전달된  피라미터 값
	//JPQL(JPA에서 사용하는 Query Language => Java Persistence Query Language의 약어)이다.
	//JPQL은 테이블 대신 엔티빈 클래스를 이용하고,테이블 컬럼대신 엔티티빈 클래스의 변수 즉 속성을 이용한다. 
	public void updatePwd(String pwd,String id); //아이디를 기준으로 암호화 된 임시 비번을 수정		
	
	@Modifying //회원 정보 수정
	@Query("update MemberVO m set m.m_pwd=?1, m.m_name=?2, m.m_birth=?3, m.m_email=?4, m.m_phone=?5,"
			+" m.m_zipCode=?6, m.m_addr=?7, m.m_addr2=?8, m.m_tel=?9, m.m_state=?10 where m.m_id=?11")
	public void updateMember(String m_pwd, String m_name, String m_birth, String m_email, String m_phone,
			String m_zipCode, String m_addr, String m_addr2, String m_tel, String m_state, String m_id);
	
}
