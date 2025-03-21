<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="/css/main.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" href="/css/password.css">
</head>
<body>
<jsp:include page="main/header.jsp"/>
<div class="main container">
    <div class="reset-container">
        <h3>비밀번호 재설정</h3>
        <%-- user가 0이면 member--%>
        <%-- user가 1이면 business--%>
        <form action="/resetPassword" id="resetPasswordForm" method="post">
            <%--  패스워드 두개가 동일한지 확인하는 로직 필요  --%>
            <input type="password" name="password" id="password" placeholder="최소 8자리 / 영문 대소문자, 숫자, 특수문자 조합">
            <input type="password" id="confirmPassword" placeholder="비밀번호 확인">

            <c:if test="${user==0}">
                <input type="hidden" name="email" value="${member.memberEmail}">
            </c:if>
            <c:if test="${user==1}">
                <input type="hidden" name="email" value="${business.businessEmail}">
            </c:if>
            <input type="hidden" name="user" value="${user}">
            <div id="passwordError" class="text-danger small"></div>
            <button type="submit" id="resetBtn">재설정</button>
        </form>
    </div>
</div>
<jsp:include page="main/footer.jsp"/>
<script src="/js/resetPassword.js"></script>
</body>
</html>