package com.bonshop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bonshop.vo.MemberVO;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public MemberVO getMemberInfo(String m_id) {
		return this.sqlSession.selectOne("getMemberInfo",m_id);
	}

	@Override
	public void addMember(MemberVO memberInfo) {
		this.sqlSession.insert("addMember",memberInfo);
	}


}
