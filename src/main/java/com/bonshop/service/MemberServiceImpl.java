package com.bonshop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bonshop.dao.MemberDao;
import com.bonshop.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Override
	public MemberVO getMemberInfo(String m_id) {
		return this.memberDao.getMemberInfo(m_id);
	}

	@Override
	public void addMember(MemberVO memberInfo) {
		this.memberDao.addMember(memberInfo);
	}
}
