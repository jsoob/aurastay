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
    <style>
        /*.middle_container {*/
        /*    display: flex;*/
        /*    width: auto;*/
        /*    flex-direction: column;*/
        /*    align-items: center;*/
        /*}*/

        .main {
            display: flex;
            flex-direction: column;
            flex-wrap: wrap;
        }

        .error-page-int {
            max-width: 500px;
            padding: 20px 0;
            width: 80%;
            position: relative;
            margin: 0 auto;
        }

        #btnSend {
            margin: 20px 0;
        }

        .codeDiv {
            margin-top: 20px;
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            align-content: stretch;
            justify-content: flex-start;
            align-items: flex-end;
        }

        #codeInput {
            display: block;
            width: 50%;
            padding: .375rem .75rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            background-clip: padding-box;
            border: 1px solid lightgray;
            border-radius: 5px;
            transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
        }

        .test {
            margin: auto;
        }
    </style>

    <script>
        $(() => {

            let authCode = ""; // 인증번호 저장 변수

            // 이메일 발송 버튼 누르면
            // input박스의 내용인 email로 이메일 발송되게 함
            $("#btnSend").on("click", () => {

                let email = $("#email").val();

                if (!email) {
                    alert("이메일을 입력해주세요.");
                    return;
                } else if (!/^\S+@\S+\.\S+$/.test(email)) {
                    alert("올바른 이메일 형식을 입력하세요.")
                } else {

                    // 인증코드 input박스, 인증 button 생기게 함
                    // 인증번호 input
                    let codeInput = '<input type="text" id="codeInput" name="code"/>';
                    // 인증번호
                    let codeBtn = '<button id="codeBtn" class="btn btn-outline-danger btn-block">인증</button>';
                    $(".codeDiv").html(codeInput + codeBtn);

                    $.ajax({
                        type: "post",
                        url: "/sendEmail/findPassword",
                        dataType: "json",
                        contentType: "application/json",  // JSON 요청임을 명시
                        data: JSON.stringify({email: email}), // JSON 문자열로 변환하여 전송

                        success: function (data) {
                            console.log(data);
                            authCode = data.code; // 인증번호 저장
                        },
                        error: function (xhr) {
                            alert("이메일 전송 실패하였습니다. 다시 시도해주세요.");
                        }
                    });
                }
            })

            // 인증버튼 누르면
            $(document).on("click", "#codeBtn", function () {
                // 입력한 인증코드
                let inputCode = $("#codeInput").val();

                console.log("inputCode : " + inputCode);
                console.log("authCode : " + authCode);

                if (!inputCode) {
                    alert("인증번호를 입력해주세요.");
                    return;
                }

                // 받아온 인증코드와 일치하는지 확인 후
                if (inputCode == authCode) {
                    alert("인증 성공! 비밀번호 변경 페이지로 이동합니다.");
                    window.location.href = "/resetPassword?email=" + $("#email").val();
                } else {
                    alert("인증번호가 올바르지 않습니다. 다시 입력해주세요.");
                }

                // 비밀번호를 변경할 수 있는 페이지로 이동해서 변경가능하도록
            })


        })
    </script>

</head>
<body>
<jsp:include page="main/header.jsp"/>
<div class="container main">
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
<jsp:include page="main/footer.jsp"/>
</body>
</html>