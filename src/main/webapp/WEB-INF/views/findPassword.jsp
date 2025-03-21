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
    <link rel="stylesheet" href="/css/findPassword.css">
</head>
<body>
<jsp:include page="main/header.jsp"/>
<div class="container main">
    <div class="recovery-container">
    <div class="error-pagewrap test">
        <div class="error-page-int">
            <div class="text-center ps-recovered">
                <h2><i class="fa fa-lock fa-pwLock" aria-hidden="true"></i></h2>
                <h3>비밀번호 찾기</h3>
                <p>비밀번호를 복구하려면 양식을 작성해 주세요.</p>
            </div>
            <div class="content-error">
                <div class="hpanel">
                    <div class="panel-body poss-recover">
                        <p>
                            이메일 주소를 입력하시면 해당 이메일로 인증번호가 전송됩니다.
                        </p>
                        <div id="sendForm" class="row">
                            <div class="col-sm-12 form-group"> <!-- wd-50 -->
                                <input type="text" placeholder="이메일을 입력해주세요" title="Please enter your email address"
                                       id="email" name="email" class="form-control">
                            </div>

                            <div class="codeDiv">
                            </div>

                            <button id="btnSend" class="btn btn-outline-danger btn-block">인증메일 발송</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</div>
<jsp:include page="main/footer.jsp"/>
<script src ="/js/findPassword.js"></script>
</body>
</html>