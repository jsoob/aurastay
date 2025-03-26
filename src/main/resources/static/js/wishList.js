$(document).ready(function () {
    $(".wish-btn").click(function () {

        let wishBtn = $(this);
        let svgIcon = wishBtn.children("svg");
        let accommodationNo = wishBtn.closest(".card").attr("data-accommodation-no");
        let memberNo = $("#memberNo").val();

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
                    alert("삭제에 실패했습니다.");
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
                    alert("추가에 실패했습니다.");
                }
            });
        }
    })
})
