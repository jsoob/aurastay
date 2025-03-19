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
            $("#signUpForm").on("submit", (event) => {

                let isValid = true;

                let email = $("#email").val().trim();
                let password = $("#password").val().trim();
                let confirmPassword = $("#confirmPassword").val().trim();
                let phone1 = $("#phone1").val().trim();
                let phone2 = $("#phone2").val().trim();
                let phone3 = $("#phone3").val().trim();
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

                // 전화번호 숫자만 입력 가능
                if (!/^\d{3}$/.test(phone1) || !/^\d{3,4}$/.test(phone2) || !/^\d{4}$/.test(phone3)) {
                    $("#phoneError").text("올바른 전화번호 형식을 입력하세요.");
                    isValid = false;
                }


                // 닉네임
                if (nickname === "") {
                    $("#nicknameError").text("닉네임을 입력해주세요.");
                    isValid = false;
                }
                // 이름
                if (name === "") {
                    $("#nameError").text("이름을 입력해주세요.");
                    isValid = false;
                }

                if (!isValid) {
                    event.preventDefault(); // 폼 전송 방지
                }

            });

            // 숫자 입력 필드에서 문자 입력 방지
            $("#phone1, #phone2, #phone3").on("input", function () {
                this.value = this.value.replace(/[^0-9]/g, "");
            });

            // 입력값이 변경될 때 오류 메시지 자동 제거
            $("input").on("input", function () {
                $(this).next(".text-danger").text("");
            });

        })
    </script>
</head>
<body class="container mt-5">
<h3 class="text-center">회원가입</h3>
<form:form modelAttribute="memberDTO" action="emailSignUp" id="signUpForm" class="mx-auto w-50" method="post">
    <div class="mb-3">
        <label for="email" class="form-label">이메일</label>
        <input type="text" id="email" name="memberEmail" class="form-control">
        <div id="emailError" class="text-danger small"></div>
        <form:errors path="memberEmail" cssClass="text-danger small"/>
    </div>

    <div class="mb-3">
        <label for="password" class="form-label">비밀번호</label>
        <input type="password" id="password" name="memberPassword" class="form-control">
    </div>

    <div class="mb-3">
        <label for="confirmPassword" class="form-label">비밀번호 확인</label>
        <input type="password" id="confirmPassword" class="form-control">
        <div id="passwordError" class="text-danger small"></div>
    </div>

    <div class="mb-3">
        <label for="nickname" class="form-label">닉네임</label>
        <input type="text" id="nickname" name="memberNickname" class="form-control">
        <div id="nicknameError" class="text-danger small"></div>
    </div>

    <div class="mb-3">
        <label for="name" class="form-label">이름</label>
        <input type="text" id="name" name="memberName" class="form-control">
        <div id="nameError" class="text-danger small"></div>
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
    <button type="submit" class="btn btn-outline-danger w-100">가입하기</button>
</form:form>
</body>
</html>
