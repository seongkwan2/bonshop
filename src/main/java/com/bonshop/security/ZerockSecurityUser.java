package com.bonshop.security;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.bonshop.vo.MemberRole;
import com.bonshop.vo.MemberVO;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ZerockSecurityUser extends User {
	
	private static final String ROLE_PREFIX = "ROLE_";
	
	private MemberVO member;

	public ZerockSecurityUser(MemberVO member,HttpServletRequest request) {
		super(member.getM_id(), member.getM_pwd(), makeGrantedAuthority(member.getRoles()));
		//부모클래스 생성자 인자값으로 아이디,비번,권한 목록을 넘겨줌
		
		System.out.println("권한이름:" + makeGrantedAuthority(member.getRoles()).toString());
		HttpSession session=request.getSession();
		session.setAttribute("id", member.getM_id());
		session.setAttribute("name", member.getM_name());
		
		List<GrantedAuthority> list = makeGrantedAuthority(member.getRoles());//권한 목록
		String total_Auth="";//누적 권한
		
		for(int i=0;i<list.size();i++) {
		  System.out.println(list.get(i));
		  total_Auth += list.get(i);
		}
		System.out.println("누적권한:"+total_Auth);
		session.setAttribute("auth",total_Auth);
	}
	
	private static List<GrantedAuthority> makeGrantedAuthority(List<MemberRole> roles) {//메서드 인자값으로 권한 목록이 넘겨짐

		List<GrantedAuthority> list = new ArrayList<>();

		roles.forEach(role -> list.add(new SimpleGrantedAuthority(ROLE_PREFIX + role.getRoleName())));//권한 목록만큼 반복해서
		//접두어 "ROLE_"를 붙인 권한이름을 SimpleGrantedAuthority 생성자 인자값으로 전달한 제네릭 타입 객체로 컬렉션에 추가
		
		return list;
	}
}
