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
<jsp:include page="../main/header.jsp"/>
<div class="main">
    <div class="logo">
        <img src="/img/AURAlogo.png" alt="logo">
    </div>
    <div class="SocialLoginButtons_container">
        <div>
            <a href="">
                <div id="kakao"><img
                        src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-kakao.svg" alt="">카카오로 시작하기
                </div>
            </a>
        </div>
        <div>
            <a href="">
                <div id="naver"><img
                        src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-naver.svg" alt="">네이버로 시작하기
                </div>
            </a>
        </div>
        <div>
            <a href="">
                <div id="google"><img
                        src="//yaimg.yanolja.com/joy/sunny/static/images/login/ic-login-google.svg" alt="">Google로 시작하기
                </div>
            </a>
        </div>
        <div>
            <a href="/member/emailLogin">
                <div id="email"><img src="/img/email2.png" alt="">이메일로 시작하기</div>
            </a>
        </div>
    </div>
    <div class="TextButton_container">
        <a href="/admin">사업자로 시작하기></a>
    </div>
</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>