<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <head>
        <!-- jQuery 추가 -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <!-- bootstrap-datepicker 추가 -->
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>

    </head>


    <title>${dto.acmName}</title>

    <!-- main.CSS 파일 연결 -->

    <link rel="stylesheet" type="text/css" href="/css/main.css">
    <link rel="stylesheet" type="text/css" href="/css/memberAcmDetail.css">

    <%-- 체크인 날짜 / 체크아웃 날짜 입력을 위한 달력 컴포넌트 생성을 위한 js 코드 (달력 2개) --%>
    <script>
        $(document).ready(function () {
            // 체크인(시작 날짜) 설정
            $('#startDate').datepicker({
                format: "yyyy-mm-dd",   // 날짜 형식 (연-월-일)
                autoclose: true,        // 날짜 선택 후 자동으로 닫힘
                todayHighlight: true,   // 오늘 날짜 강조
                clearBtn: true,         // "Clear" 버튼 추가 (선택 사항)
                startDate: new Date(),  // 오늘 날짜 이전은 선택 불가능
                templates: {
                    leftArrow: '«',
                    rightArrow: '»'
                },
                maxViewMode: 1,         // 최대 월 단위로 보기 가능
                multidate: false,       // 다중 선택 비활성화
            }).on('changeDate', function (e) {
                // 체크인 날짜 선택 후 체크아웃 캘린더 자동 열기
                $('#endDate').datepicker('setStartDate', e.date);
                $('#endDate').datepicker('show');
            });

            // 체크아웃(종료 날짜) 설정
            $('#endDate').datepicker({
                format: "yyyy-mm-dd",
                autoclose: true,
                todayHighlight: true,
                clearBtn: true,
                startDate: new Date(), // 오늘 날짜 이후만 선택 가능
                templates: {
                    leftArrow: '«',
                    rightArrow: '»'
                },
                maxViewMode: 1,
                multidate: false,
            });

            // 2개월 보기 옵션 적용 (현재 월 & 다음 월)
            $('.datepicker').datepicker('update', new Date());
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
        </div>


        <c:if test="${empty dto}">
            <p>숙소 정보를 불러오는 데 실패했습니다.</p>
        </c:if>
        <%-- 숙소 정보 불러오기 끝 --%>


        <%-- -------------------------------- 체크인/체크아웃 날짜 // 인원 수 선택 -------------------------------- --%>
        <div class="col-md-4 reservation-info">
            <div class="card reservation-info-card">
                <div class="card-body">
                    <div class="info-item">
                        <img src="/img/calender.png" id="calenderIcon" alt="calenderIcon">
                        <h2>예약 정보</h2>
                    </div>
                    <div class="info-item">
                        <div class="container mt-3 d-flex justify-content-between">
                            <div class="me-2">
                                <label for="startDate">체크인</label>
                                <input type="text" id="startDate" class="form-control" placeholder="체크인 날짜 선택">
                            </div>
                            <div>
                                <label for="endDate">체크아웃</label>
                                <input type="text" id="endDate" class="form-control" placeholder="체크아웃 날짜 선택">
                            </div>
                        </div>
                    </div>


                    <%-- 인원 수를 선택하는 항목 (드롭다운 형식으로 작성) --%>
                    <div class="guest-dropdown">
                        <button id="guest-btn">인원 선택</button>
                        <div class="guest-options">
                            <label>성인 (13세 이상) <input type="number" id="adults" min="0" max="10" value="1"></label>
                            <label>어린이 (2 ~ 12세) <input type="number" id="children" min="0" max="10" value="0"></label>
                            <label>유아 (2세 미만) <input type="number" id="infants" min="0" max="5" value="0"></label>
                            <label>반려동물 <input type="number" id="pets" min="0" max="3" value="0"></label>
                            <label> (반려동물의 경우, 숙소의 사정에 따라 입실이 거부되는 경우가 있을 수 있습니다. 이 점 참고하시어 해당 숙소에 직접 문의해주시기
                                바랍니다.) </label>
                            <button id="apply-btn">적용</button>
                        </div>
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
                <a href="/reservation/stays?accommodationNo=${dto.acmNo}&roomNo=${r.roomNo}&checkin=2025-05-20&checkout=2025-05-23" class="btn btn-pink">예약하기</a>
                    <%--                <a href="reservation/stays?accommodationNo=${dto.acmNo}&roomNo=${r.roomNo}&checkin="+${"#startDate"}.val()+"&checkout="+$("#endDate").val() +">예약하기</a>--%>
<%--                <a href="reservation/stays?accommodationNo=${dto.acmNo}&roomNo=${r.roomNo}&checkin=" + $('#startDate').val() + "&checkout=" + $('#endDate').val() + " class="btn btn-pink">예약하기</a>--%>
<%--                <a href="reservation/stays?accommodationNo=${dto.acmNo}&roomNo=${r.roomNo}&checkin=${$('#startDate').val()}&checkout=${$('#endDate').val()}" class="btn btn-pink">예약하기</a>--%>

            <%--<form action="reservation/reservationForm" method="post">
                                <input type="hidden" name="roomNo" value="${r.roomNo}"> &lt;%&ndash; 객실 ID를 숨겨진 입력 필드로 전달하기 &ndash;%&gt;
                                <button type="submit" class="btn btn-primary reserve-button">예약하기</button>
                            </form>--%>
            </div>
        </c:forEach>
    </div>

    <%-- 객실 정보 불러오기 끝 --%>


</div>


<script>
    document.getElementById("guest-btn").addEventListener("click", function () {
        let options = document.querySelector(".guest-options");
        options.style.display = options.style.display === "block" ? "none" : "block";
    });

    document.getElementById("apply-btn").addEventListener("click", function () {
        let adults = document.getElementById("adults").value;
        let children = document.getElementById("children").value;
        let infants = document.getElementById("infants").value;
        let pets = document.getElementById("pets").value;

        let guestText = `성인 ` + adults + `명, 어린이 ` + children + `명, 유아 ` + infants + `명`;
        if (pets > 0) {
            guestText += `, 반려동물 ` + pets + `마리`;
        }

        console.log("성인 >>>>>>>>>> " + adults);

        document.getElementById("guest-btn").innerText = guestText;
        document.querySelector(".guest-options").style.display = "none";
    });


</script>


</body>

<jsp:include page="../main/footer.jsp"/>


</html>
