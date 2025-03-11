<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

</head>
<body>
<body class="container mt-5">
<h3 class="text-center">비즈니스 회원가입</h3>
<form action="signUp" class="mx-auto w-50" method="post">
    <div class="mb-3">
        <label for="businessEmail" class="form-label">이메일</label>
        <input type="email" id="businessEmail" name="businessEmail" class="form-control" required>
    </div>
    <div class="mb-3">
        <label for="businessPassword" class="form-label">비밀번호</label>
        <input type="password" id="businessPassword" name="businessPassword" class="form-control" required>
    </div>

    <div class="mb-3">
        <label for="confirmPassword" class="form-label">비밀번호 확인</label>
        <input type="password" id="confirmPassword" class="form-control" required>
        <div id="passwordError" class="text-danger small"></div>
    </div>
    <div class="mb-3">
        <label for="businessNo" class="form-label">사업자번호</label>
        <input type="text" id="businessNo" name="businessNo" class="form-control" required>
    </div>
    <div class="mb-3">
        <label for="businessName" class="form-label">상호명</label>
        <input type="text" id="businessName" name="businessName" class="form-control" required>
    </div>
    <div class="mb-3">
        <label for="representativeName" class="form-label">대표자명</label>
        <input type="text" id="representativeName" name="representativeName" class="form-control" required>
    </div>
    <div class="mb-3">
        <label for="businessAccount" class="form-label">계좌정보</label>
        <input type="text" id="businessAccount" name="businessAccount" class="form-control" required>
    </div>
    <div class="mb-3">
        <label class="form-label">전화번호</label>
        <div class="d-flex">
            <input type="text" id="phone1" name="phone1" class="form-control me-2" maxlength="3" required>
            <span class="align-self-center">-</span>
            <input type="text" id="phone2" name="phone2" class="form-control mx-2" maxlength="4" required>
            <span class="align-self-center">-</span>
            <input type="text" id="phone3" name="phone3" class="form-control ms-2" maxlength="4" required>
        </div>
    </div>
    <button type="submit" class="btn btn-outline-primary w-100">가입하기</button>
</form>
</body>
</body>
</html>