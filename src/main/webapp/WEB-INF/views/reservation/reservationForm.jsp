<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>예약 요청</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <%-- icon --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <%-- select 라이브러리 --%>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    <%-- 결제 --%>
    <script type="text/javascript" src="https://cdn.portone.io/v2/browser-sdk.js"></script>

    <link rel="stylesheet" href="/css/rsrv/rsrv.css">
    <script>
        $(() => {
            // $('.rsrv-body-container a, .rsrv-body-container button').on("click",function(e){
            //     e.preventDefault();
            // });
            // document.onmousedown = function leftClick() {
            //     console.log(":0");
            //     $(".toast").removeClass("show");
            // };

            $(".tosChk_1_none, .tosChk_2_none, .tosChk_3_none").css("display", "none");

            // 국가 지역
            $.ajax({
                url: 'https://api.odcloud.kr/api/15051105/v1/uddi:f353af64-f303-475e-a6d9-dd8885dea981?page=1&perPage=500&serviceKey=teeNJl0EGacy%2FnNigpTLd2277dRs0ffcAkr%2F%2BYDU0ABnJH%2B1%2FmCedlG8qKfEUFMizJkM%2F49RvhGVdKuChjeNSQ%3D%3D',
                type: 'GET',
                success: function(data) {
                    // console.log(data);

                    // 국가코드 data
                    let datas = data.data;
                    console.log("datas : ", datas);
                    // 국가수
                    let totalCount = data.totalCount;

                    // 국가 ISO 2자리코드

                    // console.log(datas[0]['ISO alpha2']);
                    // console.log(datas[0]['국가코드_국제표준(ISO)_알파벳2자리']);
                    // 국가명
                    // console.log(datas[0]['국가명']);

                    // 초기화
                    $("#residenceCountry").empty();
                    // $("#ctCount").children('option:not(:first)').remove();

                    for (let i = 0; i <= totalCount-1; i++) {
                        // $("#residenceCountry").append('<option value="'+ datas[i]['국가코드_국제표준(ISO)_알파벳2자리'] +'">'+ datas[i]['국가명'] +'</option>');
                        $("#residenceCountry").append('<option value="'+ datas[i]['국가코드_국제표준(ISO)_알파벳2자리'] +'">'+ datas[i]['국가명'] +'</option>');
                    }

                    // search 가능
                    $('#residenceCountry').select2();
                    $('#residenceCountry').val('KR').trigger('change');
                }
            });

            document.getElementById('addMemberBtn').addEventListener('click', (event) => {
                // 동작(이벤트)을 실행하지 못하게 막는 메서드입니다.
                // event.preventDefault();

                if($("#guestName").val() == '') {
                    $("#guestName").val("김우씨");
                }
                if($("#guestPhoneNumber").val() == '') {
                    $("#guestPhoneNumber").val("01011111111");
                }
                if($("#guestEmail").val() == '') {
                    $("#guestEmail").val("js@naver.com");
                }
            });

            // toast click
            const rsrvComm_toastTrigger = document.getElementById('rsrvCommBtn');
            const rsrvComm_toastLiveExample = document.getElementById('rsrvComm');
            if (rsrvComm_toastTrigger) {
                rsrvComm_toastTrigger.addEventListener('click', () => {
                    const toast = new bootstrap.Toast(rsrvComm_toastLiveExample);
                    toast.show();
                });
            }

            // toast click
            const rsrvPop_toastTrigger1 = document.getElementById('rsrvPop1Btn');
            const rsrvPop_toastLiveExample1 = document.getElementById('rsrvPop1');
            if (rsrvPop_toastTrigger1) {
                rsrvPop_toastTrigger1.addEventListener('click', () => {
                    $(".rsrvPop").removeClass("show").addClass("hide");
                    const toast = new bootstrap.Toast(rsrvPop_toastLiveExample1);
                    toast.show();
                });
            }

            const rsrvPop_toastTrigger2 = document.querySelectorAll('.rsrvPop2Btn');
            const rsrvPop_toastLiveExample2 = document.getElementById('rsrvPop2');
            rsrvPop_toastTrigger2.forEach((target) => target.addEventListener("click", function(){
                    $(".rsrvPop").removeClass("show").addClass("hide");
                    const toast = new bootstrap.Toast(rsrvPop_toastLiveExample2);
                    toast.show();
                })
            );

            const rsrvPop_toastTrigger3 = document.getElementById('rsrvPop3Btn');
            const rsrvPop_toastLiveExample3 = document.getElementById('rsrvPop3');
            if (rsrvPop_toastTrigger3) {
                rsrvPop_toastTrigger3.addEventListener('click', () => {
                    $(".rsrvPop").removeClass("show").addClass("hide");
                    const toast = new bootstrap.Toast(rsrvPop_toastLiveExample3);
                    toast.show();
                });
            }

            $(".btn-close").click(function() {
                $(".rsrvPop").removeClass("show");
            });

            // 이용약관 전체 체크
            $("#tosChkAll").click(function() {
                if($("#tosChkAll").is(":checked")) {
                    $("input[name=tosChk]").prop("checked", true);
                    $(".tosChk_1_none, .tosChk_2_none, .tosChk_3_none").css("display", "none");
                } else {
                    $("input[name=tosChk]").prop("checked", false);
                }
            });

            // 이용약관 체크
            $("input[name=tosChk]").click(function() {
                let total = $("input[name=tosChk]").length;
                let checked = $("input[name=tosChk]:checked").length;
                $("."+this.id+"_none").css("display", "none");

                if(total != checked) $("#tosChkAll").prop("checked", false);
                else $("#tosChkAll").prop("checked", true);
            });

            // 결제 요청
            document.getElementById('rsrvBtn').addEventListener('click', async function requestPayment() {
                let checkboxes = document.querySelectorAll(".tosCheck_none");
                let check = false;
                for (let i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i].checked) {
                        $("."+checkboxes[i].id+"_none").css("display", "none");
                    } else {
                        $("."+checkboxes[i].id+"_none").css("display", "");
                        check = true;
                    }
                }

                // 투숙객명
                let guestName = $("#guestName").val().trim();
                if(guestName.length < 2) {
                    check = true;
                } else {
                    let pattern =  /^[가-힣]{2,10}$/;
                    /*let pattern =  /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;*/ // \s 띄어쓰기 영문 이름 2~10자 이내 : 띄어쓰기(\s)가 들어가며 First, Last Name 형식
                        // /[^가-힣a-zA-Z]/g;
                    if(pattern.test(guestName) === false) {
                        $("#guestName").val('');
                        check = true;
                    }
                }

                // 전화번호
                let guestPhoneNumber = $("#guestPhoneNumber").val().trim();
                if(guestPhoneNumber.length == 0) {

                } else if(guestPhoneNumber.length < 11) { // 입력 됐는데 1~10 자리면 true
                    $("#guestPhoneNumber").val('');
                    check = true;
                } else {
                    let pattern = /^01(?:0|1|[6-9])\d{3,4}\d{4}$/;
                    if(pattern.test(guestPhoneNumber) === false) {
                        $("#guestPhoneNumber").val('');
                        check = true;
                    }
                }


                let guestEmail = $("#guestEmail").val().trim();
                if(guestEmail.length < 0) {
                    check = true;
                } else {
                    let pattern =  /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                    if(pattern.test(guestEmail) === false) {
                        $("#guestEmail").val('');
                        check = true;
                    }
                }

                if(check) {
                    return;
                }

                console.log("결제하기");
                // console.log(window.PortOne);

                const rnd = Math.floor(Math.random()*1000000);

                // 결제 요청 팝업
                const response = await PortOne.requestPayment({
                    // 상점 아이디
                    storeId : "store-4b8d38b9-6775-4065-9eb0-6d3d89d63815",
                    // 채널 키
                    channelKey : "channel-key-6509c147-0348-470a-a3b5-5cb7138919dc",

                    // 결제승인 ID
                    // 0123456789(member_no)-111111(랜덤번호)
                    paymentId : "1"+"-"+rnd,

                    // 상품명
                    orderName : "${roomDetail['accommodationName']}",
                    customer : {
                        id : "idid",
                        fullName : guestName,
                        phoneNumber : guestPhoneNumber,
                        email : guestEmail,
                        // address : { country : $("#residenceCountry").val(), addressLine1 : "" }
                        // country : $("#residenceCountry").val()
                    },
                    country : $("#residenceCountry").val(), // 결제 국가 ISO 3166-1 alpha-2에 의해 표준화된 2글자 국가 코드
                    ceoFullName : "AuraStay",
                    businessName : "난사자",
                    storeDetails : {
                        ceoFullName : "AuraStay",
                        phoneNumber : "010-0000-0000",
                        address : "구로궁"
                    },

                    // 가격
                    totalAmount : ${roomDetail.roomPrice*countDay}, // 100원짜리 <- 나중에 EL로 가격 가져와도 됨.
                    <%-- ${roomDetail.roomPrice} --%>
                    // 통화 단위
                    currency : "CURRENCY_KRW",
                    // 결제 수단 지정
                    payMethod : "CARD"
                });

                if (response.code !== undefined) {
                    // 오류 발생
                    alert("결제 실패 :< ! ", response.message); // 결제 실패..
                    return location.reload(true);
                } else {
                    console.log("결제 완료!!");

                    // 결제 승인이 떨어진 다음에는 관리자도구에서 response를 출력해준다.
                    console.log("response", response);

                    console.log("response.paymentId = " , response.paymentId); // 결제 요청에 전달된 결제 ID입니다.
                    console.log("response.txId = " , response.txId); // 결제 시도 고유 번호 / 포트원에서 채번하는 결제 시도 고유 번호입니다.
                    console.log("response.transactionType = " , response.transactionType); // 일반결제의 경우 무조건 PAYMENT로 전달됩니다.

                    // console.log("response.code = " , response.code); // 실패한 경우 오류 코드입니다.
                    // console.log("response.message = " , response.message); // 실패한 경우 오류 메시지입니다.
                    //
                    // console.log("response.pgCode = " , response.pgCode); // PG에서 오류 코드를 내려 주는 경우 이 오류 코드를 그대로 반환합니다.
                    // console.log("response.pgMessage = " , response.pgMessage); // PG에서 오류 메시지를 내려 주는 경우 이 오류 메시지를 그대로 반환합니다.


                    let specialRequestsLength = $("input[name='specialRequests[]']:checked").length;
                    let specialRequests = [];
                    if(specialRequestsLength > 1){
                        $("input[name='specialRequests[]']:checked").each(function(e){
                            specialRequests.push($(this).val());
                        })
                    }

                    <spring:eval expression="@environment.getProperty('payment.PORTONE_API_SECRET')" var="PORTONE_API_SECRET"/>
                    // console.log("specialRequests : " , specialRequests);
                    <%--console.log("PORTONE_API_SECRET : " , `${PORTONE_API_SECRET}`);--%>

                    // /payment/complete 엔드포인트를 구현해야 합니다. 다음 목차에서 설명합니다.
                    <%--const notified = await fetch(`${SERVER_BASE_URL}/payment/complete`, {--%>

                    // 1. 포트원 결제내역 단건조회 API 호출
                    const paymentResponse = await fetch(
                        `https://api.portone.io/payments/`+response.paymentId, <%--${encodeURIComponent(response.paymentId)}--%>
                        {
                            headers: { Authorization: `PortOne ${PORTONE_API_SECRET}` },
                        },
                    );

                    if (!paymentResponse.ok)
                        console.log("에러에러!!");
                    const payment = await paymentResponse.json();

                    console.log("payment!!!!!!");
                    console.log("payment : ", payment );

                    const jsonData = {
                        "payment" : payment,
                        // txId : payment.transactionId
                        // paymentId : payment.id

                        guestName : guestName,
                        guestPhoneNumber : guestPhoneNumber,
                        guestEmail : guestEmail,
                        residenceCountry : $('#residenceCountry').find(':selected')[0].innerText,
                        memberNo : 1, // 사용자번호
                        roomNo :${roomDetail['roomNo']},
                        reservationDetailsRequest : $("#reservationDetailsRequest").val(),
                        accommodationNo : ${roomDetail['accommodationNo']},

                        specialRequests : specialRequests,

                        checkinDate : `${checkinDate}`,
                        checkin : `${roomDetail['checkin']}`,

                        checkoutDate : `${checkoutDate}`,
                        checkout : `${roomDetail['checkout']}`,

                        orderName : "${roomDetail.accommodationName}",
                        totalAmount : ${roomDetail.roomPrice}
                    };
                    console.log("jsonData = ", jsonData);
                    $.ajax({
                        url : "/reservation/payment",
                        type: "POST",
                        dataType: "JSON",
                        contentType: "application/json; charset=utf-8", // "application/json",
                        data: JSON.stringify(jsonData),
                        // "payment" : JSON.stringify(payment),
                        <%--guestName : guestName,--%>
                        <%--guestPhoneNumber : guestPhoneNumber,--%>
                        <%--guestEmail : guestEmail,--%>
                        <%--residenceCountry : $('#residenceCountry').find(':selected')[0].innerText,--%>
                        <%--memberNo : 1, // 사용자번호--%>
                        <%--roomNo :${roomDetail['roomNo']},--%>
                        <%--reservationDetailsRequest : $("#reservationDetailsRequest").val(),--%>
                        <%--accommodationNo : ${roomDetail['accommodationNo']},--%>

                        <%--specialRequests : specialRequests,--%>

                        <%--orderName : "${roomDetail.accommodationName}",--%>
                        <%--totalAmount : ${roomDetail.roomPrice}--%>
                        // data : {
                        //     "jsonData" : JSON.stringify(jsonData)
                        // },
                        success : function (response) {
                            console.log("성공");
                        }, error: function(jqXHR, textStatus, errorThrown) {
                            console.log('AJAX 요청 실패');
                            console.log('상태 코드:', jqXHR); // HTTP 상태 코드
                            console.log('상태 코드:', jqXHR.status); // HTTP 상태 코드
                            console.log('응답 텍스트:', jqXHR.responseText); // 서버에서 반환한 응답
                            console.log('오류 상태:', textStatus); // 요청 상태
                            console.log('오류 메시지:', errorThrown); // 에러 메시지

                            alert('서버와의 통신에 실패했습니다.');
                        }
                    });
                }
            });
        });
    </script>
