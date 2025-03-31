<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>예약 상세 조회</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <%-- icon --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

    <%-- select 라이브러리 --%>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    <%-- 결제 --%>
    <script type="text/javascript" src="https://cdn.portone.io/v2/browser-sdk.js"></script>

    <link rel="stylesheet" href="/css/main.css">

    <link rel="stylesheet" href="/css/rsrv/rsrv.css">
    <script>
        $(() => {
            document.getElementById('rsrvBtn').addEventListener('click', (event) => {
                $('#rsrvCancelModal').modal('show');
            });

            $('#rsrvCancelModal').on('show.bs.modal', function (event) {
                // let button = $(event.relatedTarget);
                // let recipient = button.data('whatever');
                // let modal = $(this);
                //
                // modal.find('.modal-title').text('New message to ' + recipient);
                // modal.find('.modal-body input').val(recipient);
            })
        });
    </script>
</head>
<body>

<jsp:include page="../main/header.jsp"/>

<%-- 실제 html --%>
<div class="container main_body_container rsrv-container">
    <div class="rsrv-title-container">
        <h1><a class="text-decoration-none text-dark" href="/reservation/mystays"><span
                class="px-2 rsrv-back-circleBtn fs-3 fw-bold"><</span></a> 예약 정보</h1>
    </div>
    <div class="rsrv-body-container main_body_container">
        <div class="d-flex p-4 gap-4 py-md-5 justify-content-center"> <%-- align-items-center --%>
            <div class="left-container">
                <h3 class="mb-4">예약 정보
                    <c:choose>
                        <c:when test="${rsrv.reservationStatus eq 0}"> (취소완료)</c:when>
                        <c:when test="${rsrv.reservationStatus eq 1}"> (예약확정)</c:when>
                        <c:when test="${rsrv.reservationStatus eq 2}"> (취소대기)</c:when>
                    </c:choose>
                </h3>
                <div class="box-border mb-3 ps-4">
                    <div class="row mb-3">
                        <div class="fs-5 mb-3">룸 타입</div>
                        <div class="fs-5 fw-bold">${rsrv['acmDTO'].acmName}</div>
                        <div class="fs-6 fw-bold">${rsrv['acmDTO'].roomName}</div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-6">
                            <div class="fs-10">체크인</div>
                            <div class="">
                                <fmt:parseDate value="${rsrv.checkinDate}" var="dateFmt2" pattern="yyyy-MM-dd"/>
                                <fmt:formatDate value="${dateFmt2}" pattern="E" var="intDay"/>
                                <div class="fw-bold">${rsrv.checkinDate} (${intDay})</div>
                                <div class="">${rsrv['acmDTO'].checkinTime}</div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="fs-10">체크아웃</div>
                            <div class="">
                                <fmt:parseDate value="${rsrv.checkoutDate}" var="dateFmt1" pattern="yyyy-MM-dd"/>
                                <fmt:formatDate value="${dateFmt1}" pattern="E" var="outDay"/>
                                <div class="fw-bold">${rsrv.checkoutDate} (${outDay})</div>
                                <div class="">${rsrv['acmDTO'].checkoutTime}</div>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="none" size="1.4" unit="rem" viewBox="0 0 24 24" class="platform-site-11026c0">
                                <%-- 머리 --%>
                                <path fill="#1A1A1A" fill-rule="evenodd" d="M12.25 4.414a3.75 3.75 0 1 0 0 7.5 3.75 3.75 0 0 0 0-7.5M7 8.164a5.25 5.25 0 1 1 10.5 0 5.25 5.25 0 0 1-10.5 0" clip-rule="evenodd"></path>
                                <%-- 몸통 --%>
                                <path fill="#1A1A1A" fill-rule="evenodd" d="M19.19 16.539c-3.721-4.094-10.159-4.094-13.88 0a4.07 4.07 0 0 0-1.06 2.74v1.017c0 .203.165.368.368.368h15.264a.37.37 0 0 0 .368-.368v-1.017c0-1.014-.378-1.99-1.06-2.74M4.2 15.529c4.316-4.748 11.784-4.748 16.1 0a5.57 5.57 0 0 1 1.45 3.75v1.017a1.87 1.87 0 0 1-1.868 1.868H4.618a1.87 1.87 0 0 1-1.868-1.868v-1.017c0-1.387.517-2.723 1.45-3.75" clip-rule="evenodd"></path>
                            </svg>
                            <span class="fs-10">기준 ${rsrv['acmDTO'].roomCapacity}명 / 최대 ${rsrv['acmDTO'].roomCapacity}명</span>
                        </div>
                    </div>
                </div>
                <%-- 숙소 예약 정보 끝 --%>

                <div class="box-border mb-3">
                    <div class="row px-2 fs-10">
                        <div class="fs-6 fw-bold">
                            <div class="row">
                                <div class="col-sm-8 mb-2">예약</div>
                            </div>
                        </div>

                        <div class="row mb-2 pe-0">
                            <div class="col-sm-6">
                                <label>예약번호</label>
                                <input type="text" class="form-control fs-10" value="${rsrv.reservationNo}" disabled>
                            </div>
                            <div class="col-sm-6">
                                <label>결제일</label>
                                <input type="text" class="form-control fs-10" value="${rsrv.payment.paymentCompletionDate}" disabled>
                            </div>
                        </div>

                    </div>
                    <hr>

                    <div class="row px-2 fs-10">
                        <div class="fs-6 fw-bold">
                            <div class="row">
                                <div class="col-sm-8 mb-2">대표 투숙객</div>
                            </div>
                        </div>

                        <div class="row mb-2 pe-0">
                            <div class="col-sm-6">
                                <input type="text" class="form-control fs-10" value="${rsrv.guestName}" disabled>
                            </div>
                            <div class="col-sm-6">
                                <input type="text" class="form-control fs-10" value="${rsrv.guestPhoneNumber}" disabled>
                            </div>
                        </div>


                        <div class="row mb-2 pe-0">
                            <div class="col-sm-6">
                                <input type="text" class="form-control fs-10" value="${rsrv.guestEmail}" disabled>
                            </div>
                            <div class="col-sm-6">
                                <input type="text" class="form-control fs-10" value="${rsrv.residenceCountry}" disabled>
                            </div>
                        </div>

                    </div>
                </div>
                <%-- 대표 투숙객 정보 --%>

                <div class="box-border mb-3">
                    <div class="row px-2 mb-3 fs-10">
                        <div class="fs-6 mb-2">특별 요청</div>
                        <div class="mb-2">특별 요청의 반영 여부는 숙소의 개별적인 사정에 따라 결정되며 보장되지 않습니다.</div>
                        <div class="row mb-2">

                            <!-- 여기 확인!!!!! 조회가 안됨! -->
                            <c:forEach varStatus="rrStatus" var="reservationRequest" items="${rsrv.reservationRequests}">
                                <div class="col-sm-6 mb-2">
                                    <input class="form-check-input" type="checkbox" id="reservationRequest_${rrStatus.index}" value="${reservationRequest.requestNo}" checked disabled>
                                    <label class="form-check-label opacity-1" for="reservationRequest_${rrStatus.index}">${reservationRequest.requestName}</label>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="row">
                            <div class="mb-2">상세 요청</div>
                            <div>
                                    <textarea id="reservationDetailsRequest" name="reservationDetailsRequest" class="py-2 box-border bckc-gray" disabled rows="3">${rsrv.reservationDetailsRequest}</textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- 특별 요청하기 끝 --%>
            </div>
            <%-- left 끝 --%>

            <div class="right-container">
                <div class="fs-4 mb-3">숙소 정보</div>
                <div class="mb-3">
                    <div class="rsv acm-menu box-border p-4">
                        <div class="row mb-2">
                            <div class="d-flex gap-2 pb-2 lh-sm text-start">
                                <img class="acm-img-thumbnail radius_12 img-100" src="/accommodation/views/${rsrv['acmDTO'].filename}" alt="숙소 이미지">

                                <div class="w-100 ms-1">
                                    <strong class="d-block">${rsrv.acmDTO['acmName']}</strong><%--E°SO 이소하우스 60평 독채--%>
                                    <p class="mb-2">${category.categoryName}</p><%--펜션--%>
                                    <p class="fs-10 mb-2">${rsrv.acmDTO.acmAddress}</p><%--강원도 강릉시 창해로 307--%>
                                    <div class="fs-10 float-start me-2">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor"
                                             class="mb-1 bi bi-star-fill" viewBox="0 0 16 16">
                                            <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                        </svg>
                                        4.93(114)
                                    </div>
                                    <div class="fs-10 fw-bold">•<span class="ms-1">${keyword.keywordName}</span></div><%--해변(키워드명)--%>
                                </div>
                            </div>
                        </div>

                        <hr>

                        <div class="fs-5">요금 세부정보</div>
                        <%-- <li>₩544,500 x 5박 ₩2,722,500</li> --%>
                        <div class="row py-1 lh-sm fs-10 pe-2">
                            <%--                                <div class="col-sm-8 text-start"><span>₩${roomDetail.roomPrice}</span> x <span>${countDay}</span>박</div>--%>
                            <div class="col-sm-8 text-start">1박당 요금(세금 및 봉사료 포함)</div>
                            <div class="col-sm-4 text-end <c:if test='${rsrv.payment.discountPercentage ne 0}'>text-decoration-line-through</c:if>">₩<fmt:formatNumber type="number"
                                                                              maxFractionDigits="0"
                                                                              value="${rsrv.payment.roomPrice}" /></div>
                        </div>

                        <c:if test='${rsrv.payment.discountPercentage ne 0}'>
                            <c:set var="roomDisPrice" value="${rsrv.payment.roomPrice - (rsrv.payment.roomPrice*rsrv.payment.discountPercentage/100)}" />
                            <div class="row py-1 lh-sm fs-10 pe-2">
                                <div class="col-sm-8 text-start">할인 ${rsrv.payment.discountPercentage} %</div>
                                <div class="col-sm-4 text-end ">₩<fmt:formatNumber type="number" maxFractionDigits="0" value="${roomDisPrice}" /></div>
                            </div>
                        </c:if>

                        <div class="row py-1 lh-sm fs-10 pe-2">
                            <div class="col-sm-8 text-start">
                                <button id="rsrvCommBtn" class="btn-none text-dark px-0">포인트 적립</button>
                            </div>
                            <div class="col-sm-4 text-end">
                                <fmt:formatNumber type="number"
                                                  maxFractionDigits="0"
                                                  value="${roomDetail.roomPrice*0.01}" /></div>

                        </div>
                        <div>
                            <hr>
                        </div>

                        <div class="row py-1 lh-sm pe-2">
                            <div class="col-sm-8 text-start">결제 방법</span>
                            </div>
                            <div class="col-sm-4 text-end">${rsrv.payment.provider}</div>
                        </div>

                        <div class="row py-1 lh-sm pe-2">
                            <div class="col-sm-8 text-start">결제 금액 <span class="fw-bold"></span>
                            </div>
                            <div class="col-sm-4 text-end">
                                <span class="fw-bold">₩<fmt:formatNumber type="number"
                                        maxFractionDigits="0" value="${rsrv.payment.roomPrice}" /></span>
                            </div>
                        </div>

                    </div>

                    <%--                <div aria-live="polite" aria-atomic="true" class="d-flex justify-content-center align-items-center w-100">--%>

                    <div class="toast-container p-3 top-150">
                        <div id="rsrvComm" class="toast shadow-lg" role="alert" aria-live="assertive" aria-atomic="true" style="border: 2px solid #e3e3e3;">
                            <div class="toast-header p-3 ps-2">
                                <div class="d-flex">
                                    <button type="button" class="btn-close m-2 my-0" data-bs-dismiss="toast" aria-label="Close"></button>
                                    숙소 예약 결제시, 금액의 1%를 포인트로 적립할 수 있습니다. 취소 할 경우에는 포인트를 회수합니다.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- 드롭메뉴 --%>

                <fmt:parseDate value="${rsrv.checkinDate}" var="getDate" pattern="yyyy-MM-dd"/>
                <fmt:formatDate value="${getDate}" var="inDate" pattern="yyyy-MM-dd" />

                <c:set var="getDate" value="<%= new java.util.Date() %>" />
                <fmt:formatDate value="${getDate}" var="nowDate" pattern="yyyy-MM-dd" />

                <c:if test="${rsrv.reservationStatus eq 1}">
                    <c:choose>
                        <c:when test="${nowDate > inDate}">
                            <div class="rsrv-btn-div">
                                <a href="/review/add">
                                    <button class="btn btn-primary btn-pink p-3" id="rsrvBtn">리뷰 작성</button>
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="rsrv-btn-div">
                                <button class="btn btn-primary btn-pink p-3" id="rsrvBtn" data-bs-toggle="modal" data-bs-target="#rsrvCancelModal">예약 취소</button>
                            </div>

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

                        </c:otherwise>
                    </c:choose>
                </c:if>
            </div>
            <%-- right 끝 --%>
        </div>
        <%--        </form>--%>
    </div>
</div>
</div>
<jsp:include page="../main/footer.jsp"/>
<script src="/js/main.js"></script>
</body>
</html>