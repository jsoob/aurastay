// 2025032711 2136548211
const businessNo = '2025032711'; // '2025032711';
// const businessNo = '2136548211';

$(document).ready(function () {
    selectRsList();

    const modal = document.querySelector('#rsAcmModal');
    const modal2 = document.querySelector('#rsRoomModal');

    $("#rsBtn").click(function () {
        selectRsList();
    });

    $("#resetBtn").click(function () {
        // 선택하라고 뜨는 span 비활성화
        document.querySelector('#showRoomSpan .showSpan').classList.remove('on');

        $("#acmNo").val('');
        $("#acmName").val('');

        $("#roomNo").val('');
        $("#roomName").val('');
        selectRsList();
    });

    // 예약 조회 td 선택

    // 예약 조회 td 선택
    $("#rsTable tbody").on('click', 'td', function(e) {
        let trIdx = $(this).closest('tr').index();
        let tdIdx = $(this).closest('td').index();
        // console.log($(this).children());
        // console.log($(this).children().eq(0).text());
        let rsStatus = $(this).closest('tr').find('td:last').attr('rs-s');

        let rsNo = $(this).closest('tr').find('td:first').text();
        let memberName = $(this).closest('tr').find('td').eq(1).text();

        // console.log("rsNo = ", rsNo);
        // console.log("memberName = ", memberName);
        // console.log(trIdx+"행 "+tdIdx + "열");
        // console.log("예약 상태 = " + rsStatus);

    });

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
        // console.log("acmNo = ", acmNo);

        let acmName = $(this).closest('tr').find('td').eq(1).text();
        // console.log("acmName = ", acmName);

        $("#acmNo").val(acmNo);
        $("#acmName").val(acmName);

        $("#roomNo").val('');
        $("#roomName").val('');

        selectRsList();

        //'on' class 제거
        modal.classList.remove('on');
        // 선택하라고 뜨는 span 비활성화
        document.querySelector('#showRoomSpan .showSpan').classList.remove('on');
    });

    // Room
    // 모달 열기
    $("#roomName, #showRoomModal").click(function () {
        let acmNo = $("#acmNo").val();
        // console.log(acmNo);
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
        // console.log("roomNo = ", roomNo);

        let roomName = $(this).closest('tr').find('td').eq(1).text();
        // console.log("roomName = ", roomName);

        $("#roomNo").val(roomNo);
        $("#roomName").val(roomName);

        selectRsList();
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

function selectRsList(cp) {
    let search = $("#rsName").val();
    let currentPage = (cp > 1 ? cp : 1);

    let acmNo = ($("#acmNo").val() !== "" ? $("#acmNo").val() : 0);
    let roomNo = ($("#roomNo").val() !== "" ? $("#roomNo").val() : 0);

    $.ajax({
        url: "/reservation/bRsList",
        type: "get",
        contentType: "application/json",
        data: {
            businessNo: businessNo,
            acmNo: acmNo,
            roomNo: roomNo,
            currentPage: currentPage,  search: search
        },
        success: function (data) {
            console.log(data);

            $("#rsTable #rsBody").empty();
            $("#rsTable #rsFoot td").empty();

            if((data.list).length == 0) {
                $("#rsTable #rsFoot td").append('<span class="tfoot-span">No Data</span>');
            } else {
                data.list.forEach(rsInfo =>

                    $("#rsTable #rsBody")
                        .append(
                            '<tr>' +
                            '<td>' +rsInfo.reservationNo + '</td>' +
                            '<td rs-s="'+rsInfo.memberNo+'" >' +(rsInfo.memberDTO).memberNickname + ' (' + (rsInfo.memberDTO).memberName + ')</td>' +
                            '<td rs-s="'+(rsInfo.acmDTO).acmNo +'" >' +(rsInfo.acmDTO).acmName + '</td>' +
                            '<td rs-s="'+(rsInfo.acmDTO).roomNo +'" >' +(rsInfo.acmDTO).roomName + '</td>' +
                            '<td>' +rsInfo.guestName + '</td>' +
                            '<td>' + rsInfo.checkinDate + ' - ' + rsInfo.checkoutDate + '(' + rsInfo.dayCount + '박)</td>' +
                            '<td rs-s="'+(rsInfo.payment).paymentNo +'" >' +rsInfo.payment.paymentCompletionDate + '</td>' +
                            '<td rs-s="'+rsInfo.reservationStatus+'" >'
                            + (rsInfo.reservationStatus === 0 ? "결제 취소" : (rsInfo.reservationStatus === 1 ? "예약 확정" : "취소 대기" ) ) + '</td>' +
                            '</tr>'
                        )
                );

                let pagination = $('<div class="pagination m-0"></div>');

                if(data.currentPage > 1) {
                    let prevBtn = $("<a class='w-40p' onclick='selectRsList("+(data.currentPage-1)+")'>이전</a>");
                    pagination.append(prevBtn);
                }

                // let span = $('<span class="d-if"></span>');
                for(let i=(data.startPage); i<=(data.endPage); i++ ) {
                    if(i == data.currentPage) {
                        pagination.append("<strong>"+i+"</strong>");
                    } else {
                        pagination.append("<a class='pagination-btn' onclick='selectRsList("+i+")'>"+i+"</a>");
                    }
                }

                if(data.hasNext) {
                    let nextBtn = $("<a class='w-40p' onclick='selectRsList("+(data.currentPage+1)+")'>다음</a>");
                    pagination.append(nextBtn);
                }
                $("#rsTable #rsFoot td").append(pagination);
            }
        },
        error: function () {
            console.log("조회 실패");
        }
    });
}

function selectAcmList(cp) {
    let search = $("#rsAcmSearchInput").val();
    let currentPage = (cp > 1 ? cp : 1);

    $.ajax({
        url: "/reservation/bAcmList",
        type: "get",
        contentType: "application/json",
        // data: JSON.stringify({businessNo: '2025032711', search: search}),
        // 2025032711 2136548211
        data: {businessNo: businessNo, currentPage: currentPage,  search: search},
        success: function (data) {

            $("#rsAcmModalTable #rsAcmModalBody").empty();
            $("#rsAcmModalTable #rsAcmModalFoot td").empty();

            if(data.list.length == 0) {
                $("#rsAcmModalTable #rsAcmModalFoot td").append('<span class="tfoot-span">No Data</span>');
            } else {
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
            }
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
            $("#rsRoomModalTable #rsRoomModalFoot td").empty();

            if(data.list.length == 0) {
                $("#rsRoomModalTable #rsRoomModalFoot td").append('<span class="tfoot-span">No Data</span>');
            } else {
                data.list.forEach(roomInfo =>
                    $("#rsRoomModalTable #rsRoomModalBody")
                        .append(
                            '<tr>' +
                            '<td>' + roomInfo.roomNo + '</td>' +
                            '<td>' + roomInfo.roomName + '</td>' +
                            '<td>' + roomInfo.roomQty + '</td>' +
                            '<td>' + roomInfo.roomCapacity + '</td>' +
                            '<td>' + roomInfo.roomPrice + '</td>' +
                            '<td>' + roomInfo.roomDiscount + '</td>' +
                            '<td>' + roomInfo.roomViewType + '</td>' +
                            '</tr>'
                        )
                );


                let pagination = $('<div class="pagination m-0"></div>');

                if (data.currentPage > 1) {
                    let prevBtn = $("<a class='w-40p' onclick='selectRoomList(" + (data.currentPage - 1) + ")'>이전</a>");
                    pagination.append(prevBtn);
                }
                for (let i = (data.startPage); i <= (data.endPage); i++) {
                    if (i == data.currentPage) {
                        pagination.append("<strong>" + i + "</strong>");
                    } else {
                        pagination.append("<a class='pagination-btn' onclick='selectRoomList(" + i + ")'>" + i + "</a>");
                    }
                }
                if (data.hasNext) {
                    let nextBtn = $("<a class='w-40p' onclick='selectRoomList(" + (data.currentPage + 1) + ")'>다음</a>");
                    pagination.append(nextBtn);
                }
                $("#rsRoomModalTable #rsRoomModalFoot td").append(pagination);
            }
        },
        error: function () {
            console.log("조회 실패");
        }
    });
}