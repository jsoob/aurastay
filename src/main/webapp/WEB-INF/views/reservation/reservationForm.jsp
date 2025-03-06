<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>예약 요청</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 	crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <link rel="stylesheet" href="/css/rsrv/rsrv.css">
    <%--
    <style>
        .rsrv-container .title-container {
            margin: 20px auto;
        }

        .rsrv-container .left-container {
            position: relative !important;
            width: 50% !important;
            margin-left: 0 !important;
            margin-right: 0 !important;
        }

        .rsrv-container .right-container {
            position: relative !important;
            width: 41.6667% !important;
            margin-left: 8.33333% !important;
            margin-right: 0 !important;
        }

        .rsrv-container .acm-img-thumbnail {
            width: 100px;
            height: 100px;
        }

        .radius_12 {
            border-radius: 12px;
        }
    </style>
    --%>
</head>
<body>
<h3><a href="/">목록가기</a></h3>

    <div class="container rsrv-container">
        <div class="container title-container">
            <h1><a class="text-decoration-none text-dark" href="/accomodation"><</a> 예약 요청</h1>
        </div>
        <div class="d-flex p-4 gap-4 py-md-5 align-items-center justify-content-center">
            <div class="left-container">
                d0d
            </div>
            <div class="right-container">
                <ul class="rsv dropdown-menu d-grid gap-1 p-4" data-bs-theme="light">
                    <li class="d-flex gap-2 py-2 px-3 lh-sm text-start">
                        <img class="acm-img-thumbnail radius_12" src="https://a0.muscache.com/im/pictures/0f52b46a-16fe-472f-a04b-eec52680f162.jpg?aki_policy=large" alt="">
                        <div>
                            <strong class="d-block">E°SO 이소하우스 60평 독채</strong>
                            <p>펜션</p>
                            <p>
                                <div class="float-start me-1">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="mb-1 bi bi-star-fill" viewBox="0 0 16 16">
                                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                    </svg> 4.93(114)
                                </div>
                                <div><span>•</span>슈퍼 호스트</div>
                            </p>
                        </div>
                    </li>

                    <li><hr class="dropdown-divider"></li>
                    <li>요금 세부정보</li>
<%--                    <li>₩544,500 x 5박 ₩2,722,500</li>--%>
                    <li class="d-flex gap-2 py-2 px-3 lh-sm text-start">
                        <div class="col-sm-8 text-left"><span>₩544,500</span> x </div>
                        <div class="col-sm-4 text-right">₩2,722,500</div>
                    </li>

                    <li>
                        <a class="text-dark" href="#">AURASTAY 서비스 수수료</a> ₩422,789
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <li>총액 (KRW) ₩3,145,289</li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>