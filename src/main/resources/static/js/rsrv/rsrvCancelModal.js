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
    // console.log("조회");
    $.ajax({
        url: "/reservation/getRsCancel",
        type: "get",
        contentType: "application/json",
        data: { reservationNo: rsNo, memberNo : memberNo },
        success: function (data) {
            // window 전역객체 사용
            window.rsCancelInfo = data.rsCancelInfo;
            console.log(rsCancelInfo);

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