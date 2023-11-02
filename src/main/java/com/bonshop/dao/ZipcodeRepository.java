package com.bonshop.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.bonshop.vo.ZipCodeVO;
												//참조하는 VO, Primarykey의 자료형
public interface ZipcodeRepository extends JpaRepository<ZipCodeVO, Integer> {
	
	@Query("select z from ZipCodeVO z where z.gil like ?1 and z.no> 0 order by z.no desc") 
	// JPQL(JPA에서 사용하는 Query Language => Java Persistence Query Language의 약어)이다.
	// JPQL은 테이블 대신 엔티빈 클래스를 이용하고,테이블 컬럼대신 엔티티빈 클래스의 변수 즉 속성을 이용한다. 
	// ?1은 첫 번째로 전달되는 피라미터 값이라는 의미이다.
	public List<ZipCodeVO> findByDong(String dong); //우편번호 검색

}
