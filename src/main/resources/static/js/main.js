$(document).ready(function () {


    // wishlist 배열이 전역에서 사용 가능하도록 확인
    if (typeof wishlist !== "undefined" && Array.isArray(wishlist)) {
        $(".card").each(function () {
            let accommodationNo = $(this).data("accommodation-no"); // 현재 카드의 숙소 번호 가져오기

            if (wishlist.includes(accommodationNo)) {
                $(this).find(".wish-btn-svg").addClass("wish-btn-svg-active"); // 위시리스트에 있으면 active 추가
            }
        });
    }

    $(".wish-btn").click(function () {

        let memberNo = $("#memberNo").val();

        if (!memberNo) {
            // 로그인 필요
            alert("로그인이 필요합니다.");
            location.href = "/login";
            return;
        }

        let wishBtn = $(this);
        let svgIcon = wishBtn.children("svg");
        let accommodationNo = wishBtn.closest(".card").attr("data-accommodation-no");

        // 위시리스트 추가 또는 삭제
        if (svgIcon.hasClass("wish-btn-svg-active")) {
            // 이미 추가된 상태라면 삭제 요청
            $.ajax({
                url: "/wishlist/remove",
                type: "DELETE",
                contentType: "application/json",
                data: JSON.stringify({memberNo: memberNo, accommodationNo: accommodationNo}),
                success: function (response) {
                    alert("위시리스트에서 삭제되었습니다.");
                    svgIcon.removeClass("wish-btn-svg-active");
                },
                error: function () {
                    alert("삭제에 실패했습니다. 다시 시도해주세요.");
                }
            });
        } else {
            // 추가 요청
            $.ajax({
                url: "/wishlist/add",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({memberNo: memberNo, accommodationNo: accommodationNo}),
                success: function (response) {
                    alert("위시리스트에 추가되었습니다.");
                    svgIcon.addClass("wish-btn-svg-active");
                },
                error: function () {
                    alert("추가에 실패했습니다. 다시 시도해주세요.");
                }
            });
        }
    })
})