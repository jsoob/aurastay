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
    <%-- 모달창 css 파일 --%>
    <link rel="stylesheet" type="text/css" href="../css/acm.css">

    <script>

        $(document).ready(function () {
            // 객실 정보 수정을 위한 모달창과 관련된 함수를 실행하는 곳
            // 전역함수로 설정
            window.openRoomModifyModal = function (roomNo){
                $.ajax({
                    url: '/room/room/' + roomNo, // 객실 정보 가져오기
                    method: 'GET',
                    success: function (data) {
                        // 모달의 입력 필드에 값을 채워넣기
                        $("input[name='roomNo']").val(data.roomNo);
                        $("input[name='acmNo']").val(data.acmNo);
                        $("input[name='roomName']").val(data.roomName);
                        $("input[name='roomQty']").val(data.roomQty);
                        $("input[name='roomCapacity']").val(data.roomCapacity);
                        $("input[name='roomPrice']").val(data.roomPrice);
                        $("input[name='roomDiscount']").val(data.roomDiscount);
                        $("textarea[name='roomContents']").val(data.roomContents);
                        $("select[name='roomViewType']").val(data.roomViewType);

                        // 모달 열기
                        $("#roomModifyModal").fadeIn();
                    },
                    error: function (error) {
                        console.error('객실 정보를 불러오는 데 실패했습니다.', error);
                    }
                });
            }

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

            // 숙소 삭제 함수
            function deleteAccommodation(acmNo) {
                if (confirm("정말로 이 숙소를 삭제하시겠습니까?")) {
                    $.ajax({
                        url: '/accommodation/' + acmNo,
                        type: 'DELETE', // DELETE 요청
                        success: function (response) {
                            alert(response); // 성공 메시지
                            location.href = 'acmList'; // 목록 페이지로 리다이렉트
                        },
                        error: function (xhr) {
                            alert(xhr.responseText); // 오류 메시지
                        }
                    });
                }
            }

            // 모달을 닫는 기능
            // 모달 닫기
            $("#closeModal, #modalClose").click(function () {
                $("#roomModifyModal").fadeOut(); // 모달 닫기
            });

            // 모달 바깥 클릭 시 닫기
            $(window).click(function (event) {
                if ($(event.target).is("#roomModifyModal")) {
                    $("#roomModifyModal").fadeOut();
                }
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

                        <%--                <a href="/accommodation/roomModifyModal?acmNo=${dto.acmNo}" class="btn btn-submit">수정(등록)</a>--%>
                    <jsp:include page="roomModifyModal.jsp"/>
                    <button id="roomModifyModal" type="button" class="btn btn-submit"
                            onclick="openRoomModifyModal(${room.roomNo})">수정
                    </button>
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
                    <img src="/accommodation/views/${filenames}" alt="${dto.acmName} 이미지" class="modal-img"
                         style="width:200px; height:auto; cursor: pointer;"/>
                </c:forEach>
            </c:if>
        </div>

        <div class="btn-container">
            <a href="acmList" class="btn btn-list">목록</a>
            <%--            <button type="submit" class="btn btn-submit">수정</button>--%>
            <%--                a href="/accommodation/accommodationUpdate?acmNo=${dto.acmNo}" class="btn btn-submit">수정(등록)</buttona>--%>
            <a href="/accommodation/acmModify?acmNo=${dto.acmNo}" class="btn btn-submit">수정(등록)</a>
            <button type="button" class="btn btn-cancel" onclick="deleteAccommodation(${dto.acmNo})">삭제</button>
            <%--            <a href="/accommodation/accommodationDelete?acmNo=${dto.acmNo}" class="btn btn-cancel">삭제</a>--%>
        </div>
    </form>
</div>

<!-- 모달 구조 -->
<div id="imageModal">
    <img id="modal-img" src="" alt="확대된 이미지"/>
</div>

<jsp:include page="../comm/footer.jsp"/>
</body>
</html>
