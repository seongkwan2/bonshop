<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<!--알람(alert) 라이브러리-->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" type="text/css" href="/css/alert.css">
</head>
<body>
<%-- include : main --%>
<%@ include file="../include/header.jsp" %>
<form name="m" method="post">
	<div class="Mypage">
		<div class="Mypage_menu">
			<h2>마이페이지</h2>
			<img id="mypage_img" alt="사람" src="/imgs/member/people.png"> <!-- 추후에 이진파일로 사진바꾸게 시도 -->
			<ul>
				<li><a href="#">주문 내역 조회</a> <!-- 10월26일 마무리 수정,탈퇴버튼 css손볼것 그리고 주소검색기능 구현할것 -->
				<li><a href="#">장바구니</a>
				<li><a href="#">찜한 상품</a>
				<li><a href="#">상품 문의</a>
			</ul>
		</div>
		<div id="mypage_show">
			<h1>회 원 정 보 확 인 & 수정</h1>
			<table id="mypage_st">
					<!-- POST를 위한 토큰 -->
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<tr>
						<th>아이디</th>
						<td>${memberInfo.m_id}</td>
					</tr>
					
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="m_pwd" id="m_pwd" placeholder="비밀번호 입력"></td>
					</tr>
					
					<tr>
						<th>비밀번호 확인</th>
						<td><input type="password" name="m_pwd2" id="m_pwd2" placeholder="비밀번호 입력"></td>
					</tr>
					
					<tr>
						<th>이름</th>
						<td><input type="text" name="m_name" id="m_name" value="${memberInfo.m_name}"></td>
					</tr>
					
					<tr>
						<th>생년월일</th>
						<td><input type="text" name="m_birth" id="m_birth" value="${memberInfo.m_birth}"></td>
					</tr>
					
					<tr>
						<th>이메일</th>
						<td><input type="text" name="m_email" id="m_email" value="${memberInfo.m_email}"></td>
					</tr>
					
					<tr>
						<th>전화번호</th>
						<td><input type="text" name="m_phone" id="m_phone" value="${memberInfo.m_phone}"> &nbsp;</td>
					</tr>
					
					<tr>
						<th>우편번호</th>
						<td><input type="text" name="m_zipCode" id="m_zipCode" value="${memberInfo.m_zipCode}" readOnly></td>
					</tr>
					
					<tr>
						<th>주소</th> <!-- 주소기능 동작하게 구현해야함 -->
						<td><input type="text" name="m_addr" id="m_addr" value="${memberInfo.m_addr}" readOnly>
						<input type="button" value="주소" class="input_b" onclick="post_check();" /><br>
						<input type="text" name="m_addr2" id="m_addr2" value="${memberInfo.m_addr2}"></td>
					</tr>
					
					<tr>
						<th>가입날짜</th>
						<td>${fn:substring(memberInfo.m_regdate,0,10)}</td>
					</tr>
					<tr>
						<td><input type="button" onclick=" return joinCheck()" value="수정">&nbsp;
							<input type="button" value="탈퇴"></td>
					</tr>
					
			</table>
		</div>
	</div>	
	<div class="clearfix"></div>
</form>
<script>
//모든 폼을 입력했는지 체크하는 함수 joinCheck()
//비밀번호 정규식 체크
let pwdType = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;

function joinCheck(){
	
	if($.trim($("#m_pwd").val())== ""){
		  alert("비밀번호를 입력하세요!");
		  $("#m_pwd").val("").focus();
		  return false;
	  }
	  if($.trim($("#m_pwd2").val())== ""){
		  alert("비밀번호 확인을 입력하세요!");
		  $("#m_pwd2").val("").focus();
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
	  
	  // 이름 검증
	  if($.trim($("#m_name").val())== ""){
		  alert("이름을 입력하세요!");
		  $("#m_name").val("").focus();
		  return false;
	  }
	  
	 // 생년월일 검증
	    let birthValue = $.trim($("#m_birth").val());
	    if(!/^[0-9]{8}$/.test(birthValue)){
	        alert("생년월일은 8자리의 숫자만 입력해야 합니다.");
	        $("#m_birth").val("").focus();
	        return false;
	    }

   	// 전화번호 검증
	    let phoneValue = $.trim($("#m_phone").val());
	    if(!/^[0-9]+$/.test(phoneValue)){
	        alert("전화번호는 숫자만 입력해야 합니다.");
	        $("#m_phone").val("").focus();
	        return false;
    	}
    
    	//이메일 검증
	  if($.trim($("#m_email").val())== ""){
		  alert("이메일을 입력하세요!");
		  $("#m_email").val("").focus();
		  return false;
	  }
    	//우편번호
	  if($.trim($("#m_zipCode").val())== ""){
		  alert("우편번호를 입력하세요!");
		  $("#m_zipCode").val("").focus();
		  return false;
	  }
    	//주소
	  if($.trim($("#m_addr").val())== ""){
		  alert("주소를 입력하세요!");
		  $("#m_addr").val("").focus();
		  return false;
	  }
    	//나머지 주소
	  if($.trim($("#m_addr2").val())== ""){
		  alert("상세주소를 입력하세요!");
		  $("#m_addr2").val("").focus();
		  return false;
	  }
      
      // 모든 조건을 통과하면 form 제출
      sendForm();
}

function sendForm(){
	var formData = {	//여기에 토큰을 넣으면 안됨
	        "m_pwd": $("#m_pwd").val(),
	        "m_name": $("#m_name").val(),
	        "m_birth": $("#m_birth").val(),
	        "m_email": $("#m_email").val(),
	        "m_phone": $("#m_phone").val(),
	        "m_zipCode": $("#m_zipCode").val(),
	        "m_addr": $("#m_addr").val(),
	        "m_addr2": $("#m_addr2").val(),
	}; //formData
	
	// CSRF 토큰을 가져와서 헤더에 추가
    var csrfToken = $("meta[name='_csrf']").attr("content");
    var csrfHeader = $("meta[name='_csrf_header']").attr("content");
	
	$.ajax({
	    url:"/myPage/home",
	    method:"POST",
	    data:JSON.stringify(formData),
	    contentType: "application/json",
	    beforeSend: function(xhr) {	//토큰만 따로 보내는 방식을 선호
	    	xhr.setRequestHeader(csrfHeader, csrfToken);
	    },
		success: function(map) {
		    console.log("Response from server:", map);
		    if(map.status === "success") {
		        Swal.fire({
		            title: '회원정보가 수정되었습니다.',
		            text: map.message,  // 서버로부터 받은 메시지 사용
		            icon: 'success',
		            confirmButtonText: '확인',
		            customClass: {
		                title: 'my-title-class',
		                content: 'my-content-class'
		            }
		        }).then((result) => {
		            if (result.isConfirmed) {
		                // 사용자가 확인 버튼을 클릭한 경우
		                window.location.href = "/";
		            }
		        });
		    } else {
		        Swal.fire({
		            title: '회원정보 수정이 취소되었습니다.',
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

}//sendForm()


</script>

<%-- include : footer --%>
<%@ include file="../include/footer.jsp" %>
</body>
</html>


