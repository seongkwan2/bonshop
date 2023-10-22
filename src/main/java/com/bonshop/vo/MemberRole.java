package com.bonshop.vo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Entity
@SequenceGenerator(//@SequenceGenerator는 시퀀스 생성기를 설정하는 애노테이션
		name="bs_member_seq_gename", //시퀀스 제너레이터 이름
		sequenceName="bs_member_seq", //시퀀스 이름
		initialValue=1, //시작값
		allocationSize=1 //메모리를 통해 할당할 범위 사이즈=>기본값은 50이며, 
		//1로 설정하는 경우 매번 insert시마다 DB의 시퀀스를 호출해서 db시퀀스 번호값을 가져와서
		//1증가한 값이 할당된다. 1씩 증가. 증가값		
		)
@Table(name = "bs_member_roles")
@EqualsAndHashCode(of = "fno")
@ToString
public class MemberRole {//회원이 가지는 권한

	  @Id
	  @GeneratedValue(
				strategy=GenerationType.SEQUENCE, //사용할 전략을 시퀀스로  선택
				generator="bs_member_seq_gename" //식별자 생성기를 설정해놓은 bs_member_seq_gename 시퀀스 제너레이터 이름으로 설정
				)
	  private int fno;
	  
	  private String roleName;
}
