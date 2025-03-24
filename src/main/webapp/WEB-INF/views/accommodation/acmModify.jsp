<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${dto.acmName} 숙소 수정</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/acm.css">

    <script>
        $(document).ready(function () {
            // 모달 열기
            $("#showModal").click(function () {
                var acmNo = ${dto.acmNo}; // 현재 숙소 번호
                $.ajax({
                    url: '/accommodation/rooms/' + acmNo,
                    method: 'GET',
                    success: function (data) {
                        // AJAX로 받아온 객실 정보를 모달 폼에 채워 넣기
                        data.forEach(room => {
                            $('input[name="roomName[]"]').val(room.roomName);
                            $('input[name="roomQty[]"]').val(room.roomQty);
                            $('input[name="roomCapacity[]"]').val(room.roomCapacity);
                            $('input[name="roomPrice[]"]').val(room.roomPrice);
                            $('input[name="roomDiscount[]"]').val(room.roomDiscount);
                            $('textarea[name="roomContents[]"]').val(room.roomContents);
                            $('select[name="roomViewType[]"]').val(room.roomViewType);
                        });
                        $("#roomModal").fadeIn(); // 모달 열기
                    },
                    error: function (error) {
                        console.error('객실 정보를 불러오는 데 실패했습니다.', error);
                    }
                });
            });

            // 모달 닫기 함수
            function closeModal() {
                $("#roomModal").fadeOut();
            }

            // 모달 닫기 버튼 클릭 이벤트
            $("#closeModal, .close").click(closeModal);

            // 모달 바깥 영역 클릭 시 닫기
            $(window).click(function (event) {
                if ($(event.target).is("#roomModal")) {
                    closeModal();
                }
            });

            // 추가 버튼 클릭 이벤트
            $("#btn").click(function () {
                let newFileInput = '<input type="file" name="files" multiple>'; // 새로운 파일 입력 필드
                $(this).before(newFileInput); // 버튼 앞에 추가
            });
        });

        // 객실 정보를 추가하는 함수
        function addRoomInfo() {
            let roomName = $("input[name='roomName[]']").val();
            let roomQty = $("input[name='roomQty[]']").val();
            let roomCapacity = $("input[name='roomCapacity[]']").val();
            let roomPrice = $("input[name='roomPrice']").val();
            let roomDiscount = $("input[name='roomDiscount']").val();
            let roomContents = $("textarea[name='roomContents']").val();
            let roomViewType = $("select[name='roomViewType']").val();

            // 객실 정보를 추가하는 로직 (서버에 전송하거나 배열에 추가하는 방식 구현 필요)
            console.log("객실 정보 추가:", { roomName, roomQty, roomCapacity, roomPrice, roomDiscount, roomContents, roomViewType });

            // 모달 닫기
            $("#roomModal").fadeOut();
        }
    </script>

    <style>
        #btn {
            cursor: pointer; /* 마우스 커서를 포인터로 변경 */
        }
    </style>
</head>

<jsp:include page="../comm/header.jsp"/>
<jsp:include page="../comm/sidebar.jsp"/>

<body>
<div class="main-content">
    <h2>${dto.acmName} 숙소 수정</h2>
    <form action="/accommodation/acmModify" method="post" enctype="multipart/form-data">
        <input type="hidden" name="acmNo" value="${dto.acmNo}"/>

        <div class="form-group">
            <label>숙소명</label>
            <input type="text" name="acmName" placeholder="숙소명을 입력하세요" value="${dto.acmName}" required>
        </div>
        <div class="form-group">
            <label>주소</label>
            <input type="text" name="acmAddress" placeholder="주소를 입력하세요" value="${dto.acmAddress}" required>
        </div>
        <div class="form-group">
            <label>연락처</label>
            <input type="tel" name="acmTel" size="10" maxlength="11" placeholder="연락처를 입력하세요" value="${dto.acmTel}" required>
        </div>
        <div class="check-group">
            <div class="check-item">
                <label class="form-label">체크인</label>
                <input type="time" class="form-control" name="checkinTime" value="${dto.checkinTime}" required>
            </div>
            <div class="check-item">
                <label class="form-label">체크아웃</label>
                <input type="time" class="form-control" name="checkoutTime" value="${dto.checkoutTime}" required>
            </div>
        </div>
        <br>
        <div class="form-group">
            <label>내용</label>
            <textarea name="contents" placeholder="숙소에 대한 정보를 입력하세요" rows="4" required>${dto.contents}</textarea>
        </div>

        <div class="form-group">
            <label>Category</label>
            <div class="checkbox-group">
                <c:forEach var="category" items="${categories}">
                    <label>
                        <input type="radio" name="categoryNo" value="${category.categoryNo}"
                               <c:if test="${category.categoryNo == dto.categoryNo}">checked</c:if>
                        >${category.categoryName}</label>
                </c:forEach>
            </div>
        </div>

        <div class="form-group">
            <label>편의시설</label>
            <div class="checkbox-group">
                <c:forEach var="amenity" items="${amenities}">
                    <label>
                        <input type="checkbox" name="amenities" value="${amenity.amenitiesNo}"
                               <c:if test="${selectedAmenities.contains(amenity.amenitiesNo)}">checked</c:if>
                        /> ${amenity.amenitiesName}
                    </label>
                </c:forEach>
            </div>
        </div>

        <jsp:include page="roomModal.jsp"/>

        <br>
        <label>객실 정보 ('객실정보 추가' 버튼을 클릭해주세요!)</label>
        <button id="showModal" type="button" class="btn btn-add-room">객실 정보 추가</button>
        <br><br>

        <div class="form-group">
            <label>Keyword</label>
            <div class="checkbox-group">
                <c:forEach var="keyword" items="${keywords}">
                    <label>
                        <input type="radio" name="keywordNo" value="${keyword.keywordNo}"
                               <c:if test="${keyword.keywordNo == dto.keywordNo}">checked</c:if>
                        >${keyword.keywordName}
                    </label>
                </c:forEach>
            </div>
        </div>

        <div class="container">
            <div class="pink-box">
                <%--키워드 아래에 첨부파일과 버튼을 배치하기--%>
                <div class="form-group" id="fileInputContainer">
                    <label class="form-label">숙소 이미지 업로드</label>
                    <input type="file" name="files" multiple> <%--여러 개의 파일을 선택할 수 있도록 multiple 추가--%>
                    <input type="button" value="추가" id="btn"> <!-- 추가 버튼 -->
                </div>
            </div>
            <div class="btn-container">
                <button type="submit" class="btn btn-submit">수정</button>
                <button type="reset" class="btn btn-cancel">취소</button>
            </div>
        </div>
    </form>
</div>

</body>

<jsp:include page="../comm/footer.jsp"/>
</html>
