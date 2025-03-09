<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>index</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" href="/css/main.css">


    <%-- 숙소 리스트 js--%>
    <script>
        $(function(){
            $(".wish-btn").click(function() {
                console.log("-.-");
                alert("즐겨찾기 완료되었습니다.");
            });
        });

    </script>
</head>
<body>

<jsp:include page="main/header.jsp"/>

<nav class="nav-list">
    <ul>
        <li>
            <a href=""><img src="https://a0.muscache.com/pictures/51f5cf64-5821-400c-8033-8a10c7787d69.jpg" alt="">한옥</a>
        </li>
        <li>
            <a href=""><img src="https://a0.muscache.com/pictures/bcd1adc0-5cee-4d7a-85ec-f6730b0f8d0c.jpg" alt="">펜션</a>
        </li>
        <li>
            <a href=""><img src="https://a0.muscache.com/pictures/7630c83f-96a8-4232-9a10-0398661e2e6f.jpg" alt="">게스트하우스</a>
        </li>
        <li>
            <a href=""><img src="https://a0.muscache.com/pictures/251c0635-cc91-4ef7-bb13-1084d5229446.jpg" alt="">호텔</a>
        </li>
        <li>
            <a href=""><img src="https://a0.muscache.com/pictures/48b55f09-f51c-4ff5-b2c6-7f6bd4d1e049.jpg" alt="">추가</a>
        </li>
        <li>
            <a href=""><img src="https://a0.muscache.com/pictures/3fb523a0-b622-4368-8142-b5e03df7549b.jpg" alt="">추가</a>
        </li>
        <li>
            <a href=""><img src="https://a0.muscache.com/pictures/3b1eb541-46d9-4bef-abc4-c37d77e3c21b.jpg" alt="">추가</a>
        </li>
        <li>
            <a href=""><img src="https://a0.muscache.com/pictures/aaa02c2d-9f0d-4c41-878a-68c12ec6c6bd.jpg" alt="">추가</a>
        </li>
        <li>
            <a href=""><img src="https://a0.muscache.com/pictures/3271df99-f071-4ecf-9128-eb2d2b1f50f0.jpg" alt="">추가</a>
        </li>
        <li>
            <a href=""><img src="https://a0.muscache.com/pictures/31c1d523-cc46-45b3-957a-da76c30c85f9.jpg" alt="">추가</a>
        </li>
        <li>
            <a href=""><button class="btn filter-btn"><img src="/img/filter.png" alt="filterIcon">필터</button></a>
        </li>
    </ul>
</nav>

