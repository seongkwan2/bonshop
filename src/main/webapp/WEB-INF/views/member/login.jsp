<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonshop : 로그인페이지</title>

<link rel="stylesheet" type="text/css" href="/css/member/login.css">
<script src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/member/login.js"></script>

<!-- 네이버 인증 로그인 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="UTF-8"></script>

<!-- bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
<%-- include : main --%>
<%@ include file="../include/header.jsp" %>

<form action="/member/login" method="post" onsubmit="return logCk();">
	<div id="wrap">
		<div id="all_form">
			<div id="logo">
				<hr>
				BONSHOP
				<hr>
			</div>
			<%--로그인 폼 --%>
			<div id="log_form">
			
				<%--ID칸 --%>
				<div id="id_form">
					<input type="text" id="username" name="username" placeholder="아이디">
				</div>
				
				<%--PW칸 --%>
				<div id="pwd_form">
					<input type="password" id="password" name="password" placeholder="비밀번호">
				</div>
				
				
				<div id="maintain">
					<input type="checkbox" id="remember-me" name="remember-me" checked><label for="remember-me" ><span>로그인 상태 유지</span></label>
					    <%-- 스프링 시큐리티에서는 자동 로그인 유지 기능을 쿠키를 사용해서 remember-me라는 이름으로 특정 토큰 데이터를 2주간 저장 유지한다. 새롭게 추가된
					    체크박스 name 피라미터 이름을 remember-me로 지정한다. 로그인 화면에서 remember-me 체크박스를 선택하고 로그인 하면 웹브라우저 상에 remember-me
					  라는 쿠키가 생성된다.생성된 'remember-me' 쿠키 유효기간은 '로그인 시간+2주' 이다.쿠키는 유효시간이 설정되면 브라우저 내부에 저장한다.
					  따라서 사용자가 브라우저를 종료하고 다시 브라우저를 실행한 다음 같은 서버상의 도메인 주소로 접근하면 자동으로 브라우저에 보관된 'rememeber-me'쿠키는
					  그대로 가진 상태에서 서버에 접근해서 자동 로그인 기능이 유지된다. 물론 로그아웃 하면 브라우저에 저장된 'rememeber-me' 쿠키는 삭제되어서 자동 로그인 기능
					  유지하지 못한다.
					  스프링 시큐리티는 기본적으로 'remember-me'라는 기능을 사용하기 위해서 'Hash-based Token 저장방식' 또는 'Persistent Token' 저장방식을 사용할
					  수 있다. 아무런 설정하지 않으면 'Hash-based Token 저장방식'을 사용한다.
					  --%>
				</div>
				<br>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<%--로그인 버튼 --%>
				<div id="button_form">
					 <strong><input type="submit" value="로그인" id="btn1"></strong>
				</div>
			</div>
			
			<%--아이디, 비밀번호찾기 & 회원가입 --%>
			<div id="another_form">
				<a href="../member/serch_pwd">비밀번호 찾기</a>&nbsp;&nbsp;&#124;
				<a href="../member/serch_id">아이디 찾기</a>&nbsp;&nbsp;&#124;
				<a href="../member/sign">회원가입</a>&nbsp;&nbsp;
			</div>
			
			<%-- SNS 로그인 --%>
			<div id="social">
				<a href="#"><img src="../imgs/member/naver_icon.png"  id="naver"></a>
				<a href="#"><img src="../imgs/member/kakao_icon.png" id="kakao"></a>
				<a href="#"><img src="../imgs/member/google_icon.png"  id="google"></a>
			</div>
			
			<%-- 기타--%>
			<div id="ano">
				<span>BONSHOP&nbsp;&nbsp;&#124;</span>
				<span> Copyright&nbsp;</span>
				<span>All Rights Reserved.</span>
			</div>
		</div><%--allform end --%>
	</div><%-- wrap end --%>
</form>

<%-- 각종 전달된 메시지 출력 --%>
<c:if test="${!empty message}">
    <script>
        alert('${message}');
    </script>
    <c:remove var="message" scope="session"/>
</c:if>




<%-- include : footer --%>
<%@ include file="../include/footer.jsp" %>
</body>
</html>