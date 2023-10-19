<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="/js/jquery.js"></script>
<link href="../css/main.css" rel="stylesheet"/>
<link href="../css/rent.css" rel="stylesheet"/>
</head>
<body>
<jsp:include page="../include/header.jsp"/>
<!-- 페이지 내용 -->

메인페이지 입니다.

<jsp:include page="../include/footer.jsp"/>

<%-- 에러 메시지 확인 및 알림 (로그인 성공시 메시지 출력) --%>
<c:if test="${!empty message}">
    <script>
        alert('${message}');
    </script>
</c:if>
</body>
</html>