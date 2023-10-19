<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

</head>
<body>
<header id="header">
    <nav class="menu">
        <ul>
            <li><a href="/items/outer">OUTER</a></li>
            <li><a href="/items/top">TOP</a></li>
            <li><a href="/items/pants">PANTS</a></li>
            <li><a href="/items/acc">ACC</a></li>
            <li><a href="/items/bag_shoes">BAG/SHOES</a></li>
            <li><a href="/items/ranking">RANKING</a></li>
        </ul>
    </nav>

    <div class="login"><!-- 기본 내장객체 sessionScope를 사용하여 세션에 접근 -->
        <c:choose> 
            <c:when test="${!empty sessionScope.logined}">
            <span>${sessionScope.logined.m_name}님 안녕하세요😊</span>
           		<form action="/member/myPage" method="get">
                    <input type="submit" value="마이페이지" />
                </form>
                <form action="/member/logout" method="post">
                    <input type="submit" value="로그아웃" />
                </form>
                
            </c:when>
            <c:otherwise>
            <form action="/member/sign" method="get">
                    <input type="submit" value="회원가입" />
                </form>
                <form action="/member/login" method="get">
                    <input type="submit" value="로그인" />
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</header>
  
