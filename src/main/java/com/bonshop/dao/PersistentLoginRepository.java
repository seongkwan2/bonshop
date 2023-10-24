package com.bonshop.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.bonshop.vo.PersistentLogin;

public interface PersistentLoginRepository extends JpaRepository<PersistentLogin, String> {
    // 필요한 경우 메서드 추가
}
