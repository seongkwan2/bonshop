package com.bonshop.vo;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString 
@Entity	//Spring Security에서 "Remember Me" 기능을 사용할 때 관련된 데이터를 저장하기 위한 테이블
@Table(name = "persistent_logins")
public class PersistentLogin {

    @Id
    @Column(name = "series")
    private String series;		// 고유한 시리즈 식별자

    @Column(name = "username", length = 64, nullable = false)
    private String username;	// 로그인한 사용자의 이름

    @Column(name = "token", length = 64, nullable = false)
    private String token;		// 사용자가 로그인 상태로 유지될 때마다 변경되는 토큰 값

    @Column(name = "last_used", nullable = false)
    private Timestamp lastUsed;	// 토큰이 마지막으로 사용된 날짜 및 시간

}
