<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <%-- bootstrap datepicker 추가 : 현재 달과 다음 달을 보여준다 --%>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>


    <title>${dto.acmName}</title>

    <!-- main.CSS 파일 연결 -->

    <link rel="stylesheet" type="text/css" href="/css/main.css">
    <link rel="stylesheet" type="text/css" href="/css/memberAcmDetail.css">

    <%-- 체크인 날짜 / 체크아웃 날짜 입력을 위한 달력 컴포넌트 생성을 위한 js 코드 (달력 2개) --%>
    <%--    <script>--%>
    <%--        $(document).ready(function () {--%>
    <%--            $('#checkin').on('change', function () {--%>
    <%--                const checkinDate = new Date($(this).val());--%>
    <%--                checkinDate.setDate(checkinDate.getDate() + 1);--%>
    <%--                $('#checkout').attr('min', checkinDate.toISOString().split('T')[0]);--%>
    <%--            });--%>
    <%--        });--%>
    <%--    </script>--%>

    <script>
        $(document).ready(function () {
            $('.datepicker').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                startDate: new Date(),
                todayHighlight: true,
                // 현재 달과 다음 달을 보여주는 옵션
                beforeShowMonth: function (date) {
                    return date.getMonth() <= (new Date().getMonth() + 1) ? date : null;
                }
            });

            $('#checkin').on('changeDate', function () {
                const checkinDate = new Date($(this).val());
                checkinDate.setDate(checkinDate.getDate() + 1);
                $('#checkout').datepicker('setStartDate', checkinDate);
            });
        });
    </script>

</head>


<body>
<jsp:include page="../main/header.jsp"/>

<%--<h3>숙소 상세페이지가 정상적으로 나오고 있습니다.</h3>--%>

