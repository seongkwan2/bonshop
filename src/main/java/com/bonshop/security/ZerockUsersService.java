package com.bonshop.security;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.bonshop.dao.MemberRepository;

import lombok.extern.java.Log;

@Service //스프링에서 빈으로 처리
@Log
public class ZerockUsersService implements UserDetailsService {//사용자 정의 UserDetailsService 작성
	/* CustomUserDetailsService 별도의 인증/권한 체크를 하는 이유는 jsp등에서 단순히 사용자 아이디
	 * (스프링 시큐리티에서는 username) 정도가 아닌 사용자의 이름이나 이메일
	 * 같은 추가적인 정보를 이용하기 위해서 이다. 
	 */
    @Autowired
    private MemberRepository memberRepo;
    
    @Autowired
    private HttpServletRequest request;
        
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {//회원아이디를 이용해서 UserDetails객체를 반환
		
		System.out.println(" \n =============> UserDetailsService 로 접근함");
		//User sampleUser=new User(username,"{noop}1111",Arrays.asList(new SimpleGrantedAuthority("ROLE_MANAGER")));
		//생성자 인자값으로 아이디,비번,권한
		//이 전달
		//return sampleUser;
		
		//this.memberRepo.findById(username) //아이디를 기준으로 회원정보 검색
		//.ifPresent(member->System.out.println(" \n ========> 검색된 회원정보 : "+member));//검색된 회원정보가 있다면 회원정보 출력
		
		return 
			this.memberRepo.findById(username)
	        .filter(member -> member != null) //검색된 회원정보(권한정보)가 있다면
	        .map(member -> new ZerockSecurityUser(member,request)).get();//검색된 회원정보(권한정보)를 ZerockSecurityUser 생성자 인자값으로 전달하고
		    //ZerockSecurityUser 객체 타입을 get()메서드로 구함
	}
}