<div class="main_body_container">

        <%-- row-cols-md-n -> 1줄에 몇개씩 나올거냐 --%>
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
            <%-- 숙소 목록 ex : dto : list / status -> index 값 구하기 위해 명시함. --%>
            <c:forEach var="i" begin="1" end="5" varStatus="status">
                <div class="col">
                    <div class="card shadow-sm">
                            <%-- 캐러셀 --%>
                        <div id="carousel_${status.index}" class="carousel slide">
                            <div class="carousel-indicators carousel-index-btn">
                                    <%-- 숙소 이미지 목록 / imgStatus -> index 값 구하기 위해 명시함. --%>
                                <c:forEach var="j" begin="0" end="4" varStatus="imgStatus">
                                    <c:choose>
                                        <%-- 첫번째 이미지는 class="active" aria-current="true" 박아줌 --%>
                                        <c:when test="${imgStatus.index eq 1}">
                                            <button type="button" data-bs-target="#carousel_${status.index}"
                                                    data-bs-slide-to="${imgStatus.index}" aria-label="Slide ${imgStatus.index+1}" class="active" aria-current="true"></button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" data-bs-target="#carousel_${status.index}"
                                                    data-bs-slide-to="${imgStatus.index}" aria-label="Slide ${imgStatus.index+1}" class=""></button>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>


                            <div class="carousel-inner">
                                <!-- 이미지도 위처럼 c:foreach + choose/when-otherwise 를 사용해서 1번째 꺼랑 다른것들 구분 -->
                                <div class="carousel-item active"> <!-- 첫번째 이미지는 active 가 붙는다 -->
                                    <a href="acm/list">
                                        <img class="w-100 slide-imgs" src="https://a0.muscache.com/im/pictures/miso/Hosting-49361434/original/2a7e8504-fa32-45b9-ae14-10ad5b9b5258.jpeg?im_w=720&im_format=avif">
                                    </a>
                                </div>
                                <div class="carousel-item">
                                    <a href="acm/list">
                                        <img class="w-100 slide-imgs" src="https://a0.muscache.com/im/pictures/miso/Hosting-49361434/original/962579ac-89d5-4cab-9b63-a740878795d0.jpeg?im_w=720&im_format=avif">
                                    </a>
                                </div>
                                <div class="carousel-item">
                                    <a href="acm/list">
                                        <img class="w-100 slide-imgs" src="https://a0.muscache.com/im/pictures/miso/Hosting-49361434/original/6cae9480-5aa0-48d4-9c1e-930c3a94ee70.jpeg?im_w=720&im_format=avif">
                                    </a>
                                </div>
                                <div class="carousel-item">
                                    <a href="acm/list">
                                        <img class="w-100 slide-imgs" src="https://a0.muscache.com/im/pictures/miso/Hosting-49361434/original/09585a65-d840-45cd-b24e-f735ddfe962a.jpeg?im_w=720&im_format=avif">
                                    </a>
                                </div>
                                <div class="carousel-item">
                                    <a href="acm/list">
                                        <img class="w-100 slide-imgs" src="https://a0.muscache.com/im/pictures/miso/Hosting-49361434/original/8fcc3846-48e6-4443-aebc-df4ced29ee35.jpeg?im_w=720&im_format=avif">
                                    </a>
                                </div>
                            </div>

                                <%-- 위시리스트 --%>
                            <div class="wish-btn-container">
                                <button type="button" class="wish-btn">
                                    <c:choose>
                                    <c:when test="${i % 2 == 0}">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" class="wish-btn-svg wish-btn-svg-active">
                                        </c:when>
                                        <c:otherwise>
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" class="wish-btn-svg">
                                            </c:otherwise>
                                            </c:choose>

                                            <path d="M16 28c7-4.73 14-10 14-17a6.98 6.98 0 0 0-7-7c-1.8 0-3.58.68-4.95 2.05L16 8.1l-2.05-2.05a6.98 6.98 0 0 0-9.9 0A6.98 6.98 0 0 0 2 11c0 7 7 12.27 14 17z"></path>
                                        </svg>
                                </button>
                            </div>
                                <%-- 위시리스트 끝 --%>

                                <%-- 이전 / 다음 버튼 --%>
                            <button class="carousel-control-btn carousel-control-prev" type="button" data-bs-target="#carousel_${status.index}" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">이전</span>
                            </button>
                            <button class="carousel-control-btn carousel-control-next" type="button" data-bs-target="#carousel_${status.index}" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">다음</span>
                            </button>
                                <%-- 이전 / 다음 버튼 끝 --%>

                        </div>
                            <%-- 캐러셀 끝 --%>

                        <div class="card-body">
                            <div class="card-text">
                                <a href="acm/list" class="text-decoration-none text-dark">
                                    <div class="fs-14 fw-bold">Mystagoge Retreat</div>
                                    <div class="ps-1 fs-10">Vothonas, Thera, 그리스</div>
                                </a>

                                    <%--<hr class="my-2">--%>

                                <div class="text-end">
                                    <div class="review_rating fs-10">
                                        <span class="fw-bold">★ 4.7</span>
                                        <span>(1653)</span>
                                    </div>

                                    <div class="acm-price fs-10">
                                        <span class="acm-discount">10%</span>
                                        <span class="acm-price-org text-decoration-line-through">400,000</span>
                                    </div>

                                    <div class="fw-bold">
                                        360,000원 ~
                                    </div>
                                </div>

                            </div>

                            <!-- 숙소 제공 사항 -->
                                <%--
                                <div class="">
                                    <hr class="my-2">
                                    <p class="fs-10">숙소 제공 사항</p>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                                        <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                                    </div>
                                    <small class="text-body-secondary">9 mins</small>
                                </div>
                                --%>

                                <%--
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                                        <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                                    </div>
                                    <small class="text-body-secondary">9 mins</small>
                                </div>
                                --%>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <%-- 앨범 끝 --%>


</div>




<jsp:include page="main/footer.jsp"/>

</body>
</html>

<%--<!-- 네비게이션 바 -->--%>
<%--<nav class="navbar navbar-expand-lg bg-light shadow-sm">--%>
<%--    <div class="container">--%>
<%--        <a class="navbar-brand fw-bold text-danger" href="#">Airbnb</a>--%>

<%--        <!-- 검색창 -->--%>
<%--        <form class="d-flex mx-auto">--%>
<%--            <input class="form-control me-2" type="search" placeholder="어디로 여행가세요?" aria-label="Search">--%>
<%--            <button class="btn btn-danger" type="submit">검색</button>--%>
<%--        </form>--%>

<%--        <!-- 프로필 메뉴 -->--%>
<%--        <div class="dropdown">--%>
<%--            <button class="btn btn-light border dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">--%>
<%--                <img src="profile.png" alt="Profile" width="30" height="30" class="rounded-circle">--%>
<%--            </button>--%>
<%--            <ul class="dropdown-menu dropdown-menu-end">--%>
<%--                <li><a class="dropdown-item" href="#">로그인</a></li>--%>
<%--                <li><a class="dropdown-item" href="#">회원가입</a></li>--%>
<%--            </ul>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</nav>--%>

