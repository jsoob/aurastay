<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title> ${dto.acmName} 숙소 정보 조회/변경</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>


<jsp:include page="../comm/header.jsp"/>
<jsp:include page="../comm/sidebar.jsp"/>

<div class="main-content">
    <h2 class="text-center">📌 ${dto.acmName} 상세 조회</h2>
    <form action="/acmAdd" method="get">
        <table class="table">
            <h3>숙소 정보에 대한 상세한 조회 및 변경하는 페이지입니다.</h3>
            <c:forEach var="dto" items="list">
                <tr>
                    <th>주소</th>
                    <th>상세설명</th>
                    <th>체크인 시간</th>
                    <th>체크아웃 시간</th>
                    <th>사업자번호</th>
                    <th>전화번호</th>
                    <th>키워드</th>
                    <th>카테고리</th>
                </tr>

            </c:forEach>
        </table>
    </form>


    <jsp:include page="../comm/footer.jsp"/>
</body>
</html>
