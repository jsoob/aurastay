<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${dto.acmName} 숙소 정보 조회/변경</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- 공통 CSS 파일 연결 -->
    <link rel="stylesheet" type="text/css" href="../css/common.css">
    <!-- acmInfo 전용 CSS 파일 연결 -->
    <link rel="stylesheet" type="text/css" href="../css/acmInfo.css">

    <script>
        $(document).ready(function () {
            // 이미지 클릭 시 모달 열기
            $('.modal-img').click(function () {
                var imgSrc = $(this).attr('src');
                $('#modal-img').attr('src', imgSrc);
                $('#imageModal').fadeIn(); // 모달 표시
            });

            // 모달 클릭 시 닫기
            $('#imageModal').click(function () {
                $(this).fadeOut(); // 모달 숨기기
            });
        });
    </script>

</head>

<jsp:include page="../comm/header.jsp"/>
<jsp:include page="../comm/sidebar.jsp"/>

<body>
<div class="main-content">
    <h2>${dto.acmName}의 상세정보</h2>
    <form action="/accommodation/acmUpdate" method="post" enctype="multipart/form-data">
        <div class="info-card">
            <div class="form-group">
                <label>숙소명</label>
                <span>${dto.acmName}</span>
            </div>
            <hr>
            <div class="form-group">
                <label>주소</label>
                <span>${dto.acmAddress}</span>
            </div>
            <hr>
            <div class="form-group">
                <label>연락처</label>
                <span>${dto.acmTel}</span>
            </div>
            <hr>
            <div class="check-group">
                <div class="check-item">
                    <label class="form-label">체크인</label>
                    <span>${dto.checkinTime}</span>
                </div>
                <div class="check-item">
                    <label class="form-label">체크아웃</label>
                    <span>${dto.checkoutTime}</span>
                </div>
            </div>
            <hr>
            <div class="form-group">
                <label>내용</label>
                <span>${dto.contents}</span>
            </div>
        </div>

        <div class="info-card">
            <div class="form-group">
                <label>Category</label>
                <span>${category.categoryName}</span>
            </div>
            <hr>
            <div class="form-group">
                <label>Keyword</label>
                <span>${keyword.keywordName}</span>
            </div>
        </div>

        <h3 style="text-align: center;">객실 리스트(정보)</h3>
        <div class="room-list">
            <c:forEach var="room" items="${roomList}">
                <div class="room-card">
                    <div class="room-header">
                        <h4 class="room-title">${room.roomName}</h4>
                    </div>
                    <div class="room-details">
                        <div class="room-detail-item"><strong>객실 수량:</strong> ${room.roomQty}</div>
                        <div class="room-detail-item"><strong>최대 인원 수:</strong> ${room.roomCapacity}</div>
                        <div class="room-detail-item"><strong>가격:</strong> ${room.roomPrice}</div>
                        <div class="room-detail-item"><strong>할인율:</strong> ${room.roomDiscount}%</div>
                        <div class="room-detail-item"><strong>뷰타입:</strong> ${room.roomViewType}</div>
                        <div class="room-detail-item"><strong>상세 설명:</strong> ${room.roomContents}</div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <br>
        <div class="info-card">
            <div class="form-group">
                <label class="form-label">편의시설</label>
                <span>${dto.amenitiesName}</span>
            </div>
        </div>

        <div class="info-card">
            <label class="form-label">숙소 이미지</label>
            <c:if test="${not empty dto.filenames}">
                <c:forEach items="${dto.filenames}" var="filenames">
                    <img src="/accommodation/views/${filenames}" alt="${dto.acmName} 이미지" class="modal-img" style="width:200px; height:auto; cursor: pointer;" />
                </c:forEach>
            </c:if>
        </div>

        <div class="btn-container">
            <a href="acmList" class="btn btn-list">목록</a>
<%--            <button type="submit" class="btn btn-submit">수정</button>--%>
<%--                a href="/accommodation/accommodationUpdate?acmNo=${dto.acmNo}" class="btn btn-submit">수정(등록)</buttona>--%>
            <a href="/accommodation/acmModify?acmNo=${dto.acmNo}" class="btn btn-submit">수정(등록)</a>

            <a href="/accommodation/accommodationDelete?acmNo=${dto.acmNo}" class="btn btn-cancel">삭제</a>
        </div>
    </form>
</div>

<!-- 모달 구조 -->
<div id="imageModal">
    <img id="modal-img" src="" alt="확대된 이미지" />
</div>

<jsp:include page="../comm/footer.jsp"/>
</body>
</html>
