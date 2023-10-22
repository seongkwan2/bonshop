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

@Setter //setter()메서드 자동제공
@Getter //getter()메서드 자동제공
@ToString //toString() 메서드 자동제공
@Entity
@SequenceGenerator(//@SequenceGenerator는 시퀀스 생성기를 설정하는 애노테이션
		name="zip_seq_gename", //시퀀스 제너레이터 이름
		sequenceName="zip_seq", //시퀀스 이름
		initialValue=1, //시작값
		allocationSize=1 //메모리를 통해 할당할 범위 사이즈=>기본값은 50이며, 1로 설정하는 경우 매번 insert시마다 DB의 시퀀스를 호출해서 db시퀀스 번호값을 가져와서
		//1증가한 값이 할당된다. 1씩 증가. 증가값		
		)
@Table(name="zipcode")
@EqualsAndHashCode(of="no")
/* equals(), hashCode(),canEqual() 메서드 자동제공 * 
 */
public class ZipCodeVO {//우편번호,주소등 저장할 엔티티빈 클래스

	@Id //구분키(식별키) 즉 유일키로 사용될 기본키 컬럼 즉 primary key
	@GeneratedValue(
			strategy=GenerationType.SEQUENCE, //사용할 전략을 시퀀스로 선택
			generator="zip_seq_gename" //식별자 생성기를 설정해놓은 시퀀스 제너레이터 이름으로 설정
			)
	private int no;
	
	private String zipcode;//우편번호
	private String sido;//시도
	private String gugun;//구군
	private String gil;//도로명 또는 지번(읍.면.동.리)
	private String bunji;//번지
	
}  
