<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title> </title>
</head>
<body>
비밀번호 변경하는 페이지
<form action="" method="post">
<%--  패스워드 두개가 동일한지 확인하는 로직 필요  --%>
<input type="password" name="memberPassword" id="password">
<input type="password" id="confirmPassword">
    <input type="hidden" name="memberEmail" value="${member.memberEmail}">
    <input type="hidden" name="memberNo" value="${member.memberNo}">
<button type="submit">재설정</button>
</form>
</body>
</html>