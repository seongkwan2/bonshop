package com.bonshop.security;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;

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

	@Override
	protected void configure(HttpSecurity http) throws Exception {//configure() 메서드를 오버라이딩을 해서 간단한 로그 메시지를 출력한다.
		//HttpSecurity는 웹과 관련된 다양한 보안설정을 걸어 줄 수 있다.

		log.info("security config ......");
		//permitAll()은 모든 사용자가 접근할 수 있다는 것을 의미
		http.authorizeRequests().antMatchers("/guest/**").permitAll();//authorizeRequests()는 시큐리티 처리에서 HttpServletRequest에 해당한다.
		http.authorizeRequests().antMatchers("/manager/**").hasRole("MANAGER"); //hasRole()은 특정권한을 가진 사람만이 접근가능
		http.authorizeRequests().antMatchers("/admin/**").hasRole("ADMIN");
		http.authorizeRequests().antMatchers("/member/sign").permitAll();//authorizeRequests()는 시큐리티 처리에서 HttpServletRequest에 해당한다.
		
		//로그인 페이지
		http.formLogin().loginPage("/login");
		
		//403 접근금지 에러가 났을 때 실행
		http.exceptionHandling().accessDeniedPage("/accessDenied");
		
		//로그아웃시 세션무효화
		http.logout().logoutUrl("/logout").invalidateHttpSession(true);
		
		
		http.rememberMe().key("zerock").userDetailsService(zerockUsersService)	
		//rememberMe()에서 쿠키값을 암호화 해서 전달하므로 암호의 '키(key)'를 지정하여 사용
		.tokenRepository(getJDBCRepository())
	    .tokenValiditySeconds(60*60*24);//쿠키 유효 시간을 초단위로 설정 => 60초*60분*24시간 즉 24시간 쿠키 유효시간 설정			
    }//configure()



	private PersistentTokenRepository getJDBCRepository() {
		/*  SecurityConfig 에서 rememberMe()를 처리할 때 JdbcTokenRepositoryImpl을 지정해 주어야 하는데 기본적으로 
		 *   DataSource가 필요하므로 의존성을 주입한다. */

		JdbcTokenRepositoryImpl repo = new JdbcTokenRepositoryImpl();
		repo.setDataSource(dataSource);
		return repo;
	}
		
}
