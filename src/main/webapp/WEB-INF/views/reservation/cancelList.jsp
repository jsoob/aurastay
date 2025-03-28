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
    <link rel="stylesheet" href="/css/rsrv/rsrv-cancelModal.css">

    <script src="/js/rsrv/business-rsrv.js"></script>

    <script>

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
                    if(rsStatus == 0) {
                        console.log("예약 취소 상태ggg");
                    } else if(rsStatus == 2) {
                        console.log("예약 취소 요청 상태 gggg");
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
            console.log("조회");
            $.ajax({
                url: "/reservation/getRsCancl",
                type: "get",
                contentType: "application/json",
                data: { reservationNo: rsNo,  },
                success: function (data) {
                    console.log(data);
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


    <div id="rsResetModal" class="modal cancelModal">
        <div class="modal_popup min-w-500 max-w-700 w-50">
            <h3 class="d-fr mt-0">예약 취소 요청 정보
                <span class="cancel"></span>
                <button type="button" class="close_btn float-end">닫기</button>
            </h3>

            <div class="form-group">
                <div class="modal-body my-20">
                    <div class="row mb-3">
                        <div class="col-sm-3">
                            <div class="input-group">
                                <label>예약번호</label>
                                <input type="text" name="rsNo" class="form-control fs-10 bckc-gray" value="" readonly>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <div class="input-group">
                                <label>예약 정보</label>
                                <input type="text" name="rsInfoText" class="form-control fs-10 bckc-gray" value="${rsrv['acmDTO'].acmName} - ${rsrv['acmDTO'].roomName} (${rsrv.dayCount}박)" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="input-group">
                        <label>취소 사유</label>
                        <div>
                            <textarea id="cancelReasons" name="cancelReasons" class="py-2 box-border bckc-gray" disabled rows="3" required></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

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
