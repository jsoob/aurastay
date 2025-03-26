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
    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/signUp.css">
</head>
<body>
<jsp:include page="../main/basic-header.jsp"/>
<div class="main">
    <div class="container mt-5 mb-5">
        <h3 class="text-center">회원가입</h3>
        <form:form modelAttribute="memberDTO" action="emailSignUp" id="signUpForm" class="mx-auto signUpWidth" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">이메일</label>
                <div class="emailDiv">
                    <input type="text" id="email" name="memberEmail" class="form-control">
                    <button type="button" id="checkEmailBtn" class="btn btn-outline-danger">중복확인</button>

                </div>
                <div id="emailError" class="text-danger small"></div>
                <form:errors path="memberEmail" cssClass="text-danger small"/>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" id="password" name="memberPassword" class="form-control"
                       placeholder="최소 8자리 / 영문 대소문자, 숫자, 특수문자 조합">
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
    </div>
</div>

<!-- 이메일 인증 Modal -->
<div class="modal fade" id="emailVerificationModal" tabindex="-1" aria-labelledby="emailVerificationLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="emailVerificationLabel">이메일 인증</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="modalMessage">사용가능한 이메일입니다.
                    <button type="button" class="btn btn-outline-success" id="sendEmailCodeBtn">인증 코드 받기</button></div>
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

<jsp:include page="../main/footer.jsp"/>
<script src ="/js/emailSignUp.js"></script>
</body>
</html>
