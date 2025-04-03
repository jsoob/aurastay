<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>AURASTAY</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/main.css">
</head>
<body>

<jsp:include page="main/header.jsp"/>

<div class="main">
    <nav class="nav-list">
        <ul>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/51f5cf64-5821-400c-8033-8a10c7787d69.jpg"
                                alt="">한옥</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/bcd1adc0-5cee-4d7a-85ec-f6730b0f8d0c.jpg"
                                alt="">펜션</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/7630c83f-96a8-4232-9a10-0398661e2e6f.jpg" alt="">게스트하우스</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/251c0635-cc91-4ef7-bb13-1084d5229446.jpg"
                                alt="">호텔</a>
            </li>
            <%--            <li>--%>
            <%--                <a href=""><img src="https://a0.muscache.com/pictures/48b55f09-f51c-4ff5-b2c6-7f6bd4d1e049.jpg"--%>
            <%--                                alt="">추가</a>--%>
            <%--            </li>--%>
            <%--            <li>--%>
            <%--                <a href=""><img src="https://a0.muscache.com/pictures/3fb523a0-b622-4368-8142-b5e03df7549b.jpg"--%>
            <%--                                alt="">추가</a>--%>
            <%--            </li>--%>
            <%--            <li>--%>
            <%--                <a href=""><img src="https://a0.muscache.com/pictures/3b1eb541-46d9-4bef-abc4-c37d77e3c21b.jpg"--%>
            <%--                                alt="">추가</a>--%>
            <%--            </li>--%>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/aaa02c2d-9f0d-4c41-878a-68c12ec6c6bd.jpg"
                                alt="">리조트</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/3271df99-f071-4ecf-9128-eb2d2b1f50f0.jpg"
                                alt="">풀빌라</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/31c1d523-cc46-45b3-957a-da76c30c85f9.jpg"
                                alt="">캠핑장</a>
            </li>
            <li>
                <a href="">
                    <button class="btn filter-btn"><img src="/img/filter.png" alt="filterIcon">필터</button>
                </a>
            </li>
        </ul>
    </nav>

    <div class="main_body_container container">
        <%-- row-cols-md-n -> 1줄에 몇개씩 나올거냐 --%>
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-6 g-3">

            <%-- 로그인한 사용자 javascript에서 사용하기 위해 hidden으로 넣음 --%>
            <input type="hidden" id="memberNo" value="${dto.memberNo}">
        </div>
        <%-- 앨범 끝 --%>
    </div>
    <%-- 더보기 버튼 --%>
    <div class="loadMore">
        <button id="loadMoreBtn" class="btn btn-dark">더 보기</button>
    </div>
</div>
<jsp:include page="main/footer.jsp"/>

