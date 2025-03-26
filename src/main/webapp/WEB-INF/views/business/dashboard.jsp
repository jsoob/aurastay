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

<h3>요기가 dto자리
    <ul>
        <li>${dto.businessNo}</li>
        <li>${dto.businessName}</li>
        <li>${dto.representativeName}</li>
        <li> ${dto.businessEmail}</li>
        <li>${dto.businessPhoneNumber}</li>
        <li>${dto.businessPassword}</li>
        <li>${dto.businessAccount}</li>
        <li>${dto.registrationDate}</li>
        <li>${dto.withdrawalDate}</li>
        <li>${dto.authority}</li>
    </ul>

</h3>
</body>
</html>