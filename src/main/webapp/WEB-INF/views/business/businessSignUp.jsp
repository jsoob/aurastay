<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

    <script>
        $(document).ready(() => {

            let authCode = ""; // 인증번호 저장 변수
            let isEmailValid = false; // 이메일 중복 확인 여부
            let isEmailVerified  = false;  // 이메일 인증 여부

            let emailModal = new bootstrap.Modal(document.getElementById("emailVerificationModal"));

            // 이메일 중복 확인 버튼 클릭 이벤트
            $("#checkEmailBtn").on("click",function (){
                let email = $("#email").val().trim();
                $("#emailError").text(""); // 기존 에러 메시지 제거

                if (email === "") {
                    $("#emailError").text("이메일을 입력해주세요.")
                } else if (!/^\S+@\S+\.\S+$/.test(email)) {
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
            $("#sendEmailCodeBtn").on("click",()=>{
                let email = $("#email").val().trim();

                $.ajax({
                    type:"post",
                    url: "/sendEmail/emailCode",
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify({email: email}),
                    success: function (response){
                        console.log(response);
                        authCode = response.code;
                    },
                    error: function (){
                        $("#emailCodeError").text("이메일 확인 중 오류가 발생했습니다.");
                    }
                })
            })
            // 인증 버튼 누르면
            $("#verifyEmailCodeBtn").on("click",()=>{
                let inputCode = $("#emailCode").val().trim();

                console.log("inputCode : " + inputCode);
                console.log("authCode : " + authCode);

                if(!inputCode) {
                    $("#emailCodeError").text("인증번호를 입력해주세요.");
                    return ;
                }

                // 받아온 인증코드와 일치하는지 확인 후
                if(inputCode == authCode){
                    isEmailVerified = true;
                    emailModal.hide();
                    $("#checkEmailBtn").prop("disabled",true);
                    $("#emailError").text("인증완료된 이메일입니다.");
                    $("#email").prop("readonly", true)

                }  else {
                    $("#emailCodeError").text("인증번호가 올바르지 않습니다. 다시 입력해주세요.");
                    isEmailVerified = false;
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
                if(!isEmailValid){
                    event.preventDefault();
                    $("#emailError").text("이메일 중복 확인 후 진행해주세요.");
                }

                if(!isEmailVerified){
                    event.preventDefault();
                    $("#emailError").text("이메일 인증 후 진행해주세요.");
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
    </script>
    <style>
        .signUpWidth {
            max-width: 400px;
        }
        .emailDiv {
            display: flex;
            justify-content: space-between;
        }
        .emailDiv > input {
            max-width: 290px;
        }
        #checkEmailBtn {
            min-width: 100px;
        }

        #verifyEmailCodeBtn {
            min-width:70px;
        }

        /* 이메일인증 모달 */
        #modalMessage {
            display: flex;
            flex-wrap: nowrap;
            flex-direction: row;
            justify-content: space-between;
            align-content: center;
            align-items: center;
            margin-bottom: 10px;
            margin-left: 5px;
        }

    </style>
</head>
<body class="container mt-5 mb-5">
<h3 class="text-center">비즈니스 회원가입</h3>
<form:form modelAttribute="businessDTO" action="signUp" id="signUpForm" class="mx-auto signUpWidth" method="post">
    <div class="mb-3">
        <label for="email" class="form-label">이메일</label>
        <div class="emailDiv">
            <input type="text" id="email" name="businessEmail" class="form-control">
            <button type="button" id="checkEmailBtn" class="btn btn-outline-danger">중복확인</button>
        </div>
            <div id="emailError" class="text-danger small"></div>
    </div>
    <div class="mb-3">
        <label for="password" class="form-label">비밀번호</label>
        <input type="password" id="password" name="businessPassword" class="form-control"
               placeholder="최소 8자리 / 영문 대소문자, 숫자, 특수문자 조합">
    </div>

    <div class="mb-3">
        <label for="confirmPassword" class="form-label">비밀번호 확인</label>
        <input type="password" id="confirmPassword" class="form-control">
        <div id="passwordError" class="text-danger small"></div>
    </div>
    <div class="mb-3">
        <label for="businessNo" class="form-label">사업자번호</label>
        <input type="text" id="businessNo" name="businessNo" class="form-control">
        <div id="businessNoError" class="text-danger small"></div>
        <form:errors path="businessNo" cssClass="text-danger small"/>
    </div>
    <div class="mb-3">
        <label for="businessName" class="form-label">상호명</label>
        <input type="text" id="businessName" name="businessName" class="form-control">
        <div id="businessNameError" class="text-danger small"></div>
    </div>
    <div class="mb-3">
        <label for="representativeName" class="form-label">대표자명</label>
        <input type="text" id="representativeName" name="representativeName" class="form-control">
        <div id="representativeNameError" class="text-danger small"></div>
    </div>
    <div class="mb-3">
        <label for="businessAccount" class="form-label">계좌정보</label>
        <input type="text" id="businessAccount" name="businessAccount" class="form-control">
        <div id="businessAccountError" class="text-danger small"></div>
    </div>
    <div class="mb-3">
        <label class="form-label">전화번호</label>
        <div class="d-flex">
            <input type="text" id="phone1" name="phone1" class="form-control me-2" maxlength="3">
            <span class="align-self-center">-</span>
            <input type="text" id="phone2" name="phone2" class="form-control mx-2" maxlength="4">
            <span class="align-self-center">-</span>
            <input type="text" id="phone3" name="phone3" class="form-control ms-2" maxlength="4">
        </div>
        <div id="phoneError" class="text-danger small"></div>
    </div>
    <button type="submit" class="btn btn-outline-primary w-100">가입하기</button>
</form:form>

<!-- 이메일 인증 Modal -->
<div class="modal fade" id="emailVerificationModal" tabindex="-1" aria-labelledby="emailVerificationLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="emailVerificationLabel">이메일 인증</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="modalMessage">사용가능한 이메일입니다.
                    <button type="button" class="btn btn-outline-success" id="sendEmailCodeBtn">인증 코드 받기</button>
                </div>
                <div class="d-flex">
                    <input type="text" id="emailCode" class="form-control me-2" placeholder="인증 코드">
                    <button type="button" id="verifyEmailCodeBtn" class="btn btn-outline-danger">인증</button>
                </div>
                <div id="emailCodeError" class="text-danger small"></div>
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>