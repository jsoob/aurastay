<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>위시리스트</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/wishList.css">

    <script defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD4t4CjqXYx4Ch9EZdO3BSmryXcYs4EiIE&callback=initMap&libraries=marker"></script>
    <script>

        // 숙소 데이터를 JavaScript 배열로 변환
        let accommodations = [
            <c:forEach var="entry" items="${groupedWishes}" varStatus="loop">
            {
                name: "${entry.value[0].get('accommodationName')}",
                address: "${entry.value[0].get('accommodationFullAddress')}"
            }<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];

        console.log(accommodations);

        function initMap() {
            //지도 기본 설정
            const center = {lat: 36.3946, lng: 127.8632737};
            const map = new google.maps.Map(document.getElementById("map"), {
                zoom: 7,
                center: center,
                mapId: '1e925f5dd27e6bc3'
            })

            // 주소 변환 객체
            const geocoder = new google.maps.Geocoder();

            accommodations.forEach((accommodation => {
                geocoder.geocode({'address' : accommodation.address}, function(results, status){
                    if(status === 'OK') {
                        let location = results[0].geometry.location; // 변환된 위도/경도 가져오기

                        // 지도에 마커 추가
                         new google.maps.marker.AdvancedMarkerElement({
                            map : map,
                            position: location,
                            title : accommodation.name
                        });

                    } else {
                        console.error("주소변환 실패");
                    }
                })
            }))
        }
    </script>
</head>
<body>
<jsp:include page="../main/basic-header.jsp"/>

<div class="wishlist-container main">
    <h3 class="text-center mb-4 mt-4">위시리스트</h3>

    <div class="row">
        <div class="col-md-8">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
                <%-- 숙소 목록 ex : dto : list / status -> index 값 구하기 위해 명시함. --%>
                <c:forEach var="entry" items="${groupedWishes}">
                    <c:set var="accommodationNo" value="${entry.key}"/>
                    <c:set var="wishes" value="${entry.value}"/>
                    <div class="col">
                        <div class="card wishlist-card"
                             data-accommodation-no="${wishes[0].get('accommodationNo')}">

                            <!-- 캐러셀 -->
                            <div id="carousel_${accommodationNo}" class="carousel slide">
                                <div class="carousel-indicators">

                                    <c:forEach var="wish" items="${wishes}" varStatus="imgStatus">

                                        <button type="button" data-bs-target="#carousel_${accommodationNo}"
                                                data-bs-slide-to="${imgStatus.index}"
                                                class="${imgStatus.first ? 'active' : ''}"
                                                aria-current="${imgStatus.first ? 'true' : 'false'}"
                                                aria-label="Slide ${imgStatus.index+1}"></button>
                                    </c:forEach>
                                </div>

                                <div class="carousel-inner">
                                    <c:forEach var="wish" items="${wishes}" varStatus="imgStatus">
                                        <div class="carousel-item ${imgStatus.first ? 'active' : ''}">
                                            <a href="acm/list">
                                                <img class="d-block w-100" src="/accommodation/views/${wish.filename}"
                                                     alt="숙소 이미지">
                                            </a>
                                        </div>
                                    </c:forEach>
                                </div>


                                    <%-- 로그인한 사용자 javascript에서 사용하기 위해 hidden으로 넣음 --%>
                                <input type="hidden" id="memberNo" value="${dto.memberNo}">
                                    <%-- 위시리스트 끝 --%>


                                <button class="carousel-control-btn carousel-control-prev" type="button"
                                        data-bs-target="#carousel_${accommodationNo}" data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">이전</span>
                                </button>
                                <button class="carousel-control-btn carousel-control-next" type="button"
                                        data-bs-target="#carousel_${accommodationNo}" data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">다음</span>
                                </button>
                                    <%-- 이전 / 다음 버튼 끝 --%>

                            </div>
                                <%-- 캐러셀 끝 --%>

                            <div class="card-body ">
                                <div class="card-text cardTextDiv">
                                    <a href="acm/list" class="text-decoration-none text-dark">
                                        <div class="fs-14 fw-bold">${wishes[0].get("accommodationName")}</div>
                                        <div class="ps-1 fs-10">${wishes[0].get("accommodationAddress")}</div>
                                    </a>


                                <div class="text-end">
                                    <div class="review_rating fs-10">
                                        <span class="fw-bold">
                                                    <c:forEach var="review" items="${reviewList}">
                                                        <c:if test="${review.get('accommodationNo') eq wishes[0].get('accommodationNo')}">
                                                            <c:if test="${not empty review.get('reviewRating') && review.get('reviewRating') != 0 && review.get('reviewRating') != ''}">
                                                                ★ ${review.get('reviewRating')}
                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>

                                            </span>
                                        <span>
                                            <c:forEach var="review" items="${reviewList}">
                                                <c:if test="${review.get('accommodationNo') eq wishes[0].get('accommodationNo')}">
                                                    <c:if test="${review.get('cnt') > 0}">
                                                    (${review.get('cnt')})
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>
                                        </span>
                                    </div>

                                    <div class="acm-price fs-10">
                                        <span class="acm-discount">${wishes[0].get("roomDiscount")}%</span>
                                        <span class="acm-price-org text-decoration-line-through"><fmt:formatNumber value="${wishes[0].get('roomPrice')}" type="number" pattern="#,###" /></span>
                                    </div>

                                    <div class="fw-bold">
                                        <fmt:formatNumber value="${wishes[0].get('discountedPrice')}" type="number" pattern="#,###" />원 ~
                                    </div>
                                </div>
                            </div>
                                </div>

                            <div class="wish-btn-container text-center mt-2">
                                <button type="button" class="wish-btn">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
                                         class="wish-btn-svg wish-btn-svg-active ">
                                        <path d="M16 28c7-4.73 14-10 14-17a6.98 6.98 0 0 0-7-7c-1.8 0-3.58.68-4.95 2.05L16 8.1l-2.05-2.05a6.98 6.98 0 0 0-9.9 0A6.98 6.98 0 0 0 2 11c0 7 7 12.27 14 17z"></path>
                                    </svg>
                                </button>
                            </div>

                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="col-md-4">
            <div id="map" style="height: 800px"></div>
        </div>
    </div>
</div>

<jsp:include page="../main/footer.jsp"/>
<script src="/js/wishList.js"></script>
</body>
</html>