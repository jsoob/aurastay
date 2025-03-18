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
            // 전송 전에 유효성 검사
            $("#signUpForm").on("submit", () => {
                let isValid = true;

                let email = $("#businessEmail").val().trim();
                let password = $("#businessPassword").val().trim();
                let confirmPassword = $("#confirmPassword").val().trim();
                let businessNo = $("#businessNo").val().trim();
                let phone1 = $("#phone1").val().trim();
                let phone2 = $("#phone2").val().trim();
                let phone3 = $("#phone3").val().trim();
                let businessAccount = $("#businessAccount").val().trim();

                if(email == ""){
                    $("#emailError").text("이메일을 입력해주세요.")
                    isValid = false;
                } else if (!/^\S+@\S+\.\S+$/.test(email)) {
                    $("#emailError").text("올바른 이메일 형식을 입력하세요.")
                    isValid = false;
                }

                // 비밀번호 유효성 검사
                // 특수기호나 숫자를 1자 이상 포함하고 최소 8자여야 합니다.
                if(password != confirmPassword){
                    $("#passwordError").text("비밀번호가 일치하지 않습니다.")
                    isValid = false;
                    $("#businessPassword").focus();
                } else if(password.length < 8){

                    $("#passwordError").text("비밀번호는 최소 8자 이상이어야 합니다.");
                    isValid = false;
                } else if(!/^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*[a-zA-Z])(?=.*\d).*$/.test(password)){
                    $("#passwordError").text("특수기호, 영문자, 숫자를 1자 이상 포함해야 합니다.");
                    isValid = false;
                }
                // 사업자번호는 숫자만 입력 가능
                if(!/^\d+$/.test(businessNo)) {
                    $("#businessNoError").text("사업자번호는 숫자만 입력 가능합니다.");
                    isValid = false;
                } else if(businessNo.length != 10){
                    $("#businessNoError").text("사업자번호는 10자리로 구성되어야 합니다.");
                }

                // 전화번호 숫자만 입력 가능
                if (!/^\d{3}$/.test(phone1) || !/^\d{3,4}$/.test(phone2) || !/^\d{4}$/.test(phone3)) {
                    $("#phoneError").text("올바른 전화번호 형식을 입력하세요.")
                    isValid = false;
                }

                // 계좌번호는 10~14자리
                if(businessAccount.length < 10 || businessAccount.length > 14){
                    $("#businessAccountError").text("계좌번호는 10~14자리로 구성되어야합니다.");
                } else if(!/^\d+$/.test(businessAccount)){
                    $("#businessAccountError").text("계좌번호는 숫자만 입력 가능합니다.");
                }
                // businessAccount 이부분도 수정필요

                // businessname, representativename null막아야함

                if (!isValid) {
                    event.preventDefault(); // 폼 전송 방지
                }
            });

            // 사업자번호 입력 시 숫자만 허용
            $("#businessNo, #phone1, #phone2, #phone3").on("input", function () {
                this.value = this.value.replace(/[^0-9]/g, ""); // 숫자 이외의 문자 제거
            });

            // 입력이 올바르면 에러 메시지 제거
            $("input").on("input", function () {
                let targetError = $(this).next(".text-danger");
                if (targetError.length) {
                    targetError.text("");
                }
            });

        })
    </script>

</head>
<body class="container mt-5">
<h3 class="text-center">비즈니스 회원가입</h3>
<form:form modelAttribute="businessDTO" action="signUp" id="signUpForm" class="mx-auto w-50" method="post">
    <div class="mb-3">
        <label for="businessEmail" class="form-label">이메일</label>
        <input type="text" id="businessEmail" name="businessEmail" class="form-control" value="ddd@naver.com" >
        <div id="emailError" class="text-danger small"></div>
    </div>
    <div class="mb-3">
        <label for="businessPassword" class="form-label">비밀번호</label>
        <input type="password" id="businessPassword" name="businessPassword" class="form-control" value="password1!" >
    </div>

    <div class="mb-3">
        <label for="confirmPassword" class="form-label">비밀번호 확인</label>
        <input type="password" id="confirmPassword" class="form-control" value="password1!" >
        <div id="passwordError" class="text-danger small"></div>
    </div>
    <div class="mb-3">
        <label for="businessNo" class="form-label">사업자번호</label>
        <input type="text" id="businessNo" name="businessNo" class="form-control" value="1234578945" >
        <div id="businessNoError" class="text-danger small"></div>
        <form:errors path="businessNo" cssClass="text-danger small"/>
    </div>
    <div class="mb-3">
        <label for="businessName" class="form-label">상호명</label>
        <input type="text" id="businessName" name="businessName" class="form-control" value="1" >
    </div>
    <div class="mb-3">
        <label for="representativeName" class="form-label">대표자명</label>
        <input type="text" id="representativeName" name="representativeName" class="form-control" value="1" >
    </div>
    <div class="mb-3">
        <label for="businessAccount" class="form-label">계좌정보</label>
        <input type="text" id="businessAccount" name="businessAccount" class="form-control" value="1" >
        <div id="businessAccountError" class="text-danger small"></div>
    </div>
    <div class="mb-3">
        <label class="form-label">전화번호</label>
        <div class="d-flex">
            <input type="text" id="phone1" name="phone1" class="form-control me-2" maxlength="3" value="1" >
            <span class="align-self-center">-</span>
            <input type="text" id="phone2" name="phone2" class="form-control mx-2" maxlength="4" value="1" >
            <span class="align-self-center">-</span>
            <input type="text" id="phone3" name="phone3" class="form-control ms-2" maxlength="4" value="1" >
        </div>
        <div id="phoneError" class="text-danger small"></div>
    </div>
    <button type="submit" class="btn btn-outline-primary w-100">가입하기</button>
</form:form>
</body>
</body>
</html>