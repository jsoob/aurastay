$(document).ready(() => {

    let authCode = ""; // 인증번호 저장 변수
    let isEmailValid = false; // 이메일 중복 확인 여부
    let isEmailVerified = false;  // 이메일 인증 여부
    let isBusinessNoValid = false; // 사업자번호 중복 확인 여부

    let emailModal = new bootstrap.Modal(document.getElementById("emailVerificationModal"));

    // 이메일 중복 확인 버튼 클릭 이벤트
    $("#checkEmailBtn").on("click", function () {
        let email = $("#email").val().trim();
        $("#emailError").text(""); // 기존 에러 메시지 제거

        if (email === "") {
            $("#emailError").text("이메일을 입력해주세요.")
        } else if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email)) {
            $("#emailError").text("올바른 이메일 형식을 입력하세요.")
        } else {
            // 중복확인
            $.ajax({
                type: "post",
                url: "/checkEmail",
                data: {email: email},
                success: function (response) {
                    if (response.exists) {
                        $("#emailError").text("이미 가입된 이메일입니다.");
                        isEmailValid = false;
                    } else {
                        isEmailValid = true;
                        emailModal.show(); // Modal 열기
                    }
                },
                error: function () {
                    $("#emailError").text("이메일 확인 중 오류가 발생했습니다.");
                }
            })
        }
    })

    // 인증코드 받기
    $("#sendEmailCodeBtn").on("click", () => {
        let email = $("#email").val().trim();

        $.ajax({
            type: "post",
            url: "/sendEmail/emailCode",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({email: email}),
            success: function (response) {
                console.log(response);
                authCode = response.code;
            },
            error: function () {
                $("#emailCodeError").text("이메일 확인 중 오류가 발생했습니다.");
            }
        })
    })
    // 인증 버튼 누르면
    $("#verifyEmailCodeBtn").on("click", () => {
        let inputCode = $("#emailCode").val().trim();

        console.log("inputCode : " + inputCode);
        console.log("authCode : " + authCode);

        if (!inputCode) {
            $("#emailCodeError").text("인증번호를 입력해주세요.");
            return;
        }

        // 받아온 인증코드와 일치하는지 확인 후
        if (inputCode == authCode) {
            isEmailVerified = true;
            emailModal.hide();
            $("#checkEmailBtn").prop("disabled", true);
            $("#emailError").text("인증완료된 이메일입니다.");
            $("#email").prop("readonly", true)

        } else {
            $("#emailCodeError").text("인증번호가 올바르지 않습니다. 다시 입력해주세요.");
            isEmailVerified = false;
        }
    })

    // 사업자번호 중복 확인
    $("#checkBusinessNoBtn").on("click", function () {
        let businessNo = $("#businessNo").val().trim();
        $("#businessNoError").text(""); // 기존 에러 메시지 제거

        // 사업자번호는 숫자만 입력 가능
        if (!/^\d{10}$/.test(businessNo)) {
            $("#businessNoError").text("사업자번호는 10자리 숫자로 입력해야 합니다.");
        } else {
            // 중복확인
            $.ajax({
                type: "post",
                url: "/checkBusinessNo",
                data: {businessNo: businessNo},
                success: function (response) {
                    if (response.exists) {
                        $("#businessNoError").text("이미 가입된 사업자번호입니다. 고객센터로 문의해주세요.");
                        isBusinessNoValid = false;
                    } else {
                        $("#businessNoError").text("사용 가능한 사업자번호입니다.");
                        isBusinessNoValid = true;
                    }
                },
                error: function () {
                    $("#emailError").text("사업자번호 확인 중 오류가 발생했습니다.");
                }
            })
        }
    })

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
        let businessName = $("#businessName").val().trim();
        let representativeName = $("#representativeName").val().trim();

        // 기존 에러 메시지 초기화 (이메일 인증 메시지는 제외)
        $(".text-danger").not("#emailError").text("");

        // 회원가입 버튼 클릭시 이메일 인증 여부 확인
        if (!isEmailValid) {
            event.preventDefault();
            $("#emailError").text("이메일 중복 확인 후 진행해주세요.");
        }

        if (!isEmailVerified) {
            event.preventDefault();
            $("#emailError").text("이메일 인증 후 진행해주세요.");
        }

        // 회원가입 버튼 클릭시 사업자번호 중복 여부 확인
        if (!isBusinessNoValid) {
            event.preventDefault();
            $("#businessNoError").text("사업자번호 중복 확인 후 진행해주세요.");
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


        // 전화번호 숫자만 입력 가능
        if (!/^\d{2,3}$/.test(phone1) || !/^\d{3,4}$/.test(phone2) || !/^\d{4}$/.test(phone3)) {
            $("#phoneError").text("올바른 전화번호 형식을 입력하세요.");
            isValid = false;
        }

        // 계좌번호는 10~14자리
        if (!/^\d{10,14}$/.test(businessAccount)) {
            $("#businessAccountError").text("계좌번호는 10~14자리 숫자로 입력해야 합니다.");
            isValid = false;
        }

        // 상호명
        if (businessName === "") {
            $("#businessNameError").text("상호명을 입력해주세요.");
            isValid = false;
        }
        // 대표자명
        if (representativeName === "") {
            $("#representativeNameError").text("대표자명을 입력해주세요.");
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

    // 전화번호 입력 시 오류 메시지 제거 (공통 적용)
    $("#phone1, #phone2, #phone3").on("input", function () {
        $("#phoneError").text("");  // 전화번호 입력 시 특정 오류 메시지만 초기화
    });

})