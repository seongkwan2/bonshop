package com.bonshop.security;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.bonshop.dao.MemberRepository;
import com.bonshop.vo.MemberVO;

import lombok.extern.java.Log;

@Service //스프링에서 빈으로 처리
@Log
public class MemberCheckService implements UserDetailsService {//사용자 정의 UserDetailsService 작성
	/* CustomUserDetailsService 별도의 인증/권한 체크를 하는 이유는 jsp등에서 단순히 사용자 아이디
	 * (스프링 시큐리티에서는 username) 정도가 아닌 사용자의 이름이나 이메일
	 * 같은 추가적인 정보를 이용하기 위해서 이다. 
	 */
    @Autowired
    private MemberRepository memberRepo;	//사용자 데이터를 데이터베이스에서 조회하기 위해 의존 추가
    
    @Autowired
    private HttpServletRequest request;
        
	@Override	//회원아이디를 이용해서 UserDetails객체를 반환
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println(" \n =============> MemberCheckService(UserDetailsService) 로 접근함");
		
		//Optional은 nullable한 값을 캡슐화하는 컨테이너 객체. 즉, 값이 있을 수도 있고 없을 수도 있는 객체를 안전하게 다루기 위해 사용
		//사용자 검색
		Optional<MemberVO> optionalMember = this.memberRepo.findById(username);
	    
	    if (!optionalMember.isPresent()) {// "!"Optional.isPresent() Optional에 값이 존재"하지 않으면" true
	        return null;					//쉽게 말해 검색된 아이디가 없으면 null 반환 (메서드 동작 중지)
	    }
	    
	    //사용자가 존재하면 
	    MemberVO memberInfo = optionalMember.get();	//optionalMember안의 값들을 member에 넣음
	    
	    if (memberInfo == null) {	//memberInfo가 비었다면
	        return null;			//메서드 중지
	    }
	    
	    //제대로 동작했다면 MemberSecurity에 해당 사용자의 정보를 넣고 userDetails타입으로 반환 시킴
	    System.out.println("MemberCheckService.java에서 아이디 "+memberInfo.getM_id()+"의 정보들을 가지고 MemberSecurity.java에 보낼준비를 함\n\n");
	    UserDetails userDetails = new MemberSecurity(memberInfo, request);
	    System.out.println("보낸 "+memberInfo.getM_id()+"의 정보들을 UserDetails타입으로 다시 가져왔음");
	    System.out.println("UserDetails의 정보 : " + userDetails);
		/*람다식 표현
		UserDetails userDetails = this.memberRepo.findById(username)	//사용자의 정보를 검색
	        .filter(member -> member != null) 	//검색된 회원정보(권한정보)가 있다면
	        .map(member -> new MemberSecurity(member,request)).get();
		//검색된 회원정보(권한정보)를 MemberSecurity 생성자 인자값으로 전달하고
	    //MemberSecurity 객체 타입을 get()메서드로 구함*/
		return userDetails;
	}
}
