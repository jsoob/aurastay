<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>내 예약 조회</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- icon -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- select 라이브러리 -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    <link rel="stylesheet" href="/css/rsrv/rsrv.css">
    <script>
        $(() => {
            <%--let rs = ${rs};--%>
            // console.log("rs = ", rs);
            <%--let triggerEl = document.querySelector('#pills-tab a[href="/reservation/mystays?rs=${rs}"]');--%>
            <%--bootstrap.Tab.getInstance(triggerEl).show();--%>

            $('a[data-bs-toggle="pill"]').on('shown.bs.tab', function (e) {
                let gg = $(e.target).attr("aria-controls");
            });
        });
    </script>
</head>
<body>
<h3><a href="/">목록가기</a></h3>

<%-- 실제 html --%>
<div class="container rsrv-container">
    <div class="rsrv-title-container">
        <h1>내 예약 조회</h1>
    </div>
    <div class="rsrv-body-container">

        <div class="myReservation-div">
            <div class="myReservation-tabs">
                <ul class="nav nav-pills" id="pills-tab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active fw-bold" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">다가오는 예약</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link fw-bold" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">완료된 예약</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link fw-bold" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button" role="tab" aria-controls="pills-contact" aria-selected="false">취소된 예약</button>
                    </li>
                </ul>

                <%-- 예약 목록 --%>
                <div class="tab-content" id="pills-tabContent">
                    <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                        <c:forEach var="i" begin="1" end="2" varStatus="myRstart_status">
                            <c:choose>
                                <c:when test="${myRstart_status.index eq 1}">
                                <div class="box-border shadow w-90 max-w-700 text-start margin-auto">
                                </c:when>
                                <c:otherwise>
                                    <div class="box-border shadow w-90 max-w-700 text-start margin-auto mt-3">
                                </c:otherwise>
                            </c:choose>

                                <div class="row mb-2">
                                    <div class="col-sm-8">
                                        <h5 class="fw-bold">예약 확정</h5>
                                        <h6 class="fs-10 f-blue mb-0">리뷰 작성하면 최대 1,000P 적립</h6>
                                    </div>
                                    <div class="col-sm-4 text-end">
                                        <a class="text-decoration-none fw-bold" href="mystay?reservationNo=1">예약 상세 <span class="fs-5">▶</span></a>
                                    </div>
                                </div>
                                <hr>
                                <div class="row mb-2">
                                    <div class="d-flex">
                                        <div>
                                            <img class="acm-img-thumbnail radius_12" src="https://a0.muscache.com/im/pictures/0f52b46a-16fe-472f-a04b-eec52680f162.jpg?aki_policy=large" >
                                        </div>
                                        <div class="ms-2">
                                            <div class="w-100 ms-1">
                                                <strong class="fs-5 d-block">E°SO 이소하우스 60평 독채</strong>
                                                <p class="mb-2">디럭스룸 <span>• 2박</span></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div class="col-sm-6">
                                        <div class="fs-10 fw-bold f-gray">체크인</div>
                                        <div class="">
                                            <div class="fw-bold">2025.03.10 (월)</div>
                                            <div class="">15:00</div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="fs-10 fw-bold f-gray">체크아웃</div>
                                        <div class="">
                                            <div class="fw-bold">2025.03.11 (화)</div>
                                            <div class="">11:00</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div class="col-sm-6">
                                        <button class="btn btn btn-secondary btn-gray w-100 h-50px fw-bold">숙소 상세</button>
                                    </div>
                                    <div class="col-sm-6">
                                        <button class="btn btn btn-secondary btn-gray w-100 h-50px fw-bold">주소 복사</button>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-12">
                                        <button class="btn btn btn-secondary btn-pink w-100 h-50px fw-bold">예약 취소</button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <%-- 다가오는 예약 끝 --%>
                    <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                        <c:forEach var="i" begin="1" end="5" varStatus="myRstart_status">
                            <c:choose>
                                <c:when test="${myRstart_status.index eq 1}">
                                    <div class="box-border shadow w-90 max-w-700 text-start margin-auto">
                                </c:when>
                                <c:otherwise>
                                    <div class="box-border shadow w-90 max-w-700 text-start margin-auto mt-3">
                                </c:otherwise>
                            </c:choose>
                                <div class="row mb-2">
                                    <div class="col-sm-8">
                                        <h5 class="fw-bold">예약 완료</h5>
                                        <h6 class="fs-10 f-blue mb-0">리뷰 작성하면 최대 1,000P 적립</h6>
                                    </div>
                                    <div class="col-sm-4 text-end">
                                        <a class="text-decoration-none fw-bold" href="mystay?reservationNo=1">예약 상세 <span class="fs-5">▶</span></a>
                                    </div>
                                </div>
                                <hr>
                                <div class="row mb-2">
                                    <div class="d-flex">
                                        <div>
                                            <img class="acm-img-thumbnail radius_12" src="https://a0.muscache.com/im/pictures/0f52b46a-16fe-472f-a04b-eec52680f162.jpg?aki_policy=large" >
                                        </div>
                                        <div class="ms-2">
                                            <div class="w-100 ms-1">
                                                <strong class="fs-5 d-block">E°SO 이소하우스 60평 독채</strong>
                                                <p class="mb-2">디럭스룸 <span>• 2박</span></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div class="col-sm-6">
                                        <div class="fs-10 fw-bold f-gray">체크인</div>
                                        <div class="">
                                            <div class="fw-bold">2025.03.10 (월)</div>
                                            <div class="">15:00</div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="fs-10 fw-bold f-gray">체크아웃</div>
                                        <div class="">
                                            <div class="fw-bold">2025.03.11 (화)</div>
                                            <div class="">11:00</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-12">
                                        <button class="btn btn btn-secondary btn-pink w-100 h-50px fw-bold">리뷰 작성</button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <%-- 완료된 예약 끝 --%>
                    <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
                        <c:forEach var="i" begin="1" end="3" varStatus="myRstart_status">
                            <c:choose>
                                <c:when test="${myRstart_status.index eq 1}">
                                    <div class="box-border shadow w-90 max-w-700 text-start margin-auto">
                                </c:when>
                                <c:otherwise>
                                    <div class="box-border shadow w-90 max-w-700 text-start margin-auto mt-3">
                                </c:otherwise>
                            </c:choose>
                                <div class="row mb-2">
                                    <div class="col-sm-8">
                                        <c:if test="${(myRstart_status.index)%2 eq 0}">
                                            <h5 class="fw-bold">취소 대기</h5>
                                        </c:if>
                                        <c:if test="${(myRstart_status.index)%2 eq 1}">
                                            <h5 class="fw-bold">취소 완료</h5>
                                        </c:if>

                                        <h6 class="fs-10 f-blue mb-0">리뷰 작성하면 최대 1,000P 적립</h6>
                                    </div>
                                    <div class="col-sm-4 text-end">
                                        <a class="text-decoration-none fw-bold" href="mystay?reservationNo=1">예약 상세 <span class="fs-5">▶</span></a>
                                    </div>
                                </div>
                                <hr>
                                <div class="row mb-2">
                                    <div class="d-flex">
                                        <div>
                                            <img class="acm-img-thumbnail radius_12" src="https://a0.muscache.com/im/pictures/0f52b46a-16fe-472f-a04b-eec52680f162.jpg?aki_policy=large" >
                                        </div>
                                        <div class="ms-2">
                                            <div class="w-100 ms-1">
                                                <strong class="fs-5 d-block">E°SO 이소하우스 60평 독채</strong>
                                                <p class="mb-2">디럭스룸 <span>• 2박</span></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div class="col-sm-6">
                                        <div class="fs-10 fw-bold f-gray">체크인</div>
                                        <div class="">
                                            <div class="fw-bold">2025.03.10 (월)</div>
                                            <div class="">15:00</div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="fs-10 fw-bold f-gray">체크아웃</div>
                                        <div class="">
                                            <div class="fw-bold">2025.03.11 (화)</div>
                                            <div class="">11:00</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-6">
                                        <button class="btn btn btn-secondary btn-gray w-100 h-50px fw-bold">숙소 상세</button>
                                    </div>
                                    <div class="col-sm-6">
                                        <button class="btn btn btn-secondary btn-gray w-100 h-50px fw-bold">주소 복사</button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <%-- 취소된 예약 끝 --%>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>