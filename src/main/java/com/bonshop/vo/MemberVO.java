package com.bonshop.vo;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@Entity
@Table(name="bs_member")
@EqualsAndHashCode(of="m_id")
/* equals(), hashCode(),canEqual() 메서드 자동제공 * 
 */
public class MemberVO {//회원관리 엔티티빈 클래스

	@Id //유일키로 사용될 기본키 컬럼 즉 primary key	
	private String m_id;//회원아이디

	private String m_pwd;//비번
	private String m_name;//회원이름
	private String m_birth;//생년월일
	private String m_email;//이메일
	private String m_phone;//전화번호
	private String m_zipCode;//우편번호
	private String m_addr;//주소
	private String m_addr2;//나머지 주소
	@CreationTimestamp //@CreationTimestamp 는 하이버네이트의 특별한 기능으로 등록시점 날짜값을 기록,mybatis로 실행할 때는 구동 안됨.
	private Timestamp m_regdate;//가입날짜	

	@OneToMany(cascade = CascadeType.ALL, fetch=FetchType.EAGER) //일대다 연관관계,cascade = CascadeType.ALL은 JPA에서 영속성 전이중에서 
	//모든 변경에 대한 전이로서 모든 엔티티빈 상태 변화에 대해서 같이 처리하는 옵션, fetch=FetchType.EAGER는 tbl_members3와 tbl_member_roles3 두 테이블을 조회해야 하기
	//때문에 트랜잭션을 처리해 주거나, 즉시 로딩을 이용해서 조인하는 방법으로 처리해야 한다. 권한 정보는 회원정보와 마찬가지로 필요한 경우가 많기 때문에 fetch 모드를 즉시 로딩으로 
	//설정한다.
	
	//@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER) 설정은, 
	//cascade의 경우에는 엔티티들의 영속관계를 한번에 처리하지 못하기 때문에 이에 대한 cascade 설정을 추가하는것이고, 
	//member와 member_role을 둘다 동시에 조회하기 위해서 fetch 설정을 즉시 로딩으로 EAGER 설정을 주어야 에러가 발생하지 않습니다.
	@JoinColumn(name = "member") //이미 존재하는 bs_member_roles 테이블에 member컬럼 추가 , foreign key 추가 설정
	private List<MemberRole> roles;	
}
