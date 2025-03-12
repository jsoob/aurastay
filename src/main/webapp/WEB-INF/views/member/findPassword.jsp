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

    <style>
        /*.middle_container {*/
        /*    display: flex;*/
        /*    width: auto;*/
        /*    flex-direction: column;*/
        /*    align-items: center;*/
        /*}*/

        .error-page-int {
            max-width: 500px;
            padding: 20px 0;
            width: 80%;
            position: relative;
            margin: 0 auto;
        }

    </style>
</head>
<body>
<%--<div class="container">--%>
<%--    <div class="middle_container">--%>
<%--        <div>--%>
<%--        <p class="MemberDescBox_container">회원가입 시 등록한 이메일을 입력해 주세요.<br>비밀번호 변경 가능한 링크를 보내드립니다.</p>--%>
<%--        </div>--%>

<%--        <div class="mb-3">--%>
<%--            <label for="exampleFormControlInput1" class="form-label">Email address</label>--%>
<%--            <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="name@example.com">--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<div class="error-pagewrap">
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
                        이메일 주소와 성함을 입력하시면 해당 이메일로 인증번호가 전송됩니다.
                    </p>
                    <div id="sendForm" class="row">
                        <div class="col-sm-12 form-group"> <!-- wd-50 -->
                            <label class="control-label" for="empNo">Email</label>
                            <input type="text" placeholder="example@gmail.com" title="Please enter your email address"
                                   id="empNo" name="empNo" class="form-control">
                            <%--
                                <input type="hidden" name="cmd" value="sendEmail" />
                             --%>
                        </div>

                        <div class="col-sm-12 form-group">
                            <label class="control-label" for="empEmail">name</label>
                            <input type="text" placeholder="name" title="Please enter your name"
                                id="empEmail" name="empEmail" class="form-control">
                            <span class="help-block small"> 귀하의 등록된 외부 이메일 주소<br>(google, naver)</span>
                        </div>

                        <button id="btnSend" class="btn btn-primary btn-block">인증메일 발송</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="text-center login-footer">
            <p>Copyright © 2025. All rights reserved. Template by AURA</p>
        </div>
    </div>
</div>

</body>
</html>