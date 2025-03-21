<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<h3>
    <%-- 어떻게 사용할지 생각해볼것 --%>
    <c:if test="${id!=null}">
        <h3>${id}</h3>
    </c:if>

    <c:if test="${not empty sessionScope.id}">
        <p>회원 id: ${sessionScope.id}</p>
    </c:if>
</h3>
</body>
</html>