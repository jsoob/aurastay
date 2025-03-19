$(document).ready(() => {

    // 전송 전에 유효성 검사
    $("#signUpForm").on("submit", (event) => {
        let isValid = true;

        let email = $("#email").val().trim();
        let password = $("#password").val().trim();
        let confirmPassword = $("#confirmPassword").val().trim();
        let businessNo = $("#businessNo").val().trim();
        let phone1 = $("#phone1").val().trim();
        let phone2 = $("#phone2").val().trim();
        let phone3 = $("#phone3").val().trim();
        let businessAccount = $("#businessAccount").val().trim();
        let nickname = $("#nickname").val().trim();
        let name = $("#name").val().trim();

        // 기존 에러 메시지 초기화
        $(".text-danger").text("");

        if (email === "") {
            $("#emailError").text("이메일을 입력해주세요.")
            isValid = false;
        } else if (!/^\S+@\S+\.\S+$/.test(email)) {
            $("#emailError").text("올바른 이메일 형식을 입력하세요.")
            isValid = false;
        }

        // 비밀번호 유효성 검사
        // 특수기호나 숫자를 1자 이상 포함하고 최소 8자여야 합니다.
        if (password.length < 8) {
            $("#passwordError").text("비밀번호는 최소 8자 이상이어야 합니다.");
            isValid = false;
        } else if (!/^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*[a-zA-Z])(?=.*\d).*$/.test(password)) {
            $("#passwordError").text("특수기호, 영문자, 숫자를 1자 이상 포함해야 합니다.");
            isValid = false;
        } else if (password !== confirmPassword) {
            $("#passwordError").text("비밀번호가 일치하지 않습니다.")
            isValid = false;
        }

        // 사업자번호는 숫자만 입력 가능
        if (!/^\d{10}$/.test(businessNo)) {
            $("#businessNoError").text("사업자번호는 10자리 숫자로 입력해야 합니다.");
            isValid = false;
        }

        // 전화번호 숫자만 입력 가능
        if (!/^\d{3}$/.test(phone1) || !/^\d{3,4}$/.test(phone2) || !/^\d{4}$/.test(phone3)) {
            $("#phoneError").text("올바른 전화번호 형식을 입력하세요.");
            isValid = false;
        }

        // 계좌번호는 10~14자리
        if (!/^\d{10,14}$/.test(businessAccount)) {
            $("#businessAccountError").text("계좌번호는 10~14자리 숫자로 입력해야 합니다.");
            isValid = false;
        }

        // 상호명
        if (nickname === "") {
            $("#nicknameError").text("상호명을 입력해주세요.");
            isValid = false;
        }
        // 대표자명
        if (name === "") {
            $("#nameError").text("대표자명을 입력해주세요.");
            isValid = false;
        }

        if (!isValid) {
            event.preventDefault(); // 폼 전송 방지
        }

    });

    // 숫자 입력 필드에서 문자 입력 방지
    $("#businessNo, #phone1, #phone2, #phone3, #businessAccount").on("input", function () {
        this.value = this.value.replace(/[^0-9]/g, "");
    });

    // 입력값이 변경될 때 오류 메시지 자동 제거
    $("input").on("input", function () {
        $(this).next(".text-danger").text("");
    });

})