<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>숙소 목록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 	crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        .radius_12 {
            border-radius: 12px;
        }

        .fs-10 {
            font-size: 10pt;
        }

        .fs-14 {
            font-size: 14pt;
        }

        /* 슬라이드 이미지 */
        .slide-imgs {
            /*width: 400px;
            height: 400px;*/
        }
        /* 이전/다음 버튼 위치 조정 */
        .carousel-control-btn {
            top: 40%;
            height: 50px;
        }

        /* 할인율 & 원가 css */
        .review_rating, .acm-price {

        }

        /* 12345 버튼 css */
        /*.carousel-index-btn button {*/
        .carousel-indicators.carousel-index-btn > button {
            width: 15px;
            height: 5px;
        }

        /* 위시리스트 버튼 위치 */
        .wish-btn-container {
            position: absolute;
            top: 5%;
            right: 5%;
        }
        /* 버튼 지우기 */
        .wish-btn {
            background: none;
            border: none;
        }

        /* 하트 버튼 */
        /* 하트 hover시 wish-btn-svg 변경 */
        .wish-btn:hover .wish-btn-svg {
            fill: rgb(253 253 253 / 0%);
        }
        /* 하트 */
        .wish-btn-svg {
            display: block;
            /* 하트 안 색깔 */
            fill: rgba(0, 0, 0, 0.5);
            /* 선 색상 */
            stroke: white;
            /* 선 두께 */
            stroke-width: 3;
            height: 24px;
            width: 24px;
            overflow: visible;
        }
        /* 위시 클릭 되어 있으면 색깔 핑크로 채우기 */
        .wish-btn-svg-active {
            fill: #ff385c;
        }
    </style>

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
<h3><a href="/">목록가기</a></h3>
<%-- 앨범 --%>

<div class="container">

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
</div>

<%-- 앨범 끝 --%>
</body>
</html>