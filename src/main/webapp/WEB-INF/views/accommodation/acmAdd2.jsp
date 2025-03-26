<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>숙소 등록</title>--%>
<%--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>--%>

<%--    <!-- accAdd.CSS 파일 연결 -->--%>
<%--    <link rel="stylesheet" type="text/css" href="../css/acm.css">--%>

<%--    <script>--%>
<%--        $(document).ready(function () {--%>
<%--            // 모달 열기--%>
<%--            $("#showModal").click(function () {--%>
<%--                $("#roomModal").fadeIn();--%>
<%--            });--%>

<%--            // 모달 닫기--%>
<%--            $("#closeModal, .close").click(function () {--%>
<%--                $("#roomModal").fadeOut();--%>
<%--            });--%>

<%--            // 모달 바깥 영역 클릭 시 닫기--%>
<%--            $(window).click(function (event) {--%>
<%--                if ($(event.target).is("#roomModal")) {--%>
<%--                    $("#roomModal").fadeOut();--%>
<%--                }--%>
<%--            });--%>
<%--        });--%>

<%--        // 객실 정보를 추가하는 함수--%>
<%--        function addRoomInfo() {--%>
<%--            let roomName = $("input[name='roomName[]']").val();--%>
<%--            let roomQty = $("input[name='roomQty[]']").val();--%>
<%--            let roomCapacity = $("input[name='roomCapacity[]']").val();--%>
<%--            let roomPrice = $("input[name='roomPrice']").val();--%>
<%--            let roomDiscount = $("input[name='roomDiscount']").val();--%>
<%--            let roomContents = $("textarea[name='roomContents']").val();--%>
<%--            let roomViewType = $("select[name='roomViewType']").val();--%>

<%--            // 객실 정보를 추가하는 로직 (서버에 전송하거나 배열에 추가하는 방식 구현 필요)--%>
<%--            console.log("객실 정보 추가:", { roomName, roomQty, roomCapacity, roomPrice, roomDiscount, roomContents, roomViewType });--%>

<%--            // 모달 닫기--%>
<%--            $("#roomModal").fadeOut();--%>
<%--        }--%>
<%--    </script>--%>

<%--</head>--%>

<%--<jsp:include page="../comm/header.jsp"/>--%>
<%--<jsp:include page="../comm/sidebar.jsp"/>--%>

<%--<body>--%>
<%--<div class="main-content">--%>
<%--    <h2>숙소 등록</h2>--%>
<%--    <form action="/accommodation/acmAdd" method="post" enctype="multipart/form-data">--%>
<%--        <!-- 숙소 정보 입력 -->--%>
<%--        <div class="form-group">--%>
<%--            <label>숙소명</label>--%>
<%--            <input type="text" name="acmName" placeholder="숙소명을 입력하세요" required>--%>
<%--        </div>--%>
<%--        <div class="form-group">--%>
<%--            <label>주소</label>--%>
<%--            <input type="text" name="acmAddress" placeholder="주소를 입력하세요" required>--%>
<%--        </div>--%>
<%--        <div class="form-group">--%>
<%--            <label>연락처</label>--%>
<%--            <input type="tel" name="acmTel" size=10 maxlength=11 placeholder="연락처를 입력하세요" required>--%>
<%--        </div>--%>
<%--        <div class="check-group">--%>
<%--            <div class="check-item">--%>
<%--                <label>체크인</label>--%>
<%--                <input type="time" name="checkinTime" required>--%>
<%--            </div>--%>
<%--            <div class="check-item">--%>
<%--                <label>체크아웃</label>--%>
<%--                <input type="time" name="checkoutTime" required>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <br>--%>
<%--        <div class="form-group">--%>
<%--            <label>내용</label>--%>
<%--            <textarea name="contents" placeholder="숙소에 대한 정보를 입력하세요" rows="4" required></textarea>--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label>Category</label>--%>
<%--            <div class="checkbox-group">--%>
<%--                <c:forEach var="category" items="${categories}">--%>
<%--                    <label>--%>
<%--                        <input type="radio" name="categoryNo" value="${category.categoryNo}">${category.categoryName}--%>
<%--                    </label>--%>
<%--                </c:forEach>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="form-group">--%>
<%--            <label>편의시설</label>--%>
<%--            <div class="checkbox-group">--%>
<%--                <c:forEach var="amenity" items="${amenities}">--%>
<%--                    <label>--%>
<%--                        <input type="checkbox" name="amenities" value="${amenity.amenitiesNo}"/> ${amenity.amenitiesName}--%>
<%--                    </label>--%>
<%--                </c:forEach>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <br>--%>
<%--        <label>객실 정보 ('객실정보 추가' 버튼을 클릭해주세요!)</label>--%>
<%--        <button id="showModal" type="button" class="btn btn-add-room">객실 정보 추가</button>--%>
<%--        <br><br>--%>

<%--        <div class="btn-container">--%>
<%--            <button type="submit" class="btn btn-submit">등록</button>--%>
<%--            <button type="reset" class="btn btn-cancel">취소</button>--%>
<%--        </div>--%>
<%--    </form>--%>
<%--</div>--%>

<%--<jsp:include page="../comm/footer.jsp"/>--%>
<%--</body>--%>

<%--<jsp:include page="roomModifyModal.jsp"/>--%>
<%--</html>--%>
