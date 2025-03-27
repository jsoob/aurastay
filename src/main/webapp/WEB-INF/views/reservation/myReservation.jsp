<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            // document.getElementById('rsrvBtn').addEventListener('click', (event) => {
            //     $('#rsrvCancelModal').modal('show');
            // });
            $("#rsrvBtn").click(function() {
                $('#rsrvCancelModal').modal('show');
            });
            // $("button.copyAddress").click(function() {
            //     navigator.clipboard.writeText($(this).attr('value'));
            // });
        });
        async function copyAddress(el) {
            try {
                const text = $(el).attr('value');
                await navigator.clipboard.writeText(text);
                alert("주소가 복사되었습니다.");
            } catch (error) {
                console.error(error.message);
            }
        }

    </script>
</head>
<body>

<div class="container rsrv-container">
    <div class="rsrv-title-container">
        <h1>내 예약 조회</h1>
    </div>
    <div class="rsrv-body-container">

        <div class="myReservation-div">
            <div class="myReservation-tabs">
                <ul class="nav nav-pills" id="pills-tab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <c:choose>
                            <c:when test="${rsStatus == 1}">
                                <a href="/reservation/mystays?rsStatus=1" class="text-decoration-none">
                                    <button class="nav-link active fw-bold" id="pills-home-tab" data-bs-toggle="pill" type="button" role="tab" aria-selected="true">다가오는 예약</button>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="/reservation/mystays?rsStatus=1" class="text-decoration-none">
                                    <button class="nav-link fw-bold" id="pills-home-tab" data-bs-toggle="pill" type="button" role="tab" aria-selected="true">다가오는 예약</button>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li class="nav-item" role="presentation">
                        <c:choose>
                            <c:when test="${rsStatus == 2}">
                                <a href="/reservation/mystays?rsStatus=2" class="text-decoration-none">
                                    <button class="nav-link active fw-bold" id="pills-profile-tab" data-bs-toggle="pill" type="button" role="tab" aria-selected="false">완료된 예약</button>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="/reservation/mystays?rsStatus=2" class="text-decoration-none">
                                    <button class="nav-link fw-bold" id="pills-profile-tab" data-bs-toggle="pill" type="button" role="tab" aria-selected="false">완료된 예약</button>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                    <li class="nav-item" role="presentation">
                        <c:choose>
                            <c:when test="${rsStatus == 3}">
                                <a href="/reservation/mystays?rsStatus=3" class="text-decoration-none">
                                    <button class="nav-link active fw-bold" id="pills-contact-tab" data-bs-toggle="pill" type="button" role="tab" aria-selected="false">취소 예약</button>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="/reservation/mystays?rsStatus=3" class="text-decoration-none">
                                    <button class="nav-link fw-bold" id="pills-contact-tab" data-bs-toggle="pill" type="button" role="tab" aria-selected="false">취소 예약</button>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </ul>

                <%-- 예약 목록 --%>
                <div class="tab-content" id="pills-tabContent">
                    <div class="tab-pane fade show active" id="pills-home" role="tabpanel">

                        <c:forEach var="rsrv" items="${rsList}" varStatus="myRstart_status">
                        <c:choose>
                        <c:when test="${myRstart_status.index eq 0}">
                        <div class="box-border shadow w-90 max-w-600 text-start margin-auto">
                            </c:when>
                            <c:otherwise>
                            <div class="box-border shadow w-90 max-w-600 text-start margin-auto mt-3">
                                </c:otherwise>
                                </c:choose>

                                <div class="row mb-2">
                                    <div class="col-sm-8">
                                        <c:if test="${rsStatus == 1}">
                                            <h5 class="fw-bold">예약 확정</h5>
                                        </c:if>
                                        <c:if test="${rsStatus == 2}">
                                            <h5 class="fw-bold">예약 완료</h5>
                                            <h6 class="fs-10 f-blue mb-0">리뷰 작성하면 최대 1,000P 적립</h6>
                                        </c:if>
                                        <c:if test="${rsStatus == 3 && rsrv.reservationStatus == 0 }">
                                            <h5 class="fw-bold">취소 완료</h5>
                                        </c:if>
                                        <c:if test="${rsStatus == 3 && rsrv.reservationStatus == 2 }">
                                            <h5 class="fw-bold">취소 대기</h5>
                                        </c:if>
                                    </div>
                                    <div class="col-sm-4 text-end">
                                        <a class="text-decoration-none fw-bold" href="mystay?rsNo=${rsrv.reservationNo}">예약 상세 <span class="fs-5">▶</span></a>
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
                                                <strong class="fs-5 d-block">${rsrv['acmDTO'].acmName}</strong>

                                                <p class="mb-2">${rsrv['acmDTO'].roomName} <span>• ${rsrv.dayCount}박</span></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div class="col-sm-6">
                                        <div class="fs-10 fw-bold f-gray">체크인</div>
                                        <div class="">
                                            <fmt:parseDate value="${rsrv.checkinDate}" var="dateFmt2" pattern="yyyy-MM-dd"/>
                                            <fmt:formatDate value="${dateFmt2}" pattern="E" var="intDay"/>
                                            <div class="fw-bold">${rsrv.checkinDate} (${intDay})</div>
                                            <div class="">${rsrv['acmDTO'].checkinTime}</div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="fs-10 fw-bold f-gray">체크아웃</div>
                                        <div class="">
                                            <fmt:parseDate value="${rsrv.checkoutDate}" var="dateFmt1" pattern="yyyy-MM-dd"/>
                                            <fmt:formatDate value="${dateFmt1}" pattern="E" var="outDay"/>
                                            <div class="fw-bold">${rsrv.checkoutDate} (${outDay})</div>
                                            <div class="">${rsrv['acmDTO'].checkoutTime}</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div class="col-sm-6">
                                        <a href="/acm/acmFind?acmNo=${rsrv['acmDTO'].acmNo}" class="text-decoration-none">
                                            <button class="btn btn btn-secondary btn-gray w-100 h-50px fw-bold">숙소 상세</button>
                                        </a>

                                    </div>
                                    <div class="col-sm-6">
                                        <button class="btn btn btn-secondary btn-gray w-100 h-50px fw-bold" onclick="copyAddress(this)" value="${rsrv['acmDTO'].acmAddress}">주소 복사</button>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-12">
                                        <c:if test="${rsStatus == 1}">
                                            <button class="btn btn btn-secondary btn-pink w-100 h-50px fw-bold" id="rsrvBtn" data-bs-toggle="modal" data-bs-target="#rsrvCancelModal">예약 취소</button>

                                            <%-- 결제취소 모달 --%>
                                            <div class="modal fade" id="rsrvCancelModal" tabindex="-1" aria-labelledby="rsrvCancelModalLabel" aria-hidden="true">
                                                <div class="modal-dialog  modal-dialog-centered modal-lg" >
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h1 class="modal-title fs-5" id="rsrvCancelModalLabel">예약 취소 요청</h1>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <form class="m-0" action="/reservation/staycancel" name="stayCancelForm" method="post">
                                                            <div class="modal-body">
                                                                <div class="row mb-3">
                                                                    <div class="col-sm-3">
                                                                        <label>예약번호</label>
                                                                        <input type="text" name="rsNo" class="form-control fs-10 bckc-gray" value="${rsrv.reservationNo}" readonly>
                                                                    </div>
                                                                    <div class="col-sm-8">
                                                                        <label>예약 정보</label>
                                                                        <input type="text" class="form-control fs-10 bckc-gray" value="${rsrv['acmDTO'].acmName} - ${rsrv['acmDTO'].roomName} (${rsrv.dayCount}박)" readonly>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <h3>취소 사유를 입력하세요.</h3>
                                                                    <div class="mb-2">숙소 측에서 예약 요청을 승인하면 예약 취소 및 환불이 진행됩니다.<br>(미승인시, 체크인 당일 그대로 예약 진행됩니다.)</div>
                                                                    <div>
                                                                        <textarea id="cancelReasons" name="cancelReasons" class="py-2 box-border" rows="3" required></textarea>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <input type="submit" class="btn btn-primary btn-pink" value="취소 요청">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${rsStatus == 2}">
                                            <button class="btn btn btn-secondary btn-pink w-100 h-50px fw-bold">리뷰 작성</button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </div>
</body>
</html>