package com.bonshop.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.bonshop.vo.PersistentLogin;

public interface PersistentLoginRepository extends JpaRepository<PersistentLogin, String> {
}	//JpaRepository를 상속받음으로써 기본적인 CRUD 메서드를 사용가능,	<사용하는 파일(엔티티), id값의 타입>
