<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>회원탈퇴</title>
</head>
<body>
    <form id="logoutForm" action="/member/logout" method="post">
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <!-- POST로 보낼땐 토큰도 보냄 -->
	</form>
	
    <script>
    alert("회원탈퇴가 완료되었습니다.");
        // 문서가 로드되자마자 로그아웃 폼을 제출
        window.onload = function() {
            document.getElementById('logoutForm').submit();
        }
    </script>
</body>
</html>
