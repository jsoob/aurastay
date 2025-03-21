$(document).ready(() => {
    // 입력값이 변경될 때 오류 메시지 자동 제거
    $("input").on("input", function () {
        $(".text-danger").text("");
    });

    // 존재하는 이메일인지 확인 필요
    $("#loginBtn").on("click", function () {
        let email = $("#memberEmail").val().trim();

        if (email === "") {
            alert("이메일을 입력해주세요.");
        } else if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email)) {
            alert("올바른 이메일 형식을 입력하세요.")
        } else {
            $.ajax({
                type: "post",
                url: "/checkEmail",
                data: {email: email},
                success: function (response) {
                    if (!response.exists) {
                        alert("존재하지않는 이메일입니다.")
                    }
                },
                error: function () {
                    alert("이메일 확인 중 오류가 발생했습니다.");
                }
            })
        }
    })


})