<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>예약 목록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- acmList.CSS 파일 연결 -->
    <link rel="stylesheet" type="text/css" href="../css/acmList.css">

    <link rel="stylesheet" href="/css/rsrv/rsrv.css">
    <link rel="stylesheet" href="/css/rsrv/business-rsrv.css">

    <script
            src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"
    ></script>

    <script src="/js/rsrv/business-rsrv.js"></script>

    <script>
        let rsCancelInfo;

        $(document).ready(function () {
            const cancelModal = document.querySelector('#rsResetModal');

            // 예약 조회 td 선택
            $("#rsTable tbody").on('click', 'td', function(e) {
                let trIdx = $(this).closest('tr').index();
                let tdIdx = $(this).closest('td').index();

                let rsNo = $(this).closest('tr').find('td:first').text();
                let rsStatus = $(this).closest('tr').find('td:last').attr('rs-s');
                let memberNo = $(this).closest('tr').find('td').eq(1).attr('rs-s');

                // 예약 상태
                if(tdIdx == 7 && rsStatus != 1) {
                    selectRsCancel(rsNo, memberNo);
                    /*if(rsStatus == 0) {
                        console.log("예약 취소 상태ggg");
                    } else */
                    $("#rsResetModal .modal-footer").empty();
                    if(rsStatus == 2) {
                        $("#rsResetModal .modal-footer").append(
                            '<div class="row">' +
                                '<div class="col-sm-12 text-center py-2">' +
                                    '<input type="button" onclick="cancelRs(\'Y\')" class="cancelBtn me-2 btn-pink" value="예약 취소 승인">' +
                                    '<input type="button" onclick="cancelRs(\'N\')" class="cancelBtn" value="예약 취소 거절">' +
                                '</div>' +
                            '</div>'

                        );
                    }
                    cancelModal.classList.add('on'); // 모달 오픈
                }
            });

            //닫기 버튼을 눌렀을 때 모달팝업이 닫힘
            $(".close_btn").click(function () {
                //'on' class 제거
                cancelModal.classList.remove('on');
            });
            // 모달 영역 말고 다른 부분 선택시 팝업 닫기
            $(window).click(function (event) {
                if ($(event.target).is("#rsResetModal")) {
                    cancelModal.classList.remove('on');
                }
            });
        });

        function selectRsCancel(rsNo, memberNo) {
            if(rsNo === undefined || memberNo === undefined) {
                return;
            }
            $.ajax({
                url: "/reservation/getRsCancel",
                type: "get",
                contentType: "application/json",
                data: { reservationNo: rsNo, memberNo : memberNo },
                success: function (data) {
                    rsCancelInfo = data.rsCancelInfo;

                    $("#rsResetModal input[name=rsNo]").val(rsCancelInfo.reservationNo);
                    $("#rsResetModal textarea[name=cancelReasons]").text((rsCancelInfo.rsCancel).cancelReasons);

                    $("#rsResetModal input[name=rsInfoText]").val((rsCancelInfo.acmDTO).acmName + " - " + (rsCancelInfo.acmDTO).roomName + "(" + rsCancelInfo.dayCount + "박)");

                    $("#rsResetModal input[name=cancelDate]").val( (rsCancelInfo.rsCancel).cancelDate);
                    $("#rsResetModal input[name=cancelRespDate]").val( (rsCancelInfo.rsCancel).cancelRespDate || '' );

                    let rsStatus =  (rsCancelInfo.rsCancel).cancelStatus;
                    $("#rsResetModal input[name=cancelStatus]").val( (rsStatus === 0 ? "결제 취소" : (rsStatus === 1 ? "예약 확정" : "취소 대기" ) ));

                },
                error: function () {
                    console.log("조회 실패");
                }
            });
        }

        function cancelRs(yn) {
            if(yn == "Y") {
                cancelPay();
            }
            $.ajax({
                url: "/reservation/cancelRs",
                type: "get",
                contentType: "application/json",
                data: {
                    rsNo : (rsCancelInfo).reservationNo,
                    cancelStatus : (yn == "Y" ? 0 : 1 ),
                    paymentNo : (rsCancelInfo.payment).paymentNo
                },
                success: function (data) {
                    selectRsList();
                    document.querySelector('#rsResetModal').classList.remove('on');
                },
                error: function () {
                    console.log("조회 실패");
                }
            });
        }

        function cancelPay() {
            $.ajax({
                url: "/reservation/cancelRsPay",
                type: "get",
                contentType: "application/json",
                data: {
                    impUid : "1-74691", // (rsCancelInfo.payment).paymentId,
                    // merchantUid : "productId",
                    amount : "500000", // (rsCancelInfo.rsCancel).paymentPrice,
                    reason : "결제취소할래요...싫음." // (rsCancelInfo.rsCancel).cancelReasons
                },
                success: function (data) {
                },
                error: function () {
                    console.log("조회 실패");
                }
            });
        }
    </script>
