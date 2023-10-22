package com.bonshop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bonshop.dao.MemberDAO;
import com.bonshop.vo.MemberVO;
import com.bonshop.vo.ZipCodeVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDao;

	@Override
	public MemberVO idCheck(String id) {		
		return this.memberDao.idCheck(id);
	}

	@Override
	public void insertMember(MemberVO m) {
		this.memberDao.insertMember(m);		
	}

	@Override
	public List<ZipCodeVO> zipFind(String dong) {		
		return this.memberDao.zipFind(dong);
	}

	@Override
	public MemberVO pwdMember(MemberVO m) {
		return this.memberDao.pwdMember(m);
	}

	@Override
	public void updatePwd(MemberVO m) {
		this.memberDao.updatePwd(m);		
	}

	@Override
	public MemberVO getMember(String id) {
		return this.memberDao.getMember(id);
	}

	@Override
	public void updateMember(MemberVO m) {
		this.memberDao.updateMember(m);		
	}
}
