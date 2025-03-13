<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>숙소 목록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- accAdd.CSS 파일 연결 -->
    <link rel="stylesheet" type="text/css" href="../css/acmList.css">

</head>
<body>

<jsp:include page="../comm/header.jsp"/>
<jsp:include page="../comm/sidebar.jsp"/>


<div class="main-content">
    <h2 class="text-center">📌 숙소 목록 조회</h2>
    <form action="acmList" method="get">
        <h3>숙소 목록을 조회하는 페이지입니다.</h3>
        <div class="form-group">
            <table class="table">
                <c:forEach var="dto" items="${list}">
                    <tr>
                        <th>숙소번호</th>
                        <th>숙소이름</th>
                        <th>주소</th>
                        <th>연락처</th>
                        <th>체크인</th>
                        <th>체크아웃</th>
                    </tr>
                    <td>${dto.acmNo}</td>
                    <%--숙소의 이름을 클릭했을 때 상세내용으로 이동할 것--%>
                    <td><a href="acmInfo?acmNo=${dto.acmNo}">${dto.acmName}</a></td>
                    <td>${dto.acmAddress}</td>
                    <td>${dto.acmTel}</td>
                    <td>${dto.checkinTime}</td>
                    <td>${dto.checkoutTime}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </form>


    <jsp:include page="../comm/footer.jsp"/>


</body>
</html>