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

    <title>${dto.acmName}</title>

    <!-- main.CSS 파일 연결 -->

    <link rel="stylesheet" type="text/css" href="/css/main.css">
    <link rel="stylesheet" type="text/css" href="/css/memberAcmDetail.css">
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

    <%-- -------------------------------- 숙소 정보 표시 -------------------------------- --%>
    <%--    <c:if test="${not empty dto}">--%>
    <%--        <p>${dto.acmAddress}</p>--%>
    <%--        <p>전화번호: ${dto.acmTel}</p>--%>
    <%--        <p>특징(타이틀제목은 나중에 삭제할 예정): ${dto.contents}</p>--%>
    <%--        <p>체크인 ${dto.checkinTime}</p>--%>
    <%--        <p>체크아웃 ${dto.checkoutTime}</p>--%>
    <%--        <p>사업자번호 ${dto.businessNo}</p>--%>
    <%--        <p>편의시설 ${dto.amenitiesName}</p>--%>
    <%--    </c:if>--%>

    <div class="accommodation-info">
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
            <p><i class="fas fa-clock"></i> 체크인 ${dto.checkinTime} | 체크아웃 ${dto.checkoutTime}</p> <%-- 체크인 & 체크아웃 --%>
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

    <%-- -------------------------------- 객실 정보 표시 -------------------------------- --%>
    <%--    <c:if test="${not empty room}">--%>
    <%--        <h2>객실 정보</h2>--%>
    <%--        <c:forEach var="r" items="${room}">--%>
    <%--            <p>객실명: ${r.roomName}</p>--%>
    <%--            <p>객실 수: ${r.roomQty}</p>--%>
    <%--            <p>객실 가격: ${r.roomPrice}</p>--%>
    <%--            <p>객실 할인: ${r.roomDiscount}</p>--%>
    <%--            <p>객실 설명: ${r.roomContents}</p>--%>
    <%--            <p>최대 수용 인원: ${r.roomCapacity}</p>--%>
    <%--            <hr>--%>
    <%--        </c:forEach>--%>
    <%--    </c:if>--%>

    <h2>객실 정보</h2>
    <table class="room-table">
        <thead>
        <tr>
            <th>객실명</th>
            <th>객실 수</th>
            <th>가격</th>
            <th>할인</th>
            <th>최대 인원</th>
            <th>설명</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="r" items="${room}">
            <tr>
                <td>${r.roomName}</td>
                <td>${r.roomQty}</td>
                <td>${r.roomPrice}원</td>
                <td>${r.roomDiscount}%</td>
                <td>${r.roomCapacity}명</td>
                <td>${r.roomContents}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>


    <c:if test="${empty room}">
        <p>객실 정보가 없습니다.</p>
    </c:if>
    <%-- 객실 정보 불러오기 끝 --%>


</div>

</body>

<jsp:include page="../main/footer.jsp"/>


</html>
