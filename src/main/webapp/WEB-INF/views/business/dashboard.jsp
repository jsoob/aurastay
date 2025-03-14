<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title> </title>
</head>
<body>
<%-- 해나언니가 만든 dashboard로 이동 --%>
<ul>
    <li><sec:authentication property="principal.username" /></li>
    <li><sec:authentication property="principal" /></li>
</ul>
</body>
</html>