</head>
<body id="addListPage" class="addList">

<jsp:include page="../comm/header.jsp"/>
<jsp:include page="../comm/sidebar.jsp"/>

<div class="main-content">
    <h2 class="text-center">📌 예약 목록 📌 </h2>

    <div class="search-container jc-s">
        <div class="me-2">
            <input type="hidden" id="acmNo" name="acmNo">
            <input type="text" id="acmName" name="acmName" placeholder="숙소 조회" readonly onfocus="this.blur()" class="w-250p bckc-gray to-e">
<%--            <button id="showAcmModal" type="button" class="btn btn-add-room modal_btn">숙소 조회</button>--%>
        </div>

        <div class="me-2">
            <input type="hidden" id="roomNo" name="roomNo">
            <input type="text" id="roomName" name="roomName" placeholder="객실 조회" readonly onfocus="this.blur()" class="w-200p bckc-gray to-e">
<%--            <button id="showRoomModal" type="button" class="btn btn-add-room modal_btn">객실 조회</button>--%>
            <div id="showRoomSpan" class="text-end"><span class="showSpan text-red">객실을 먼저 선택해 주세요.</span></div>
        </div>

        <div class="me-2">
            <button id="resetBtn" type="button" class="btn reset_btn">숙소 초기화</button>
        </div>

        <div class="me-2" style="margin-left: auto;">
            <input type="text" id="rsName" name="rsName" placeholder="숙소 또는 객실명" oninput="selectRsList()" class="w-200p to-e">
            <button id="rsBtn" type="button" class="btn btn-add-room modal_btn">예약 조회</button>
        </div>
    </div>

    <div class="form-group">
        <table id="rsTable" class="table table-striped table-hover">
            <thead id="rsHead">
                <tr>
                    <th>예약번호</th>
                    <th>예약자</th>
                    <th>숙소이름</th>
                    <th>객실이름</th>
                    <th>투숙객 정보</th>
                    <th>CHECK IN-OUT</th>
                    <th>예약일</th>
                    <th>예약상태</th>
                </tr>
            </thead>
            <tbody id="rsBody">

            </tbody>

            <tfoot id="rsFoot">
                <tr>
                    <td class="p-0" colspan="8"></td>
                </tr>
            </tfoot>
        </table>
    </div>


    <jsp:include page="bsRsCancelModal.jsp" />

    <div id="rsAcmModal" class="modal">
        <div class="modal_popup min-w-500 max-w-700 w-50 modal-scroll">
            <h3 class="d-fr mt-0">숙소 정보<button type="button" class="close_btn float-end">닫기</button></h3>

            <div class="search-container">
                <input type="text" id="rsAcmSearchInput" name="search" placeholder="숙소명 또는 전화번호 검색" oninput="selectAcmList()">
            </div>

            <div class="form-group">
                <table id="rsAcmModalTable" class="table table-striped table-hover">
                    <thead id="rsAcmModalHead">
                        <tr>
                            <th>숙소번호</th>
                            <th>숙소이름</th>
                            <th>주소</th>
                            <th>연락처</th>
                            <th>체크인</th>
                            <th>체크아웃</th>
                        </tr>
                    </thead>

                    <tbody id="rsAcmModalBody">

                    </tbody>

                    <tfoot id="rsAcmModalFoot">
                    <tr>
                        <td class="p-0" colspan="6"></td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <div id="rsRoomModal" class="modal">
        <div class="modal_popup min-w-500 max-w-700 w-50 modal-scroll">
            <h3 class="d-fr mt-0">객실 정보<button type="button" class="close_btn float-end">닫기</button></h3>

            <div class="search-container">
                <input type="text" id="rsRoomSearchInput" name="search" placeholder="객실명 검색" oninput="selectRoomList()">
            </div>

            <div class="form-group">
                <table id="rsRoomModalTable" class="table table-striped table-hover">
                    <thead id="rsRoomModalHead">
                        <tr>
                            <th>객실번호</th>
                            <th>객실이름</th>
                            <th>객실 수량</th>
                            <th>최대 인원 수</th>
                            <th>가격</th>
                            <th>할인율</th>
                            <th>뷰타입</th>
                        </tr>
                    </thead>

                    <tbody id="rsRoomModalBody">

                    </tbody>

                    <tfoot id="rsRoomModalFoot">
                    <tr>
                        <td class="p-0" colspan="7"></td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <jsp:include page="../comm/footer.jsp"/>
</div>

</body>
</html>
