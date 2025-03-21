$(document).ready(()=>{
    $("#resetPasswordForm").on("submit",(event)=>{

        let isValid = true;

        let password = $("#password").val().trim();
        let confirmPassword = $("#confirmPassword").val().trim();

        // 기존 에러 메세지 초기화
        $("#passwordError").text("");

        // 비밀번호 유효성 검사
        // 특수기호나 숫자를 1자 이상 포함하고 최소 8자여야 합니다.
        if (password.length < 8) {
            $("#passwordError").text("비밀번호는 최소 8자 이상이어야 합니다.");
            isValid = false;
        } else if (!/^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*[a-zA-Z])(?=.*\d).*$/.test(password)) {
            $("#passwordError").text("특수기호, 영문자, 숫자를 1자 이상 포함해야 합니다.");
            isValid = false;
        } else if (password !== confirmPassword) {
            $("#passwordError").text("비밀번호가 일치하지 않습니다.");
            isValid = false;
        }

        // 입력값이 변경될 때 오류 메시지 자동 제거
        $("input").on("input", function () {
            $(this).next(".text-danger").text("");
        });

        if (!isValid) {
            event.preventDefault(); // 폼 전송 방지
        }

    })
})