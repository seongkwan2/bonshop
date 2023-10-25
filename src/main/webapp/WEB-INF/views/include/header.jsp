<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
    
	<div class="login">
	    <!-- 로그인 상태일때 -->
	    <sec:authorize access="isAuthenticated()"> 
	        <span> ${name}님 안녕하세요😊</span>
	
	        <form action="/myPage/home" method="get">
	            <input type="submit" value="마이페이지"/>
	        </form>
			<form action="/member/logout" method="post">
	        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <!-- POST로 보낼땐 토큰도 보냄 -->
	        	<input type="submit" value="로그아웃"/>
	     	</form>
	    </sec:authorize>
	    
	    <!-- 로그아웃 상태일때 -->
	    <sec:authorize access="!isAuthenticated()">
	        <form action="/member/sign" method="get">
	            <input type="submit" value="회원가입" />
	        </form>
	        <form action="/member/login" method="get">
	            <input type="submit" value="로그인" />
	        </form>
	    </sec:authorize>
	</div>
</header>
  
