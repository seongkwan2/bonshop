package com.bonshop.dao;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bonshop.vo.MemberVO;
import com.bonshop.vo.ZipCodeVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private MemberRepository memberRepo;
	
	@Autowired
	private ZipcodeRepository zipcodeRepo;

	@Override
	public MemberVO idCheck(String id) {
		
		System.out.println(" \n 아이디 중복 검색(JPA) =================>");        
		Optional<MemberVO> result = this.memberRepo.findById(id);
	    MemberVO member;
	    if(result.isPresent()){//아이디에 해당하는 회원 정보가 있다면 참
	        member = result.get();//MemberVO 엔티티 타입 객체를 구함	        
	    }else {//회원정보가 없다면
	    	member=null;//null을 저장한 후 반환
	    }
		return member;
	}//아이디 중복 검색
	
	@Override
	public List<ZipCodeVO> zipFind(String dong) {
		System.out.println(" \n 우편주소 검색(JPA) ========================>");
		List<ZipCodeVO> ziplist = this.zipcodeRepo.findByDong(dong);
		return ziplist;
	}//우편주소 검색	
	
	@Override
	public void insertMember(MemberVO m) {
		System.out.println("\n 회원저장(JPA) ==============================>");	
		this.memberRepo.save(m);		
	}//회원 저장	

	@Override
	public MemberVO pwdMember(MemberVO m) {
		System.out.println(" \n 비번 검색(JPA) =================>");        
		MemberVO pm=this.memberRepo.pwdFind(m.getM_id(), m.getM_name());
		return pm;
	}//비번찾기->아이디와 회원이름을 기준으로 회원정보를 검색

	@Transactional //javax.persistence.TransactionRequiredException: Executing an update/delete query 에러가 발생하기 때문에 
	//@Transactional을 해줘야 한다.	
	@Override
	public void updatePwd(MemberVO m) {
		System.out.println(" \n 암호화 된 임시 비번을 아이디를 기준으로 수정(JPA) =================>"); 
		this.memberRepo.updatePwd(m.getM_pwd(), m.getM_id());
	}//암호화 된 임시비번으로 수정

	@Override
	public MemberVO getMember(String id) {
		System.out.println(" \n JPA=====================> 아이디에 대한 회원정보 보기");		
		MemberVO m=this.memberRepo.getReferenceById(id);
		return m;
	}//아이디에 해당하는 회원정보 보기

	@Transactional
	@Override
	public void updateMember(MemberVO m) {
		System.out.println(" \n ==============================> jpa로 회원정보 수정하기");
		this.memberRepo.updateMember(m.getM_pwd(), m.getM_name(), m.getM_birth(), m.getM_email(), m.getM_phone(),
				m.getM_zipCode(), m.getM_addr(), m.getM_addr2(),m.getM_tel(), m.getM_id());
	}//회원정보 수정
}