</head>
<body>
<h3><a href="/">목록가기</a></h3>

<%-- 실제 html --%>
<div class="container rsrv-container">
    <div class="rsrv-title-container">
        <h1><a class="text-decoration-none text-dark" href="/reservation/album_ex"><span
                class="px-2 rsrv-back-circleBtn fs-3 fw-bold"><</span></a> 예약 요청</h1>
    </div>
    <div class="rsrv-body-container">
<%--        <form name="reservationStays" action="reservation/stays" method="post">--%>
            <div class="d-flex p-4 gap-4 py-md-5 justify-content-center"> <%-- align-items-center --%>
                <div class="left-container">

                <c:choose>
                    <c:when test="${acmCount eq 1}">
                        <div class="last-rsrv">
                    </c:when>
                    <c:otherwise>
                        <div class="last-rsrv" style="display: none;">
                    </c:otherwise>
                </c:choose>
                        <div class="box-border mb-3">
                            <div class="row px-2">
                                <div class="row fs-5 pb-1">
                                    <div class="col-sm-12">
                                        <span>마지막 객실</span> <i class="bi-alarm" style="font-size: 1.5rem; color: #ff3665;"></i>
                                    </div>
                                </div>
                                <div class="fs-10">선택하신 날짜에 이 요금으로 이용 가능한 마지막 AuraStay 객실 입니다.</div>
                            </div>
                        </div>
                    </div>

                    <h3 class="mb-4">예약 정보</h3>
                    <div class="box-border mb-3 ps-4">
                        <div class="row mb-3">
                            <div class="fs-5 mb-3">룸 타입</div>
                            <div class="fs-5 fw-bold">${roomDetail['accommodationName']}</div>
                            <div class="fs-6 fw-bold">${roomDetail['roomName']}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-sm-6">
                                <div class="fs-10">체크인</div>
                                <div class="">
                                    <fmt:parseDate value="${checkinDate}" var="dateFmt2" pattern="yyyy-MM-dd"/>
                                    <fmt:formatDate value="${dateFmt2}" pattern="E" var="intDay"/>
                                    <div class="fw-bold">${checkinDate} (${intDay})</div>
                                    <div class="">${roomDetail['checkin']}</div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="fs-10">체크아웃</div>
                                <div class="">
                                    <fmt:parseDate value="${checkoutDate}" var="dateFmt1" pattern="yyyy-MM-dd"/>
                                    <fmt:formatDate value="${dateFmt1}" pattern="E" var="outDay"/>

                                    <div class="fw-bold">${checkoutDate} (${outDay})</div>
                                    <div class="">${roomDetail['checkout']}</div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="none" size="1.4" unit="rem" viewBox="0 0 24 24" class="platform-site-11026c0">
                                    <%-- 머리 --%>
                                    <path fill="#1A1A1A" fill-rule="evenodd" d="M12.25 4.414a3.75 3.75 0 1 0 0 7.5 3.75 3.75 0 0 0 0-7.5M7 8.164a5.25 5.25 0 1 1 10.5 0 5.25 5.25 0 0 1-10.5 0" clip-rule="evenodd"></path>
                                    <%-- 몸통 --%>
                                    <path fill="#1A1A1A" fill-rule="evenodd" d="M19.19 16.539c-3.721-4.094-10.159-4.094-13.88 0a4.07 4.07 0 0 0-1.06 2.74v1.017c0 .203.165.368.368.368h15.264a.37.37 0 0 0 .368-.368v-1.017c0-1.014-.378-1.99-1.06-2.74M4.2 15.529c4.316-4.748 11.784-4.748 16.1 0a5.57 5.57 0 0 1 1.45 3.75v1.017a1.87 1.87 0 0 1-1.868 1.868H4.618a1.87 1.87 0 0 1-1.868-1.868v-1.017c0-1.387.517-2.723 1.45-3.75" clip-rule="evenodd"></path>
                                </svg>
                                <span class="fs-10">기준 ${roomDetail['roomCapacity']}명 / 최대 ${roomDetail['roomCapacity']}명</span>
                            </div>
                        </div>
                    </div>
                    <%-- 숙소 예약 정보 끝 --%>

                    <div class="box-border mb-3">
                        <div class="row px-2 fs-10">
                            <div class="fs-6 fw-bold">
                                <div class="row">
                                    <div class="col-sm-8">대표 투숙객 정보</div>
                                    <div class="col-sm-4 text-end"><button class="btn btn-outline-dark fs-10" id="addMemberBtn">회원 정보 추가</button></div>
                                </div>
                            </div>
                            <div class="mb-3 text-red">*필수 입력 항목입니다</div>

                            <div class="row mb-2 pe-0">
                                <div class="col-sm-6">
                                    <div class="form-item">
                                        <input type="text" id="guestName" name="guestName" autocomplete="off" maxlength="10" required>
                                        <label for="guestName">이름 (Name) *</label>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-item form-item-noChk">
                                        <input type="text" id="guestPhoneNumber" name="guestPhoneNumber" maxlength="11" autocomplete="off" required>
                                        <label for="guestPhoneNumber">전화번호 *</label>
                                    </div>
                                </div>
                            </div>


                            <div class="row mb-2 pe-0">
                                <div class="col-sm-6">
                                    <div class="form-item">
                                        <input type="text" id="guestEmail" name="guestEmail" autocomplete="off" required>
                                        <label for="guestEmail">이메일 주소 *</label>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <%--                            <input type="text" class="form-control">--%>
                                    <select id="residenceCountry" name="residenceCountry" class="form-control">
                                        <option value="">없음</option>
                                    </select>
                                </div>
                            </div>

                        </div>
                    </div>
                    <%-- 대표 투숙객 정보 --%>

                    <div class="box-border mb-3">
                        <div class="row px-2 mb-3 fs-10">
                            <div class="fs-6 mb-2">특별 요청하기 (선택사항)</div>
                            <div class="mb-2">특별 요청의 반영 여부는 숙소의 개별적인 사정에 따라 결정되며 보장되지 않습니다.</div>
                            <div class="row mb-2">
                                <c:forEach varStatus="specialRequestsStatus" var="specialRequest" items="${specialRequests}">
                                    <div class="col-sm-6 mb-2">
                                        <input class="form-check-input" type="checkbox" name="specialRequests[]" id="specialRequest_${specialRequestsStatus.index}" value="${specialRequest.requestNo}">
                                        <label class="form-check-label" for="specialRequest_${specialRequestsStatus.index}">${specialRequest.requestName}</label>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="row">
                                <div class="mb-2">그 외, 추가 요청을 입력하시기 바랍니다.</div>
                                <div>
                                    <textarea id="reservationDetailsRequest" name="reservationDetailsRequest" class="py-2 box-border" rows="3"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%-- 특별 요청하기 끝 --%>

                    <div class="box-border mb-3">
                        <div class="row px-2">
                            <div class="fs-6 mb-2">
                                <input type="checkbox" class="form-check-input" id="tosChkAll" />
                                <label class="form-check-label" for="tosChkAll"> 다음의 모든 항목에 동의합니다.</label>
                            </div>
                            <div class="row mb-2 ps-4">
                                <ul class="fs-10 ps-4 mb-0">
                                    <li class="list-group-item">
                                        <input type="checkbox" class="form-check-input tosCheck_none" id="tosChk_1" name="tosChk">
                                        <label class="form-check-label" for="tosChk_1"> [필수] <button id="rsrvPop1Btn" class="btn-none text-decoration-underline text-dark px-0">이용약관</button>에 동의하며, 만 18세 이상임을 확인합니다.
                                            <br><span class=" fs-10 text-red tosChk_1_none">예약을 처리하기 위해 모든 항목에 동의해 주시기 바랍니다.</span>
                                        </label>

                                        <div class="toast-container p-3 top-0 left-100">
                                            <div id="rsrvPop1" class="toast shadow-lg w-100 rsrvPop" role="alert" aria-live="assertive" aria-atomic="true" style="border: 2px solid #e3e3e3;">
                                                <div class="toast-header p-3 ps-2">
                                                    <div class="d-flex">
                                                        <button type="button" class="btn-close m-2 my-0" data-bs-dismiss="toast" aria-label="Close"></button>
                                                        <div class="row px-2">
                                                            <div class="fs-6 mb-3">예약 이용약관</div>
                                                            <div class="fs-10 mb-2">숙소 예약 결제시, 금액의 1%를 포인트로 적립할 수 있습니다. 취소 할 경우에는 포인트를 회수합니다.</div>
                                                            <div class="row mb-2 ps-4">
                                                                <ul class="fs-10 ps-4 mb-0">
                                                                    <li>여행 공급업체는 각자의 여행 상품에 대한 책임이 있습니다. 당사 플랫폼을 통한 여행 공급업체와의 상호작용은 귀하의 책임입니다. 아고다는 귀하의 여행 또는 귀하의 여행 상품 사용 중에 문제가 발생한 경우 어떠한 책임도 지지 않습니다.</li>
                                                                    <li>경우에 따라, 당사에서 예약 확정 이메일에 확정 번호(이하 '예약 확정 번호')를 제공할 수 있습니다. 여행 공급업체의 정책에 따라 예약 확정서에는 사용할 수 있는 바우처(이하 '예약 바우처')가 포함될 수도 있습니다. 당사나 여행 공급업체는 분실, 도난 또는 파기된 예약 확인 번호 또는 예약 바우처에 대해 책임을 지지 않습니다.</li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <input type="checkbox" class="form-check-input tosCheck_none" id="tosChk_2" name="tosChk">
                                        <label class="form-check-label" for="tosChk_2" style="width: 95%;"> [필수]
                                            <button class="btn-none text-decoration-underline text-dark px-0 rsrvPop2Btn">개인정보 처리방침</button>에
                                            따라
                                            <button class="btn-none text-decoration-underline text-dark px-0 rsrvPop2Btn">개인정보의 수집 및 이용</button>에 동의합니다.
                                            <br><span class=" fs-10 text-red tosChk_2_none">예약을 처리하기 위해 모든 항목에 동의해 주시기 바랍니다.</span>
                                        </label>

                                        <div class="toast-container p-3 top-0 left-100">
                                            <div id="rsrvPop2" class="toast shadow-lg w-100 rsrvPop" role="alert" aria-live="assertive" aria-atomic="true" style="border: 2px solid #e3e3e3;">
                                                <div class="toast-header p-3 ps-2">
                                                    <div class="d-flex">
                                                        <button type="button" class="btn-close m-2 my-0" data-bs-dismiss="toast" aria-label="Close"></button>
                                                        <div class="row px-2">
                                                            <div class="fs-6 mb-3">개인정보 처리방침</div>
                                                            <div class="fs-10 mb-2">개인정보 수집 및 이용</div>
                                                            <div class="row mb-2">
                                                                <div class="fs-10 mb-0">
                                                                    <table class="table fs-10 w-100">
                                                                        <tr>
                                                                            <th>수집하는 개인정보</th>
                                                                            <th>목적</th>
                                                                            <th>보유 기간</th>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>숙박 예약: 이름, 주소, 전화번호, 결제 정보, 이메일 주소, 숙소 이름, 숙소 위치 및/또는 투숙 기간, 결제 방법 및 자격 증명, 기타 결제 처리 관리를 위한 요소, 결제 내역 및 아고다 계정 비밀번호의 정보가 수집될 수 있습니다.</td>
                                                                            <td>요청 처리, 사용자 계정 생성, 신원 확인, 서비스 이용을 위한 연락/정보 등록, 예약과 관련한 커뮤니케이션, 마케팅, 예약 정보 확인 또는 특가 상품 또는 프로모션 참여, 이용자 및 아고다의 보안 유지, 규정 준수/법적 의무 이행.</td>
                                                                            <td>당사는 당사 사이트와 서비스를 제공 및 보호하고 당사의 법적 권리를 행사하며 법적 또는 규제 의무를 준수하는 데 필요한 기간 동안 이용자 정보를 보유합니다.</td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </li>
                                    <li class="list-group-item">
                                        <input type="checkbox" class="form-check-input tosCheck_none" id="tosChk_3" name="tosChk">
                                        <label class="form-check-label" for="tosChk_3"> [필수]
                                            <button id="rsrvPop3Btn" class="btn-none text-decoration-underline text-dark px-0">예약 취소 규정</button>에 동의합니다.
                                            <br><span class=" fs-10 text-red tosChk_3_none">예약을 처리하기 위해 모든 항목에 동의해 주시기 바랍니다.</span>
                                        </label>

                                        <div class="toast-container p-3 top-0">
                                            <div id="rsrvPop3" class="toast shadow-lg w-100 rsrvPop" role="alert" aria-live="assertive" aria-atomic="true" style="border: 2px solid #e3e3e3;">
                                                <div class="toast-header p-3 ps-2">
                                                    <div class="d-flex">
                                                        <button type="button" class="btn-close m-2 my-0" data-bs-dismiss="toast" aria-label="Close"></button>
                                                        <div class="row px-2">
                                                            <div class="fs-6 mb-3">예약 취소 규정</div>
                                                            <div class="fs-10 mb-2">사용 예정일(체크인 날짜) 7일 전 예약을 취소하면 무료 취소가 가능합니다.</div>
                                                            <div class="row mb-2 ps-4">
                                                                <ul class="fs-10 ps-4 mb-0">
                                                                    <li>사용 예정일(체크인 날짜) 6일 전의 예약 취소는 업체에게 취소 요청할 수 있습니다.</li>
                                                                    <li>체크인 이후의 예약 취소 및 예약금 환불은 불가능합니다.</li>
                                                                    <li>숙박 도중 예약 취소를 원하신다면, 업체에게 문제 해결을 요청할 수 있습니다.</li>
                                                                    <li>자세한 사항은 해당 업체 전화번호 또는 이메일에 문의할 수 있습니다.</li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <%--
                    <div class="box-border mb-3">
                        <div class="row px-2">
                            <div class="fs-6 mb-3">예약 취소 규정</div>
                            <div class="fs-10 mb-2">사용 예정일(체크인 날짜) 7일 전 예약을 취소하면 무료 취소가 가능합니다.</div>
                            <div class="row mb-2 ps-4">
                                <ul class="fs-10 ps-4 mb-0">
                                    <li>사용 예정일(체크인 날짜) 6일 전의 예약 취소는 업체에게 취소 요청할 수 있습니다.</li>
                                    <li>체크인 이후의 예약 취소 및 예약금 환불은 불가능합니다.</li>
                                    <li>숙박 도중 예약 취소를 원하신다면, 업체에게 문제 해결을 요청할 수 있습니다.</li>
                                    <li>자세한 사항은 해당 업체 전화번호 또는 이메일에 문의할 수 있습니다.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    --%>
                </div>
                <%-- left 끝 --%>

                <div class="right-container">
                    <div class="fs-4 mb-3">숙소</div>
                    <div class="mb-3">
                        <div class="rsv acm-menu box-border p-4">
                            <div class="row mb-2">
                                <div class="d-flex gap-2 pb-2 lh-sm text-start">
                                    <img class="acm-img-thumbnail radius_12"
                                         src="https://a0.muscache.com/im/pictures/0f52b46a-16fe-472f-a04b-eec52680f162.jpg?aki_policy=large"
                                         alt="">
                                    <div class="w-100 ms-1">
                                        <strong class="d-block">${roomDetail['accommodationName']}</strong><%--E°SO 이소하우스 60평 독채--%>
                                        <p class="mb-2">${roomDetail.categoryName}</p><%--펜션--%>
                                        <p class="fs-10 mb-2">${roomDetail.accommodationAddress}</p><%--강원도 강릉시 창해로 307--%>
                                        <div class="fs-10 float-start me-2">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor"
                                                 class="mb-1 bi bi-star-fill" viewBox="0 0 16 16">
                                                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                            </svg>
                                            4.93(114)
                                        </div>
                                        <div class="fs-10 fw-bold">•<span class="ms-1">${roomDetail.keywordName}</span></div><%--해변(키워드명)--%>
                                    </div>
                                </div>
                            </div>

                            <hr>

                            <div class="fs-5">요금 세부정보</div>
                            <%-- <li>₩544,500 x 5박 ₩2,722,500</li> --%>
                            <div class="row py-1 lh-sm fs-10 pe-2">