<script>
    let wishlist = [];
    let reviewMap = {}; // accommodationNo 기준으로 리뷰를 저장할 객체

    $(document).ready(function () {
        // 현재페이지
        let currentPage = ${currentPage};
        let totalPages = ${totalPages};


        <c:forEach var="wish" items="${wish}">
        wishlist.push(${wish.accommodationNo});
        </c:forEach>

        <c:forEach var="review" items="${reviewList}">
        reviewMap["${review.accommodationNo}"] = {
            cnt: "${review.cnt}",
            rating: "${review.reviewRating}"
        };
        </c:forEach>

        loadAcmList(currentPage);

        // 더보기 버튼
        $("#loadMoreBtn").click(function () {
            // 전체 페이지수와 비교
            if (currentPage < totalPages) {
                currentPage++; // 페이지 증가
                loadAcmList(currentPage);
            }
            // 마지막 페이지라면
            if (currentPage >= totalPages) {
                $("#loadMoreBtn").hide();
            }
        })
    })

    // 숙소리스트 가져오기
    function loadAcmList(currentPage) {

        $.ajax({
            url: "/loadAccommodationList",
            type: "GET",
            dataType: "json",
            data: {page: currentPage, size: 12},
            success: function (response) {
                console.log(response);
                Object.keys(response)
                    .sort((a,b) => b-a) // 내림차순 정렬
                    .forEach(accommodationNo => {
                        let accommodations = response[accommodationNo];

                        let reviewRating = reviewMap[accommodationNo] ? reviewMap[accommodationNo].rating : 0;
                        let reviewCount = reviewMap[accommodationNo] ? reviewMap[accommodationNo].cnt : 0;


                        let html = '<div class="col">' +
                            '<div class="card" data-accommodation-no="' + accommodationNo + '">' +
                            '<div id="carousel_' + accommodationNo + '" class="carousel slide">' +
                            '<div class="carousel-indicators carousel-index-btn">';

                        accommodations.forEach((accommodation, index) => {
                            html += '<button type="button" data-bs-target="#carousel_' + accommodationNo + '"' +
                                'data-bs-slide-to="' + index + '"' +
                                'aria-label="Slide' + (index + 1) + '"' +
                                'class="' + (index == 0 ? 'active' : '') + '"' +
                                'aria-current="' + (index == 0 ? 'true' : 'false') + '"></button>';
                        });

                        html += '</div><div class="carousel-inner">';

                        accommodations.forEach((accommodation, index) => {
                            html += '<div class="carousel-item ' + (index == 0 ? 'active' : '') + '">' +
                                '<a href="accommodation/memberAccommodation/'+accommodationNo+'">' +
                                '<img class="w-100 slide-imgs"' +
                                'src="/accommodation/views/' + accommodation.filename + '"' +
                                'alt="숙소 이미지"></a></div>';
                        });

                        html += '</div>' + '<div class="wish-btn-container">' + '<button type="button" class="wish-btn">' + '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"';

                        html +=
                            'class="wish-btn-svg ' + (wishlist.includes(Number(accommodationNo)) ? 'wish-btn-svg-active' : '') + '"><path d="M16 28c7-4.73 14-10 14-17a6.98 6.98 0 0 0-7-7c-1.8 0-3.58.68-4.95 2.05L16 8.1l-2.05-2.05a6.98 6.98 0 0 0-9.9 0A6.98 6.98 0 0 0 2 11c0 7 7 12.27 14 17z"></path>' + '</svg></button></div>' +

                            '<button class="carousel-control-btn carousel-control-prev" type="button"' +
                            'data-bs-target="#carousel_' + accommodationNo + '" data-bs-slide="prev">' +
                            '<span class="carousel-control-prev-icon" aria-hidden="true"></span>' +
                            '<span class="visually-hidden">이전</span></button>' +
                            '<button class="carousel-control-btn carousel-control-next" type="button"' +
                            'data-bs-target="#carousel_' + accommodationNo + '" data-bs-slide="next">' +
                            '<span class="carousel-control-next-icon" aria-hidden="true"></span>' +
                            '<span class="visually-hidden">다음</span> </button></div>' +
                            '<div class="card-body">' +
                            '<div class="card-text cardTextDiv">' +
                            '<a href="accommodation/memberAccommodation/'+accommodationNo+'" class="text-decoration-none text-dark">' +
                            '<div class="fs-14 fw-bold">' + accommodations[0].accommodationName + '</div>' +
                            '<div class="ps-1 fs-10">'+accommodations[0].accommodationAddress+'</div>'+
                            '</a>' +
                            '<div class="text-end">' +
                            '<div class="review_rating fs-10">' +
                            '<span class="fw-bold">' + (reviewRating == 0 ? '' : '★' + reviewRating) + '</span>' +
                            '<span>' + (reviewCount == 0 ? '' : "(" + reviewCount + ")") + '</span>' +
                            '</div>' +
                            '<div class="acm-price fs-10">' +
                            '<span class="acm-discount">' + accommodations[0].roomDiscount + '%</span>' +
                            '<span class="acm-price-org text-decoration-line-through">' + formatPrice(accommodations[0].roomPrice) + '</span>' +
                            '</div>' +
                            '<div class="fw-bold">' +
                            formatPrice(accommodations[0].discountedPrice) + '원 ~' +
                            '</div></div></div></div></div>' + '</div>';

                        // 새로운 숙소 카드 추가
                        $(".row").append(html);
                    });
            },
            error: function () {
                alert("로드에 실패했습니다.");
            }
        })
    }
    // 가격 콤마 추가
    function formatPrice(price) {
        return price.toLocaleString(); // 1000000 → "1,000,000"
    }
</script>
<script src="/js/main.js"></script>
</body>
</html>