<div class="container">
    <h1>${dto.acmName}</h1>

    <%-- -------------------------------- 숙소 이미지 표시 -------------------------------- --%>
    <div class="info-card">
        <%--<label class="form-label">숙소 이미지</label>--%>
        <c:if test="${not empty images}">
            <%-- 캐러셀 추가 --%>
            <div id="carouselImages" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach var="image" items="${images}" varStatus="imgStatus">
                        <div class="carousel-item ${imgStatus.first ? 'active' : ''}">
                            <img src="/accommodation/views/${image.filename}" class="d-block w-100"
                                 alt="${dto.acmName}">
                        </div>
                    </c:forEach>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselImages"
                        data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">이전</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselImages"
                        data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">다음</span>
                </button>
            </div>
        </c:if>
        <c:if test="${empty images}">
            <p>이미지가 없습니다.</p>\
        </c:if>


        <%--            <div class="row">--%>
        <%--                <c:forEach var="image" items="${images}">--%>
        <%--                    <div class="col-4">--%>
        <%--                        <img src="/accommodation/views/${image.filename}" alt="숙소 이미지" class="img-fluid"--%>
        <%--                             style="width:100%; height:auto; cursor: pointer;"/>--%>
        <%--                    </div>--%>
        <%--                </c:forEach>--%>
        <%--            </div>--%>

    </div>

    <%-- 숙소 이미지 끝 --%>

    <%-- 숙소 정보와 예약정보 확인하는 항목이 같은 행에 위치하도록 배치 --%>
    <div class="row">
        <%-- -------------------------------- 숙소 정보 표시 -------------------------------- --%>
        <div class="col-md-8">
            <div>
                <img src="/img/accommodation.png" id="accommodationIcon" alt="accommodationIcon">
                <h2>숙소 정보</h2>
            </div>
            <div class="info-item">
                <img src="/img/address.png" id="addressIcon" alt="addressIcon">
                <p><i class="fas fa-map-marker-alt"></i> ${dto.acmAddress}</p> <%-- 주소 --%>
            </div>
            <div class="info-item">
                <img src="/img/tel.png" id="telIcon" alt="telIcon">
                <p><i class="fas fa-phone"></i> 전화번호 ${dto.acmTel}</p> <%-- 연락처 --%>
            </div>
            <div class="info-item">
                <img src="/img/character.png" id="characterIcon" alt="characterIcon">
                <p><i class="fas fa-star"></i> ${dto.contents}</p> <%-- 설명 --%>
            </div>
            <div class="info-item">
                <img src="/img/checkincheckout.png" id="checkincheckoutIcon" alt="checkincheckoutIcon">
                <p><i class="fas fa-clock"></i> 체크인 ${dto.checkinTime} | 체크아웃 ${dto.checkoutTime}
                </p> <%-- 체크인 & 체크아웃 --%>
            </div>
            <div class="info-item">
                <img src="/img/amenities.png" id="amenitiesIcon" alt="amenitiesIcon">
                <div>
                    <%--                <p><i class="fas fa-concierge-bell"></i> 편의시설 제공 </p>--%>
                    <p id="amenitiesCharacter">${dto.amenitiesName}</p>
                </div>
            </div>
            <div class="info-item">
                <img src="/img/category.png" id="categoryIcon" alt="categoryIcon">
                <p><i class="gas fa-clock"></i> ${category.categoryName}</p>
                <c:if test="${not empty categories}">
                    <ul>
                        <c:forEach var="category" items="${categories}">
                            <p id="categoryCharacter">${category.categoryName}</p>
                            <!-- 카테고리 번호 출력 -->
                        </c:forEach>
                    </ul>
                </c:if>
            </div>
            <div class="info-item">
                <img src="/img/keyword.png" id="keywordIcon" alt="keywordIcon">
                <!-- 키워드 이름 출력 -->
                <c:if test="${not empty keywords}">
                    <ul>
                        <c:forEach var="keyword" items="${keywords}">
                            <p id="keywordCharacter">${keyword.keywordName}</p>
                        </c:forEach>
                    </ul>
                </c:if>
            </div>


            <%--        <div class="info-item">--%>
            <%--            <img src="/img/amenities.png" id="amenitiesIcon" alt="amenitiesIcon">--%>
            <%--            <p><i class="fas fa-concierge-bell"></i> 편의시설 제공 ${dto.amenitiesName}</p> &lt;%&ndash; 편의시설 &ndash;%&gt;--%>
            <%--        </div>--%>

            <%-- 사업자번호는 상세페이지에서 딱히 보여줄 필요가 없으니 주석처리 --%>
            <%--        <div class="info-item">--%>
            <%--            <p><i class="fas fa-briefcase"></i> 사업자번호 ${dto.businessNo}</p>--%>
            <%--        </div>--%>
        </div>


        <c:if test="${empty dto}">
            <p>숙소 정보를 불러오는 데 실패했습니다.</p>
        </c:if>

        <%--    <c:if test="${not empty categories}">--%>
        <%--        <p>카테고리:</p>--%>
        <%--        <ul>--%>
        <%--            <c:forEach var="category" items="${categories}">--%>
        <%--                <li>${category.categoryName}</li>--%>
        <%--                <!-- 카테고리 번호 출력 -->--%>
        <%--            </c:forEach>--%>
        <%--        </ul>--%>
        <%--    </c:if>--%>

        <%--    <c:if test="${not empty keywords}">--%>
        <%--        <p>키워드:</p>--%>
        <%--        <ul>--%>
        <%--            <c:forEach var="keyword" items="${keywords}">--%>
        <%--                <li>${keyword.keywordName}</li>--%>
        <%--                <!-- 키워드 이름 출력 -->--%>
        <%--            </c:forEach>--%>
        <%--        </ul>--%>
        <%--    </c:if>--%>

        <%-- 숙소 정보 불러오기 끝 --%>


        <%-- -------------------------------- 체크인/체크아웃 날짜 선택 -------------------------------- --%>
        <div class="col-md-4 reservation-info">
            <div class="card reservation-info-card">
                <div class="card-body">
                    <h2>예약 정보</h2>
                    <div class="mb-3">
                        <label for="checkin" class="form-label">체크인 날짜:</label>
                        <input type="date" id="checkin" name="checkin" class="form-control datepicker" required>
                    </div>
                    <div class="mb-3">
                        <label for="checkout" class="form-label">체크아웃 날짜:</label>
                        <input type="date" id="checkout" name="checkout" class="form-control datepicker" required>
                    </div>
                </div>
            </div>
        </div>
        <%-- 체크인/체크아웃 날짜 선택 끝 --%>
    </div>
    <%-- 숙소정보 & 예약정보 확인하는 행 정렬 끝 --%>

    <%-- -------------------------------- 객실 정보 표시 -------------------------------- --%>

    <h2>객실 정보</h2>
    <div class="room-cards">
        <c:forEach var="r" items="${room}">
            <div class="room-card">
                <h3>${r.roomName}</h3>
                <p>객실 수: ${r.roomQty}</p>
                <p>가격: ${r.roomPrice}원</p>
                <p>할인: ${r.roomDiscount}%</p>
                <p>최대 인원: ${r.roomCapacity}명</p>
                <p>설명: ${r.roomContents}</p>
<%--                    <a href="reservation/stays?accommodationNo=${dto.acmNo}&roomNo=${r.roomNo}&checkin=${여기에 날짜}2025-03-28&checkout=${여기에 날짜}2025-03-29">예약하기</a>--%>
                <%--<form action="reservation/reservationForm" method="post">
                    <input type="hidden" name="roomNo" value="${r.roomNo}"> &lt;%&ndash; 객실 ID를 숨겨진 입력 필드로 전달하기 &ndash;%&gt;
                    <button type="submit" class="btn btn-primary reserve-button">예약하기</button>
                </form>--%>
            </div>
        </c:forEach>
    </div>

    <%-- 객실 정보 불러오기 끝 --%>


</div>

</body>

<jsp:include page="../main/footer.jsp"/>


</html>