<%--                                <div class="col-sm-8 text-start"><span>₩${roomDetail.roomPrice}</span> x <span>${countDay}</span>박</div>--%>
                                <div class="col-sm-8 text-start">1박당 요금(세금 및 봉사료 포함)</div>
                                <div class="col-sm-4 text-end">₩<fmt:formatNumber type="number"
                                                      maxFractionDigits="0"
                                                      value="${roomDetail.roomPrice}" /></div>
                            </div>

                            <div class="row py-1 lh-sm fs-10 pe-2">
                                <div class="col-sm-8 text-start">
                                    <button id="rsrvCommBtn" class="btn-none text-decoration-underline text-dark px-0">포인트 적립</button>
                                </div>
                                <div class="col-sm-4 text-end">
                                    <fmt:formatNumber type="number"
                                     maxFractionDigits="0"
                                     value="${roomDetail.roomPrice*0.01}" /></div>
                                <%--
                                <fmt:formatNumber type="number"
                                    maxFractionDigits="0"
                                    value="${roomDetail.roomPrice - (roomDetail.roomPrice * product.roomDiscount / 100)}" />
                                --%>
                            </div>
                            <div>
                                <%-- <hr class="dropdown-divider"> --%>
                                <hr>
                            </div>
                            <div  class="row py-1 lh-sm pe-2">
                                <div class="col-sm-8 text-start">총액 <span class="fw-bold">(KRW)</span>
                                </div>
                                <div class="col-sm-4 text-end"><span class="fw-bold">₩<fmt:formatNumber type="number"
                                                                                                        maxFractionDigits="0"
                                                                                                        value="${roomDetail.roomPrice*countDay}" /></span></div>
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

                    <%-- <div class="rsrv-btn-div"> --%>
                    <div class="rsrv-btn-div">
                        <button class="btn btn-primary btn-pink p-3" id="rsrvBtn">예약 신청 및 결제</button>
                    </div>
                </div>
                <%-- right 끝 --%>
            </div>
<%--        </form>--%>
        </div>
    </div>
</div>
</body>
</html>