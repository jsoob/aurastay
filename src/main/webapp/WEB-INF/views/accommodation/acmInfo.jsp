<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
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
<%--    <ul>--%>
<%--        <c:forEach var="room" items="${roomList}">--%>
<%--            <li>${room.roomName}</li>--%>
<%--            &lt;%&ndash;객실 정보 아래에 출력하기&ndash;%&gt;--%>
<%--        </c:forEach>--%>
<%--    </ul>--%>
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



        <h3>객실 리스트(정보)</h3>
        <ul>
            <c:forEach var="room" items="${roomList}">
                <li>
                    <strong>객실명:</strong> ${room.roomName}<br>
                    <strong>객실 수량:</strong> ${room.roomQty}<br>
                    <strong>최대 인원 수:</strong> ${room.roomCapacity}<br>
                    <strong>가격:</strong> ${room.roomPrice}<br>
                    <strong>할인율:</strong> ${room.roomDiscount}%<br>
                    <strong>뷰타입:</strong> ${room.roomViewType}<br>
                    <strong>상세 설명:</strong> ${room.roomContents}<br>
                    <hr>
                </li>
            </c:forEach>
        </ul>

        <br>
        <div>
            <label class="form-label">편의시설</label>
            <span>${dto.amenitiesName}</span> <!-- 편의시설 이름 출력 -->
        </div>
<br>


        <div>
            <label class="form-label">숙소 이미지</label>
            <c:if test="${not empty dto.filenames}">
                <c:forEach items="${dto.filenames}" var="filenames">
<%--                    <img src="${pageContext.request.contextPath}${filepath}" alt="${dto.acmName} 이미지" style="width:200px; height:auto;" />--%>
                    <img src="/accommodation/views/${filenames}" alt="${dto.acmName} 이미지" style="width:200px; height:auto;" />
                    <div class="alert alert-success">${message}</div>
                </c:forEach>
            </c:if>

<%--            <c:if test="${not empty dto.clientFilepath}">--%>
<%--                <c:forEach items="${dto.clientFilepath}" var="filepath">--%>
<%--                    <img src="${filepath}" alt="${dto.acmName} 이미지" style="width:200px; height:auto;" />--%>
<%--                </c:forEach>--%>
<%--            </c:if>--%>


        </div>


        <div class="btn-container">
            <a href="acmList" class="btn btn-list">목록</a>
            <a href="modify?acmNo=${dto.acmNo}" class="btn btn-submit">수정(등록)</a>
            <a href="delete?acmNo=${dto.acmNo}" class="btn btn-cancel">삭제</a>

        </div>
    </form>
</div>
</body>

<jsp:include page="../comm/footer.jsp"/>
</html>

