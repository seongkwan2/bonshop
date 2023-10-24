function logCk() {
        if ($.trim($("#username").val()) == "") {
            alert("아이디를 입력하세요!");
            $("#username").val("").focus();
            return false;
        }
        if ($.trim($("#password").val()) == "") {
            alert("비밀번호를 입력하세요!");
            $("#password").val("").focus();
            return false;
        }
        return true;  // 유효성 검사가 모두 통과했을 때
    }