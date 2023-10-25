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
@Getter /*로그인시  사용자의 권한을 확인하고, 해당 권한을 세션에 저장하는 역할을 하는 코드*/
public class MemberSecurity extends User {
	
	private static final String ROLE_PREFIX = "ROLE_";	//권한의 접두사로 사용됨
	
	private MemberVO memberInfo;

	//MemberSecurity 객체를 생성할 때 사용자 정보와 HTTP 요청 객체를 받아들임
	public MemberSecurity(MemberVO memberInfo,HttpServletRequest request) {
		super(memberInfo.getM_id(), memberInfo.getM_pwd(), makeGrantedAuthority(memberInfo.getRoles()));
		//부모클래스 생성자에 인자값으로 아이디,비번,권한 목록을 넘겨줌
		System.out.println(" \n =============> MemberSecurity 로 접근함");
		
		System.out.println("권한이름:" + makeGrantedAuthority(memberInfo.getRoles()).toString());
		
		//세션 저장
		HttpSession session=request.getSession();
		session.setAttribute("memberInfo", memberInfo);
		session.setAttribute("name", memberInfo.getM_name());
		
		//권한 목록 생성 (GrantedAuthority는 Spring Security에서 권한을 표현하는 인터페이스)
		List<GrantedAuthority> list = makeGrantedAuthority(memberInfo.getRoles());
		
		//사용자의 모든 권한을 하나의 문자열로 누적하기 위해 total_Auth 변수를 초기화
		//예를 들면, 만약 사용자의 권한이 "ROLE_USER", "ROLE_ADMIN"이라면 total_Auth는 "ROLE_USER,ROLE_ADMIN"와 같이 되는 것
		String total_Auth="";
		//권한 목록 순회 및 출력
		for(int i=0;i<list.size();i++) {	//권한목록의 크기만큼 반복문을 돌림
		  System.out.println("현재 가지고있는 권한 : "+list.get(i));	//현재 권한을 콘솔에 출력
		  total_Auth += list.get(i) + ","; // 현재 권한을 total_Auth 문자열에 누적하고 쉼표 추가
		}
		System.out.println("현재 계정이 가지고있는 모든권한(누적권한) :"+total_Auth);	//누적된 권한 문자열을 콘솔에 출력합니다.
		session.setAttribute("auth",total_Auth);	//세션에 누적 권한 저장
	}
	//makeGrantedAuthority 메서드는 MemberRole타입의 권한목록을 매개변수로 받아서 이것을 GrantedAuthority 타입의 목록으로 변환시킴
	//쉽게 말해 권한목록의 타입을 바꾸기 위한 메서드
	private static List<GrantedAuthority> makeGrantedAuthority(List<MemberRole> roles) {//메서드 인자값으로 권한 목록이 넘겨짐
		
		List<GrantedAuthority> list = new ArrayList<>();
		for (MemberRole role : roles) { 
			//권한 목록 만큼 반복해서 권한에 접두어 "ROLE_"를 붙인 권한이름을 SimpleGrantedAuthority
			//ROLE_PREFIX 와 결합하여 SimpleGrantedAuthority 객체를 생성하고, 이를 list에 추가합니다.
	        list.add(new SimpleGrantedAuthority(ROLE_PREFIX + role.getRoleName())); //ex) USER -> ROLE_USER
	    }
		
		/*람다식 표현
		roles.forEach(role -> list.add(new SimpleGrantedAuthority(ROLE_PREFIX + role.getRoleName())));
		//권한 목록만큼 반복해서 접두어 "ROLE_"를 붙인 권한이름을 
		//SimpleGrantedAuthority 생성자 인자값으로 전달한 제네릭 타입 객체로 컬렉션에 추가*/
		
		return list;
	}
}
