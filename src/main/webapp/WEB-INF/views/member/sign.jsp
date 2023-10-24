<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<%--ajax 통신 시 403 forbidden 에러 발생 해결법 => csrf(Cross-site request forgery)의 token이 누락으로 발생하기 때문에 
아래 코드 2개 추가 --%>
<meta name="_csrf_header" content="${_csrf.headerName}">
<meta name="_csrf" content="${_csrf.token}">

<title>bonshop : 회원가입 페이지</title>
<script src="/js/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="/css/member/sign.css">
<script type="text/javascript" src="/js/member/sign.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500&display=swap" rel="stylesheet">

<!--알람(alert) 라이브러리-->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" type="text/css" href="/css/alert.css">


</head>
<body>
<%-- include : main --%>
<%@ include file="../include/header.jsp" %>

<div id="bigbox">
<form name="m" method="post">
	<div id="logo">
		<hr>
		BONSHOP
		<hr>
	</div>
	<div id="wrap" >
		<!--아이디 & 비밀번호  -->
		<div id="form1">
			<div id="idform">
				<input type="text" id="m_id" name="m_id" placeholder="아이디"><br>
				<span id="idcheck"></span>
			</div>
			<div id="checkid">
				<strong><input type="button" id="ckidbtn" onclick="return checkid();" value="중복 확인"></strong>
			</div>
			<div id="pwdform">
				<input type="password" id="m_pwd" name="m_pwd" placeholder="비밀번호">
				<span class="pwdck"></span>
			</div>
			<div id="pwdCKform">
				<input type="password" id="m_pwd2" name="m_pwd2" placeholder="비밀번호 확인">
				<span class="m_pwd2"></span>
			</div>
		
		<!-- 개인정보 -->
			<div id="nameform">
				<input type="text" id="m_name" name="m_name" placeholder="이름">
				<span class="nameck"></span>
			</div>
			
			<div id="birthform">
				<input type="text" id="m_birth" name="m_birth" placeholder="생년월일 ex: 20020102">
				<span class="birthck"></span>
			</div>
			
			<div id="emailform">
				<input type="text" id="m_email" name="m_email" placeholder="이메일">
			</div>
			
			<div id="phoneform">
				<input type="text" id="m_phone" name="m_phone" placeholder="전화번호 ex: 01011112222">
				<span class="phoneck"></span>
			</div>
			
			<div id="telform">
				<select id="m_tel" name="m_tel" class="select">
		    		<option value="">통신사 선택</option>
		    		<option value="SK">SK</option>
		    		<option value="KTF">KT</option>
		    		<option value="LG">LGU+</option>
		    		<option value="알뜰">알뜰폰</option>
				</select>
			</div>
			
			<!-- 주소검색  -->
			<div id="address"> <!-- 버튼 -->
				<input id="addrbtn" type="button" value="주소검색" onclick="post_check();"/>
			</div>
			<div id="zipform">
				<input name="m_zipCode" id="m_zipCode" placeholder="우편번호" readonly /> <%-- readonly 속성은 읽기만 가능. --%>
			</div>
			<div id="zipform">
				<input name="m_addr" id="m_addr" placeholder="주소" readonly />
			</div>
			
			<div id="zipform">
				<input name="m_addr2" id="m_addr2" placeholder="나머지 주소"/>
			</div>
			
			
			

			<!-- 유효성 검증 창 -->
			<span id="text"></span>
			<!-- 버튼 -->
			<div id="form3">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			      <%--post방식으로 데이터를 전송할 때에는 스프링 시큐리티에서는 CSRF 토큰을 같이 보내야 한다. --%>
			
				<strong>
				<button type="button" value="Y" name="Y" id="sign" onclick=" return joinCheck()" >가입하기</button>
				</strong>
			</div>
		</div><%--form1 end --%>
	</div> <%-- wrap end --%>
</form>
</div>

<%-- include : footer --%>
<%@ include file="../include/footer.jsp" %>
</body>
</html>

