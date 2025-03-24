<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>마이페이지</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

    <style>
        .mypage-container {
            max-width: 500px;
            margin: 10px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .form-group label {
            flex: 1;
            font-weight: bold;
            color: #333;
        }

        .form-group input {
            flex: 2;
            padding: 8px;
            border: 0px solid #ddd;
            border-radius: 5px;
            transition: 0.3s;
        }

        .form-group input:focus {
            border-color: #007bff;
            outline: none;
        }

        .main > h3 {
            text-align: center;
            margin: 30px 20px;
        }

        /* 수정 */
        #editDiv {
            display: flex;
            flex-direction: row-reverse;
        }

        /* 수정 버튼 */
        #editBtn {
            background-color: #f3f2f2;
            border: 1px solid lightgray;
            border-radius: 5px;
            padding: 5px 10px;
        }

        /* 비밀번호 변경 버튼 */
        #changePwdBtn {
            background-color: #f3f2f2;
            border: 1px solid lightgray;
            border-radius: 5px;
            padding: 5px 10px;
        }

        /* 회원 탈퇴  */
        #deleteBtn {
            max-width: 500px;
            margin: 10px auto;
            padding: 20px;
            display: flex;
            flex-direction: row-reverse;
        }

        #deleteBtn button {
            text-decoration: none;
            color: lightgray;
            background-color: white;
            border: 0 solid white;
        }

        #modalMessage {
            padding-bottom: 10px;
        }

        #checkPasswordBtn {
            width: 100px;
        }
    </style>
    <link rel="stylesheet" href="/css/main.css">
    <script>
        $(document).ready(function () {
            // $("#editBtn").on("click",()=>{
            //     console.log("버튼눌림");
            //     // 여기서 input창으로 변경되고 다시 수정 버튼 누르면 submit될수있도록하기
            // })

            let providerId = $("#providerId").val();
            let isEditing = false; // 수정 중인지 상태 저장
            console.log("providerId : " + providerId);
            $("#editBtn").on("click", function () {
                if (!isEditing) {
                    // 수정 모드로 변경
                    // 일반 로그인 사용자이라면
                    if (providerId === undefined || providerId.trim() === null) {
                        $("input").not("#email").not("#point").removeAttr("readonly").css("border", "1px solid #ccc");
                    } else {
                        // 소셜로그인 사용자이라면
                        $("input").not("#providerId").not("#point").removeAttr("readonly").css("border", "1px solid #ccc");
                    }

                    $(this).text("저장");
                    isEditing = true;
                } else {
                    // 저장 모드 → 폼 제출

                    let formData = {};
                    $(".modifyForm").serializeArray().forEach((item) => {
                        formData[item.name] = item.value;
                    });
                    console.log(formData);
                    $.ajax({
                        type: "post",
                        url: "/member/myPage",
                        contentType: "application/json",  // JSON 요청임을 명시
                        data: JSON.stringify(formData), // JSON 문자열로 변환하여 전송

                        success: function (data) {
                            console.log(data);
                            alert("정보가 수정되었습니다.");
                            location.reload();
                            $("input").attr("readonly");
                        },
                        error: function (xhr) {
                            console.log(xhr);
                            alert("다시 시도해주세요.");
                        }
                    })
                }
            });
                let checkPasswordModal = new bootstrap.Modal(document.getElementById("checkPasswordModal"));

            // 비밀번호 변경
            $("#changePwdBtn").on("click", function (e) {
                e.preventDefault(); // 기본 이벤트 막기

                checkPasswordModal.show();

                // 원래 비밀번호를 입력하게 해서 맞으면
                // 새로운 비밀번호를 설정할 수 있는 페이지로 보냄
            })


            $("#checkPasswordBtn").on("click", () => {
                let password = $("#checkPassword").val().trim();
                let memberNo = $("#memberNo").val().trim();
                $.ajax({
                    type: "post",
                    url: "/member/checkPassword",
                    data: {memberNo: memberNo, password: password},
                    success: function (response) {
                        if(response.response){
                            alert("비밀번호 변경페이지로 이동합니다.");
                            checkPasswordModal.hide();
                            window.location.href = "/resetPassword";

                        } else {
                            $("#passwordError").text("비밀번호가 일치하지 않습니다.");
                        }
                    },
                    error: function () {
                        $("#passwordError").text("비밀번호가 일치하지 않습니다.");
                    }
                })
            });
        })


    </script>
</head>
<body>
<jsp:include page="../main/basic-header.jsp"/>
<div class="container main">
    <h3>마이페이지</h3>
    <form action="/member/myPage" class="modifyForm" method="post">
        <div class="mypage-container">
            <input type="hidden" name="memberNo" id="memberNo" value="${dto.memberNo}">

            <div class="form-group">
                <label>이메일</label>
                <input type="text" id="email" name="memberEmail" value="${dto.memberEmail}" readonly>
            </div>

            <c:if test="${dto.providerId != null}">
                <div class="form-group">
                    <label>소셜로그인 ID</label>
                    <input type="text" name="providerId" id="providerId" value="${dto.providerId}" readonly>
                </div>
            </c:if>

            <div class="form-group">
                <label>이름</label>
                <input type="text" name="memberName" value="${dto.memberName}" readonly>
            </div>

            <div class="form-group">
                <label>닉네임</label>
                <input type="text" name="memberNickname" value="${dto.memberNickname}" readonly>
            </div>

            <div class="form-group">
                <label>전화번호</label>
                <input type="text" name="memberPhoneNumber" value="${dto.memberPhoneNumber}" readonly>
            </div>

            <div class="form-group">
                <label>포인트</label>
                <input type="text" name="point" id="point" value="${dto.point}" readonly>
            </div>
            <div class="form-group" id="editDiv">
                <button type="button" id="editBtn">수정</button>
            </div>
        </div>
        <c:if test="${empty dto.providerId}">
            <div class="mypage-container">
                <div class="form-group">
                    <label>비밀번호</label>
                    <button id="changePwdBtn">비밀번호 변경하기</button>
                </div>
            </div>
        </c:if>
    </form>
    <div id="deleteBtn">
        <form action="/member/withdrawal" method="post">
            <input type="hidden" name="memberNo" value="${dto.memberNo}">
            <button type="submit">회원탈퇴 ></button>
        </form>
    </div>
</div>
<jsp:include page="../main/footer.jsp"/>

<!-- 비밀번호 확인 Modal -->
<div class="modal fade" id="checkPasswordModal" tabindex="-1" aria-labelledby="checkPasswordLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="checkPasswordLabel">비밀번호 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="modalMessage">기존 비밀번호를 입력해주세요.</div>
                <div class="d-flex">
                    <input type="text" id="checkPassword" class="form-control me-2" placeholder="비밀번호">
                    <button type="button" id="checkPasswordBtn" class="btn btn-outline-danger">확인</button>
                </div>
                <div id="passwordError" class="text-danger small"></div>
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>

