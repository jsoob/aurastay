<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%-- ★ {dto.acmName} 씹히는 거 고치기 --%>
    <title> ${dto.acmName} 숙소 정보 조회/변경</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- accAdd.CSS 파일 연결 -->
    <link rel="stylesheet" type="text/css" href="../css/acm.css">

    <script>
        $(document).ready(function () {
            $("#btn").click(function () {
                // 새로운 파일 입력 필드 추가
                let newFileInput = '<input type="file" name="file">';
                $(this).before(newFileInput); // 버튼 앞에 추가
            });
        });
    </script>

</head>

<jsp:include page="../comm/header.jsp"/>
<jsp:include page="../comm/sidebar.jsp"/>

<body>
<div class="main-content">
    <h2>${dto.acmName}의 상세정보</h2>
    <ul>
        <c:forEach var="room" items="${roomList}">
            <li>${room.roomName}</li>
            <%--객실 정보 아래에 출력하기--%>

        </c:forEach>
    </ul>
    <form action="/accommodation/acmAdd" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <%--숙소명--%>
            <label>숙소명</label>
            <td>${dto.acmName}</td>
        </div>
        <div class="form-group">
            <%--주소--%>
            <label>주소</label>
            <td>${dto.acmAddress}</td>
        </div>
        <div class="form-group">
            <%--연락처--%>
            <label>연락처</label>
            <td>${dto.acmTel}</td>
        </div>
        <div class="check-group">
            <div class="check-item">
                <%--체크인--%>
                <label class="form-label">체크인</label>
                <td>${dto.checkinTime}</td>
            </div>
            <div class="check-item">
                <%--체크아웃--%>
                <label class="form-label">체크아웃</label>
                <td>${dto.checkoutTime}</td>
            </div>
        </div>
        <br>
        <div class="form-group">
            <%--내용--%>
            <label>내용</label>
            <td>${dto.contents}</td>
        </div>

        <div>
            <div class="form-group">
                <label>Category</label>
                <%--카테고리 목록 중에 선택한 카테고리의 정보를 불러와야 한다--%>
                <span>${category.categoryName}</span> <!-- 카테고리 이름을 출력 -->
            </div>


            <div class="form-group">
                <%-- 키워드 --%>
                <label>Keyword</label>
                <span>${keyword.keywordName}</span>
            </div>

        </div>
        <h3>객실 리스트</h3>

        <div>
            <label>편의시설</label>
            <span>${amenities.amenitiesName}</span>

        </div>



        <div>
            <label class="form-label">첨부파일</label>
            <input type="file" name="files" multiple> <%--여러 개의 파일을 선택할 수 있도록 multiple 추가--%>
            <input type="button" value="추가" id="btn">
        </div>

        <div class="btn-container">
            <a href="acmList" class="btn btn-primary">목록</a>
            <a href="modify?acmNo=${dto.acmNo}" class="btn btn-primary">수정(등록)</a>
            <a href="delete?acmNo=${dto.acmNo}" class="btn btn-secondary">삭제</a>

        </div>
    </form>
</div>
</body>

<jsp:include page="../comm/footer.jsp"/>
</html>

