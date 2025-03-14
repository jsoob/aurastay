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
    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/member-login.css">
</head>
<body>
<div class="main container">
    <div class="logo">
        <img src="/img/AURAlogo.png" alt="logo">
    </div>
    <form action="/loginProcess" class="mx-auto w-50" method="post">
        <div>
            <div class="mb-3">
                <label for="memberEmail" class="form-label">이메일</label>
                <%-- name = "username"으로 해야함 --%>
                <input type="email" class="form-control" id="memberEmail" name="username" placeholder="이메일을 입력하세요">
            </div>

            <div class="mb-3">
                <label for="memberPassword" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="memberPassword" name="password"
                       placeholder="비밀번호를 입력하세요">
            </div>
            <input type="submit" class="btn btn-outline-danger" value="로그인">
            <div class="TextButton_container">
                <span><a href="/member/login">소셜 로그인</a></span>
                <span><a href="/member/findPassword">비밀번호 재설정></a></span><br>
                <span><a href="/member/emailSignUp">이메일로 회원가입></a></span>
                <span><a href="/business/intro">사업자로 시작하기</a></span>
            </div>
        </div>
    </form>
</div>
</body>
</html>