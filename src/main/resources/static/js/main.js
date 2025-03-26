$(function () {
    $(".wish-btn").click(function () {

        let memberNo = $("#memberNo").val();

        if (!memberNo) {
            // 로그인 필요
            alert("로그인이 필요합니다.");
            location.href = "/login";
        }

        // 로그인한 사용자의 번호memberNo, 하트를 누른 숙소의 번호 accommodation_no 를 가지고 가서 insert해야함
        $.ajax({
            type: "post",
            url: "/wishlist/add",
            contentType: "application/json",  // JSON 요청임을 명시
            data: JSON.stringify({accommodationNo: accommodationNo, memberNo: memberNo}), // 테스트용

            success: function (data) {
                console.log(data);
                alert("즐겨찾기 완료되었습니다.");
            },
            error: function (xhr) {
                console.log(xhr);
                alert("다시 시도해주세요.");
            }

        })

    });
});
