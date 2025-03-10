<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>숙소 목록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

<jsp:include page="../comm/header.jsp"/>
<jsp:include page="../comm/sidebar.jsp"/>


<div class="main-content">
    <h2 class="text-center">📌 숙소 조회</h2>
    <form action="acmList">
        <h3>숙소 목록을 조회하는 페이지입니다.</h3>

        <tr>
            <th>숙소번호</th>
            <th>주소</th>
            <th>상세설명</th>
            <th>체크인 시간</th>
            <th>체크아웃 시간</th>
            <th>사업자번호</th>
            <th>전화번호</th>
            <th>키워드</th>
            <th>카테고리</th>
        </tr>

    </form>


    <jsp:include page="../comm/footer.jsp"/>


</body>
</html>