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
<jsp:include page="main/header.jsp"/>



<div class="main container">
    <div class="logo">
        <img src="/img/AURAlogo.png" alt="logo">
    </div>

    <form action="/loginProcess" class="mx-auto w-50" method="post">
        <div class="emailLoginDiv">
            <div class="mb-3">
                <%-- name = "username"으로 해야함 --%>
                <input type="email" class="form-control" id="memberEmail" name="username" placeholder="이메일을 입력하세요">
            </div>

            <div class="mb-3">
                <input type="password" class="form-control" id="memberPassword" name="password"
                       placeholder="비밀번호를 입력하세요">
            </div>
            <input type="submit" class="btn btn-outline-danger" id="loginBtn" value="로그인">
            <div class="TextButton_container">
                <span><a href="/findPassword">비밀번호 재설정></a></span><br>

            </div>
        </div>
    </form>

    <div class="SocialLoginButtons_container">
        <div>
            <a href="/oauth2/authorization/kakao">
                <div id="kakao" class="loginBtn"><img
                        src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-kakao.svg" alt="">카카오로 시작하기
                </div>
            </a>
        </div>
        <div>
            <a href="/oauth2/authorization/naver">
                <div id="naver" class="loginBtn"><img
                        src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-naver.svg" alt="">네이버로 시작하기
                </div>
            </a>
        </div>
        <div>
            <a href="/oauth2/authorization/google">
                <div id="google" class="loginBtn"><img
                        src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-google.svg" alt="">Google로 시작하기
                </div>
            </a>
        </div>
        <%--        <div>--%>
        <%--            <a href="/emailLogin" >--%>
        <%--                <div id="email" class="loginBtn"><img src="/img/email2.png" alt="">이메일로 시작하기</div>--%>
        <%--            </a>--%>
        <%--        </div>--%>
    </div>
    <div class="TextButton_container">
        <a href="/business/intro">사업자로 시작하기></a>
        <a href="/member/emailSignUp">이메일로 회원가입></a>
    </div>

</div>


<jsp:include page="main/footer.jsp"/>
</body>
</html>