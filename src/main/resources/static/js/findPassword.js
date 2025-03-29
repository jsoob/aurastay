$(() => {

    let authCode = ""; // 인증번호 저장 변수

    // 이메일 발송 버튼 누르면
    // input박스의 내용인 email로 이메일 발송되게 함
    $("#btnSend").on("click", async () => {

        let email = $("#email").val().trim();

        if (!email) {
            alert("이메일을 입력해주세요.");
            return;
        } else if (!validateEmail(email)) {
            alert("올바른 이메일 형식을 입력하세요.")
            return;
        }
        // 가입된 이메일인지 확인 (비동기 처리)
        let emailExists = await ExistEmail(email);

        if (!emailExists) {
            alert("존재하지 않는 이메일입니다.");
            return;
        }

        $("#btnSend").text("인증메일 재발송");

        $(".codeDiv").html(`
            <input type="text" id="codeInput" name="code" class="form-control" placeholder="인증번호 입력">
            <button id="codeBtn" class="btn btn-outline-danger">인증</button>
        `);


        $.ajax({
            type: "post",
            url: "/sendEmail/findPassword",
            dataType: "json",
            contentType: "application/json",  // JSON 요청임을 명시
            data: JSON.stringify({email: email}), // JSON 문자열로 변환하여 전송

            success: function (data) {
                console.log(data);
                authCode = data.code; // 인증번호 저장
            },
            error: function (xhr) {
                alert("이메일 전송 실패하였습니다. 다시 시도해주세요.");
            }
        });

    })

    // 인증버튼 누르면
    $(document).on("click", "#codeBtn", function () {
        // 입력한 인증코드
        let inputCode = $("#codeInput").val().trim();

        if (!inputCode) {
            alert("인증번호를 입력해주세요.");
            return;
        }

        // 받아온 인증코드와 일치하는지 확인 후
        if (inputCode === authCode) {

            $.ajax({
                type: "post",
                url: "/storeEmailSession",
                data: JSON.stringify({email: $("#email").val()}),
                contentType: "application/json",
                success: function () {
                    alert("인증 성공! 비밀번호 변경 페이지로 이동합니다.");
                    window.location.href = "/resetPassword";
                },
                error: function () {
                    alert("세션 저장 실패. 다시 시도해주세요.");
                }
            });
        } else {
            alert("인증번호가 올바르지 않습니다. 다시 입력해주세요.");
        }
    })
})

// 이메일 형식 검증 함수
function validateEmail(email) {
    let emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return emailRegex.test(email);
}

// 존재하는 이메일인지 확인하는 함수 (Promise 반환)
function ExistEmail(email) {
    return new Promise((resolve) => {
        $.ajax({
            type: "post",
            url: "/findPassword/checkEmail",
            data: {email: email},
            success: function (response) {
                resolve(response.exists);
            },
            error: function () {
                alert("이메일 확인 중 오류가 발생했습니다.");
                resolve(false);
            }
        });
    });
}