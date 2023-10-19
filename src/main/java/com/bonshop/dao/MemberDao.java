package com.bonshop.dao;

import com.bonshop.vo.MemberVO;

public interface MemberDao {

	MemberVO getMemberInfo(String m_id);

	void addMember(MemberVO memberInfo);

}
