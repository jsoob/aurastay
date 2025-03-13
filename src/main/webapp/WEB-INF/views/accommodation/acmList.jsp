<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>숙소 목록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

<jsp:include page="../comm/header.jsp"/>
<jsp:include page="../comm/sidebar.jsp"/>


<div class="main-content">
    <h2 class="text-center">📌 숙소 목록 조회</h2>
    <form action="acmList" method="get">
        <h3>숙소 목록을 조회하는 페이지입니다.</h3>

        <table class="table">
            <c:forEach var="dto" items="${list}">
                <tr>
                    <th>숙소번호</th>
                    <td>${dto.acmNo}</td>
                    <th>숙소이름</th>
                        <%--숙소의 이름을 클릭했을 때 상세내용으로 이동할 것--%>
                    <td><a href="acmInfo?acmNo=${dto.acmNo}">${dto.acmName}</a></td>
                    <th>주소</th>
                    <td>${dto.acmAddress}</td>
                    <th>연락처</th>
                    <td>${dto.acmTel}</td>
                    <th>체크인</th>
                    <td>${dto.checkinTime}</td>
                    <th>체크아웃</th>
                    <td>${dto.checkoutTime}</td>
                </tr>
            </c:forEach>
        </table>
    </form>


    <jsp:include page="../comm/footer.jsp"/>


</body>
</html>