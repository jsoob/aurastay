<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
</head>
<body>
<h3>비밀번호 재설정</h3>
<%-- user가 0이면 member--%>
<%-- user가 1이면 business--%>
<form action="" method="post">
    <%--  패스워드 두개가 동일한지 확인하는 로직 필요  --%>
    <input type="password" name="password" id="password">
    <input type="password" id="confirmPassword">

    <c:if test="${user}==0">
        <input type="hidden" name="email" value="${member.memberEmail}">
    </c:if>
    <c:if test="${user}==1">
        <input type="hidden" name="email" value="${business.businessEmail}">
    </c:if>
        <input type="hidden" name="user" value="${user}">
    <button type="submit">재설정</button>
</form>
</body>
</html>