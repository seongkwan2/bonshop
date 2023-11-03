<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="phone" value="${memberInfo.m_phone}" /> <%--전화번호를 010-1111-2222 형식으로 바꿈 --%>
<c:set var="birth" value="${memberInfo.m_birth}" /> <%--생년월일을 1996-03-07 형식으로 바꿈 --%>
<c:set var="formattedPhone" value="${fn:substring(phone, 0, 3)}-${fn:substring(phone, 3, 7)}-${fn:substring(phone, 7, 11)}" />
<c:set var="formattedbirth" value="${fn:substring(birth, 0, 4)}-${fn:substring(birth, 4, 6)}-${fn:substring(birth, 6, 8)}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%--ajax 통신 시 403 forbidden 에러 발생 해결법 => csrf(Cross-site request forgery)의 token이 누락으로 발생하기 때문에 
아래 코드 2개 추가 --%>
<meta name="_csrf_header" content="${_csrf.headerName}">
<meta name="_csrf" content="${_csrf.token}">
<title>bonshop : 마이 페이지</title>
<script src="/js/jquery.js"></script>
<link href="/css/main.css" rel="stylesheet"/>
<link href="/css/myPage/home.css" rel="stylesheet"/>
</head>
<body>
<%-- include : main --%>
<%@ include file="../include/header.jsp" %>

<!-- 수정시 전송되는 폼 -->

	<div class="Mypage">
		<div class="Mypage_menu">
			<h2>마이페이지</h2>
			<img id="mypage_img" alt="사람" src="/imgs/member/people.png"> <!-- 추후에 이진파일로 사진바꾸게 시도 -->
			<ul>
				<li><a href="#">주문 내역 조회</a> <!-- 10월26일 마무리 수정,탈퇴버튼 css손볼것 그리고 주소검색기능 구현할것 -->
				<li><a href="#">장바구니</a>
				<li><a href="#">찜한 상품</a>
				<li><a href="#">상품 문의</a>
				<li><input type="button" onclick="openPopup('/myPage/checkPw')"value="정보수정 / 회원탈퇴">
			</ul>
		</div>
		<div id="mypage_show">
			<h1>회 원 정 보 확 인</h1>
			<table id="mypage_st">
					<!-- POST를 위한 토큰 -->
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<tr>
						<th>아이디</th>
						<td>${memberInfo.m_id}</td>
					</tr>
					
					<tr>
						<th>이름</th>
						<td>${memberInfo.m_name}</td>
					</tr>
					
					<tr>
						<th>생년월일</th>
						<td>${formattedbirth}</td>
					</tr>
					
					<tr>
						<th>이메일</th>
						<td>${memberInfo.m_email}</td>
					</tr>
					
					<tr>
						<th>전화번호</th>
						<td>${formattedPhone}</td>
					</tr>
					
					<tr>
						<th>주소</th> <!-- 주소기능 동작하게 구현해야함 -->
						<td>${memberInfo.m_addr}<br>${memberInfo.m_addr2}</td>
					</tr>
					
					<tr>
						<th>우편번호</th>
						<td>${memberInfo.m_zipCode}</td>
					</tr>
					
					<tr>
						<th>가입날짜</th>
						<td>${fn:substring(memberInfo.m_regdate,0,10)}</td>
					</tr>
			</table>
		</div>
	</div>
	
<script>
//비밀번호 확인 팝업창
function openPopup(url) {
    var width = 600; // 팝업 창 가로 크기
    var height = 400; // 팝업 창 세로 크기
    var left = (screen.width - width) / 2; // 화면 가운데 정렬을 위한 좌표
    var top = (screen.height - height) / 2; // 화면 가운데 정렬을 위한 좌표

 // 팝업 창 열기 resizable=no'는 창의 크기 고정
    window.open(url, '_blank', 'width=' + width + ', height=' + height + ', left=' + left + ', top=' + top + ', resizable=no');
}

</script>
	<div class="clearfix"></div>
<%-- include : footer --%>
<%@ include file="../include/footer.jsp" %>
</body>
</html>


