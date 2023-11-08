<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- CSRF 토큰 설정 --%>
<meta name="_csrf_header" content="${_csrf.headerName}">
<meta name="_csrf" content="${_csrf.token}">
<title>bonshop : 비밀번호 변경</title>
<script src="/js/jquery.js"></script>
<link href="/css/main.css" rel="stylesheet"/>
<link href="/css/myPage/home.css" rel="stylesheet"/>
<link href="/css/myPage/pwChange.css" rel="stylesheet"/>
<!--알람(alert) 라이브러리-->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" type="text/css" href="/css/alert.css">
</head>
<body>
<%-- include : main --%>
<%@ include file="../include/header.jsp" %>

<!-- 비밀번호 변경 섹션 -->
<div class="Mypage">
    <div class="Mypage_menu">
        <h2>마이페이지</h2>
        <img id="mypage_img" alt="사람" src="/imgs/member/people.png"> <!-- 추후에 이진파일로 사진바꾸게 시도 -->
        <ul>
            <li><a href="#">주문 내역 조회</a></li>
            <li><a href="#">장바구니</a></li>
            <li><a href="#">찜한 상품</a></li>
            <li><a href="#">상품 문의</a></li>
        </ul>
    </div>
    <div id="mypage_show">
        <h1>회 원 정 보 🧐 수 정 / 탈 퇴</h1>
        <div class="form-container">
            ※ 기존의 비밀번호와 똑같이 설정할 수 없습니다.
            <form action="/myPage/pwChange" method="post" class="password-form">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                
                <div class="form-group">
                    <label for="m_pwd">새로운 비밀번호</label>
                    <input type="password" name="m_pwd" id="m_pwd">
                </div>
                
                <div class="form-group">
                    <label for="m_pwd2">비밀번호 확인</label>
                    <input type="password" name="m_pwd2" id="m_pwd2">
                </div>
                
                <div class="form-group">
                    <input type="button" onclick="ckPwd()" value="비밀번호 변경">
                </div>
            </form>
        </div>
    </div>
</div>

<div class="clearfix"></div>

<script>
//비밀번호 정규식 체크
let pwdType = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;

function ckPwd() {
    if ($.trim($("#m_pwd").val()) == "") {
        alert("새로운 비밀번호를 입력하세요!");
        $("#username").val("").focus();
        return false;
    }
    if ($.trim($("#m_pwd2").val()) == "") {
        alert("비밀번호 확인을 입력하세요!");
        $("#password").val("").focus();
        return false;
    }
    
  //비밀번호 검증
	  if(!pwdType.test(m_pwd2.value)){
		  alert("비밀번호는 영문자+숫자+특수문자 조합 \n 8이상~12자리 이하로만 사용해야합니다. ");
		  $("#m_pwd2").val("").focus();
		  return false;
	  }
	  
	  //비밀번호 일치 테스트
	 if(m_pwd.value !== m_pwd2.value ){
		 alert("비밀번호가 일치하지 않습니다!");
		  $("#m_pwd2").val("").focus();
		  return false;
	 }
    
    return true;  // 유효성 검사가 모두 통과했을 때
}
// 2023-11-08 비밀번호 변경 js, css , jsp 수정할것
</script>

<%-- include : footer --%>
<%@ include file="../include/footer.jsp" %>
</body>
</html>
