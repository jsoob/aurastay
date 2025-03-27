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

    <script>

        $(document).ready(function () {
            const modal = document.querySelector('#rsAcmModal');
            const modal2 = document.querySelector('#rsRoomModal');

            // Acm
            // 모달 열기
            $("#acmName, #showAcmModal").click(function () {
                selectAcmList();
                modal.classList.add('on'); // 모달 오픈
            });
            $("#rsAcmModalTable tbody").on('click', 'td', function() {
                // console.log($(this).children());
                // console.log($(this).children().eq(0).text());

                let acmNo = $(this).closest('tr').find('td:first').text();
                console.log("acmNo = ", acmNo);

                let acmName = $(this).closest('tr').find('td').eq(1).text();
                console.log("acmName = ", acmName);

                $("#acmNo").val(acmNo);
                $("#acmName").val(acmName);

                //'on' class 제거
                modal.classList.remove('on');
                // 선택하라고 뜨는 span 비활성화
                document.querySelector('#showRoomSpan .showSpan').classList.remove('on');
            });

            // Room
            // 모달 열기
            $("#roomName, #showRoomModal").click(function () {
                let acmNo = $("#acmNo").val();
                console.log(acmNo);
                if( acmNo == "" ) {
                    document.querySelector('#showRoomSpan .showSpan').classList.add('on');
                    return;
                }
                selectRoomList();
                modal2.classList.add('on'); // 모달 오픈
            });
            $("#rsRoomModalTable tbody").on('click', 'td', function() {
                // console.log($(this).children());
                // console.log($(this).children().eq(0).text());

                let roomNo = $(this).closest('tr').find('td:first').text();
                console.log("roomNo = ", roomNo);

                let roomName = $(this).closest('tr').find('td').eq(1).text();
                console.log("roomName = ", roomName);

                $("#roomNo").val(roomNo);
                $("#roomName").val(roomName);

                //'on' class 제거
                modal2.classList.remove('on');
            });


            //닫기 버튼을 눌렀을 때 모달팝업이 닫힘
            $(".close_btn").click(function () {
                //'on' class 제거
                modal.classList.remove('on');
                modal2.classList.remove('on');
            });
            // 모달 영역 말고 다른 부분 선택시 팝업 닫기
            $(window).click(function (event) {
                if ($(event.target).is("#rsAcmModal")) {
                    modal.classList.remove('on');
                } else if ($(event.target).is("#rsRoomModal")) {
                    modal2.classList.remove('on');
                }
            });
        });

        function selectAcmList(cp) {
            let search = $("#rsAcmSearchInput").val();
            let currentPage = (cp > 1 ? cp : 1);

            $.ajax({
                url: "/reservation/bAcmList",
                type: "get",
                contentType: "application/json",
                // data: JSON.stringify({businessNo: '2025032711', search: search}),
                // 2025032711 2136548211
                data: {businessNo: '2025032711', currentPage: currentPage,  search: search},
                success: function (data) {
                    console.log(data);

                    $("#rsAcmModalTable #rsAcmModalBody").empty();

                    data.list.forEach(acmInfo =>
                        $("#rsAcmModalTable #rsAcmModalBody")
                            .append(
                                '<tr>' +
                                '<td>' +acmInfo.acmNo + '</td>' +
                                '<td>' +acmInfo.acmName + '</td>' +
                                '<td>' +acmInfo.acmAddress + '</td>' +
                                '<td>' + (acmInfo.acmTel).replace(/[^0-9]/g, "")
                                    .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`) + '</td>' +
                                '<td>' +acmInfo.checkinTime + '</td>' +
                                '<td>' +acmInfo.checkoutTime + '</td>' +
                                '</tr>'
                            )
                    );
                    $("#rsAcmModalTable #rsAcmModalFoot td").empty();

                    let pagination = $('<div class="pagination m-0"></div>');

                    if(data.currentPage > 1) {
                        let prevBtn = $("<a class='w-40p' onclick='selectAcmList("+(data.currentPage-1)+")'>이전</a>");
                        pagination.append(prevBtn);
                    }

                    // let span = $('<span class="d-if"></span>');
                    for(let i=(data.startPage); i<=(data.endPage); i++ ) {
                        if(i == data.currentPage) {
                            pagination.append("<strong>"+i+"</strong>");
                        } else {
                            pagination.append("<a class='pagination-btn' onclick='selectAcmList("+i+")'>"+i+"</a>");
                        }
                    }

                    if(data.hasNext) {
                        let nextBtn = $("<a class='w-40p' onclick='selectAcmList("+(data.currentPage+1)+")'>다음</a>");
                        pagination.append(nextBtn);
                    }
                    $("#rsAcmModalTable #rsAcmModalFoot td").append(pagination);
                },
                error: function () {
                    console.log("조회 실패");
                }
            });
        }

        function selectRoomList(cp) {
            let search = $("#rsRoomSearchInput").val();
            let currentPage = (cp > 1 ? cp : 1);

            $.ajax({
                url: "/reservation/bRoomList",
                type: "get",
                contentType: "application/json",
                data: {acmNo: $("#acmNo").val(), currentPage: currentPage,  search: search},
                success: function (data) {
                    console.log(data);

                    $("#rsRoomModalTable #rsRoomModalBody").empty();
                    data.list.forEach(roomInfo =>
                        $("#rsRoomModalTable #rsRoomModalBody")
                            .append(
                                '<tr>' +
                                    '<td>' +roomInfo.roomNo + '</td>' +
                                    '<td>' +roomInfo.roomName + '</td>' +
                                    '<td>' +roomInfo.roomQty + '</td>' +
                                    '<td>' +roomInfo.roomCapacity + '</td>' +
                                    '<td>' +roomInfo.roomPrice + '</td>' +
                                    '<td>' +roomInfo.roomDiscount + '</td>' +
                                    '<td>' +roomInfo.roomViewType + '</td>' +
                                '</tr>'
                            )
                    );

                    $("#rsRoomModalTable #rsRoomModalFoot td").empty();

                    let pagination = $('<div class="pagination m-0"></div>');

                    if(data.currentPage > 1) {
                        let prevBtn = $("<a class='w-40p' onclick='selectRoomList("+(data.currentPage-1)+")'>이전</a>");
                        pagination.append(prevBtn);
                    }
                    for(let i=(data.startPage); i<=(data.endPage); i++ ) {
                        if(i == data.currentPage) {
                            pagination.append("<strong>"+i+"</strong>");
                        } else {
                            pagination.append("<a class='pagination-btn' onclick='selectRoomList("+i+")'>"+i+"</a>");
                        }
                    }
                    if(data.hasNext) {
                        let nextBtn = $("<a class='w-40p' onclick='selectRoomList("+(data.currentPage+1)+")'>다음</a>");
                        pagination.append(nextBtn);
                    }
                    $("#rsRoomModalTable #rsRoomModalFoot td").append(pagination);
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
            <input type="text" id="acmName" name="acmName" placeholder="숙소명" readonly onfocus="this.blur()" class="w-250p bckc-gray to-e">
            <button id="showAcmModal" type="button" class="btn btn-add-room modal_btn">숙소 조회</button>
        </div>

        <div class="me-2">
            <input type="hidden" id="roomNo" name="roomNo">
            <input type="text" id="roomName" name="roomName" placeholder="객실명" readonly onfocus="this.blur()" class="w-200p bckc-gray to-e">
            <button id="showRoomModal" type="button" class="btn btn-add-room modal_btn">객실 조회</button>
            <div id="showRoomSpan" class="text-end"><span class="showSpan text-red">객실을 먼저 선택해 주세요.</span></div>
        </div>

        <div class="me-2" style="margin-left: auto;">
            <input type="text" id="rsName" name="rsName" placeholder="예약명" class="w-200p to-e">
            <button id="rsBtn" type="button" class="btn btn-add-room modal_btn">예약 조회</button>
        </div>
    </div>

    <div id="rsAcmModal" class="modal">
        <div class="modal_popup min-w-500 max-w-700 w-50 modal-scroll">
            <h3 class="d-fr">숙소 정보<button type="button" class="close_btn float-end">닫기</button></h3>

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
                        <td colspan="6"></td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <div id="rsRoomModal" class="modal">
        <div class="modal_popup min-w-500 max-w-700 w-50 modal-scroll">
            <h3 class="d-fr">객실 정보<button type="button" class="close_btn float-end">닫기</button></h3>

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
                        <td colspan="7"></td>
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
