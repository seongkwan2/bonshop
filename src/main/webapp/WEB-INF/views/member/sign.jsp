<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonshop : 회원가입 페이지</title>
<script src="/js/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="/css/member/sign.css">
<script type="text/javascript" src="/js/member/sign.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500&display=swap" rel="stylesheet">

<!--알람(alert) 라이브러리-->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" type="text/css" href="../css/alert.css">


</head>
<body>
<%-- include : main --%>
<%@ include file="../include/header.jsp" %>

<div id="bigbox">
<form action="/member/sign" method="post">
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
				<input type="password" id="pwd_ck" name="pwd_ck" placeholder="비밀번호 확인">
				<span class="pwd_ck"></span>
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
			<!-- 유효성 검증 창 -->
			<span id="text"></span>
			<!-- 버튼 -->
			<div id="form3">
			<!-- security에서 ajax를 사용하기 위한 토큰 -->
				<input type="hidden" id="_csrf" name="_csrf" value="${_csrf.token}"/>
			
				<strong><button type="button" value="Y" name="Y" id="btn1" onclick=" return joinCheck()" >가입하기</button></strong>
			</div>
		</div><%--form1 end --%>
	</div> <%-- wrap end --%>
</form>
</div>

<script>
//폼을 보내는 함수
function sendForm(){
	var formData = {	//여기에 토큰을 넣으면 안됨
			"m_id": $("#m_id").val(),
	        "m_pwd": $("#m_pwd").val(),
	        "m_name": $("#m_name").val(),
	        "m_birth": $("#m_birth").val(),
	        "m_email": $("#m_email").val(),
	        "m_phone": $("#m_phone").val(),
	        "m_tel": $("#m_tel").val()
	}; //formData
	
	// CSRF 토큰을 가져와서 헤더에 추가
    var csrfToken = $("meta[name='_csrf']").attr("content");
    var csrfHeader = $("meta[name='_csrf_header']").attr("content");
	
	$.ajax({
	    url:"/member/sign",
	    method:"POST",
	    data:JSON.stringify(formData),
	    contentType: "application/json",
	    beforeSend: function(xhr) {	//토큰만 따로 보내는 방식을 선호
	        xhr.setRequestHeader("_csrf", $("#_csrf").val());  // CSRF 토큰 설정
	    },
	    success: function(map) {
	        console.log("Response from server:", map);
	        if(map.status === "true") {
	            Swal.fire({
	                title: '가입성공 입니다.',
	                text: map.message,  // 서버로부터 받은 메시지 사용
	                icon: 'success',
	                confirmButtonText: '확인',
	                customClass: {
	                    title: 'my-title-class',
	                    content: 'my-content-class'
	                }
	            });
	        } else {
	            Swal.fire({
	                title: '가입실패 입니다.',
	                text: map.message,  // 서버로부터 받은 메시지 사용
	                icon: 'error',
	                confirmButtonText: '확인',
	                customClass: {
	                    title: 'my-title-class',
	                    content: 'my-content-class'
	                }
	            });
	        }
	    },
	    error: function(jqXHR, textStatus, errorThrown) {
	        console.error('Error Details:', textStatus, errorThrown);
	        alert('서버와의 통신 중 오류가 발생했습니다.');
	    }
	});//ajax

}//sendForm


</script>
<%-- include : footer --%>
<%@ include file="../include/footer.jsp" %>
</body>
</html>

