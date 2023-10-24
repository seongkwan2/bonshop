package com.bonshop.security;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import com.boshop.Handler.CustomAccessDeniedHandler;
import com.boshop.Handler.CustomLoginFailureHandler;
import com.boshop.Handler.CustomLoginSuccessHandler;
import com.boshop.Handler.CustomLogoutSuccessHandler;

import lombok.extern.java.Log;

@Log
@EnableWebSecurity	//스프링 웹 시큐리티로 인식되게 @EnableWebSecurity 애노테이션 추가
@SuppressWarnings("deprecation")	//경고 메시지 무시
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	//스프링 웹 시큐리티 설정을 담당하는 WebSecurityConfigurerAdapter 클래스를 상속받는다.

	@Autowired
	DataSource dataSource;

	@Autowired
	ZerockUsersService zerockUsersService;

	@Bean	//비밀번호 암호화 빈 등록
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
		//PasswordEncoder 빈등록하고 MemberTests JUnit 클래스 등에서 @Autowired 자동의존성 주입해야 에러가 안난다.	
	}
	
	//자원 접근 허용
	@Override
	public void configure(WebSecurity web) throws Exception
	{
		web.ignoring().antMatchers("/css/**", "/imgs/**", "/js/**", "/lib/**", "/upload/**");
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {//configure() 메서드를 오버라이딩을 해서 간단한 로그 메시지를 출력한다.
		//HttpSecurity는 웹과 관련된 다양한 보안설정을 걸어 줄 수 있다.

		log.info("security config ......");

		// 접근 설정
	    http.authorizeRequests()
	        .antMatchers("/items/**").permitAll()
	        .antMatchers("/admin/**").hasRole("ADMIN")
	        .antMatchers("/myPage/**").hasAnyRole("ROLE_USER", "ADMIN")
	        .antMatchers("/member/login", "/member/sign").not().authenticated()	//로그인 상태일때 접근 금지
	        .anyRequest().authenticated(); // 나머지 모든 요청은 인증 필요
	    
	    // 접근 금지 처리
	    http.exceptionHandling()
        .accessDeniedHandler(new CustomAccessDeniedHandler());

	    // 로그인 페이지 설정
	    http.formLogin()
	        .loginPage("/member/login")		//로그인 페이지
	        .defaultSuccessUrl("/", true)	//로그인 성공시 메인 페이지로 이동
	        .successHandler(new CustomLoginSuccessHandler())	//로그인 성공 핸들러
	        .failureUrl("/member/login")	//로그인 실패시 다시 로그인 페이지로 이동
	        .failureHandler(new CustomLoginFailureHandler());	//로그인 실패 핸들러
	        //.permitAll();					//로그인 페이지는 누구나 접근가능하지만 이걸 활성화 시키면 로그인상태에서도 로그인폼이 가져서 비활성화 
        
	    // 로그아웃 설정
	    http.logout()
	        .logoutUrl("/member/logout")
	        .logoutSuccessHandler(new CustomLogoutSuccessHandler())	//로그아웃 핸들러
	        .invalidateHttpSession(true);

	    // 로그인 상태 유지를 위한 remember-Me 설정
	    http.rememberMe()
	        .key("zerock")							//토큰의 암호화를 위한 키 설정 (키는 remember-me 쿠키를 생성하고 검증할때 사용)
	        .userDetailsService(zerockUsersService)	//사용자가 다시 방문했을 때 이 서비스를 통해 사용자 정보를 조회
	        .tokenRepository(getJDBCRepository())	//토큰을 저장, 꺼내서 쓰기위한 공간
	        .tokenValiditySeconds(60*60*24); 		//토큰의 유효기간을 1일로 설정
	}

	//로그인 상태 유지를 위한 remember-me 토큰 저장공간
	//PersistentTokenRepository는 remember-me 토큰을 저장 및 조회하기 위한 저장소를 정의
	private PersistentTokenRepository getJDBCRepository() {
		/*  SecurityConfig 에서 rememberMe()를 처리할 때 JdbcTokenRepositoryImpl을 지정해 주어야 하는데 기본적으로 
		DataSource가 필요하므로 의존성을 주입한다. */

		//JdbcTokenRepositoryImpl는 이 토큰을 데이터베이스에 저장하는 구현체
		JdbcTokenRepositoryImpl repo = new JdbcTokenRepositoryImpl();
		repo.setDataSource(dataSource);	//JdbcTokenRepositoryImpl에 dataSource를 주입
		return repo;
	}
		
}
