<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf_header" content="${_csrf.headerName}">
<meta name="_csrf" content="${_csrf.token}">
    <title>정보 확인</title>
    <link href="/css/myPage/checkPw.css" rel="stylesheet" />
    <script src="/js/jquery.js"></script>
    
</head>

<body>
    <h2>본인 인증</h2>
    <hr>
    <form action="/myPage/checkPw" method="post">
    <div class="form-group">
        <label for="mPwd">비밀번호:</label>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="password" id="mPwd" name="mPwd" placeholder="비밀번호를 입력해주세요.">
    </div>
    <button id="submit">수정하기</button>
    </form>
 
<script>
    $(document).ready(function() {
        $("#submit").click(function(e) {
            e.preventDefault(); // 폼의 기본 제출을 방지
            
          //CSRF 토큰을 가져와서 헤더에 추가
            var header = $("meta[name='_csrf_header']").attr('content');
            var token = $("meta[name='_csrf']").attr('content');

            $.ajax({
                type: "POST",
                url: "/myPage/checkPw",		//비밀번호를 컨트롤러에 보내고 확인을 받고 여기서 페이지를 이동
                beforeSend: function(xhr){
                    xhr.setRequestHeader(header, token);
                   },
                data: { mPwd: $("#mPwd").val() },
                success: function(map) {
                    console.log(map);  // 전체 응답 확인

                    if (map.authSuccess) {
                    	alert("본인 확인 되었습니다.");
                    	 window.opener.location.href = "/myPage/fixInfo";  //부모창의 페이지를 이동시키는 opener
                    	 window.close();
                    } else {
                        alert("비밀번호 인증에 실패했습니다.");
                    }
                },
                error: function() {
                    alert("서버의 정보를 가져오지 못했습니다. 다시 로그인 해주세요");
                    window.close(); // 팝업 창 닫기
                    window.opener.close();
                }
            });
        });
    });

    function submitMainForm() {
        // 사용자에게 확인을 요구
        var isConfirmed = window.confirm("이대로 수정 하시겠습니까?");

        // 사용자가 확인 버튼을 눌렀다면
        if (isConfirmed) {
            var form = window.opener && window.opener.document.getElementById('fixMember');
            if (form) {
                form.submit();
                console.log("submitMainForm 동작");
                window.close();
            } else {
                alert("통신 에러가 발생했습니다. 다시 로그인 해주세요");
            }
        } else {
            alert("회원 수정이 취소되었습니다.");
            window.close();
        }
    }


</script>

</body>
</html>
