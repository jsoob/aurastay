$(document).ready(function () {

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

            // 유효성 검사
            let email = $("#email").val().trim();
            let nickname = $("#nickname").val().trim();
            let name = $("#name").val().trim();
            let phone = $("#phone").val().trim();

            // 이메일
            if (email === "") {
                alert("이메일을 입력해주세요.");
                $("#email").focus();
                return;
            } else if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email)) {
                alert("올바른 이메일 형식을 입력하세요.");
                $("#email").focus();
                return;
            }

            // 닉네임
            if (nickname === "") {
                alert("닉네임을 입력해주세요.");
                $("#nickname").focus();
                return;
            }
            // 이름
            if (name === "") {
                alert("이름을 입력해주세요.");
                $("#name").focus();
                return;
            }
            // 전화번호 숫자만 입력 가능
            if (!/^\d{9,11}$/.test(phone)) {
                alert("전화번호는 숫자로만 이루어진 9~11자리여야 합니다.");
                $("#phone").focus();
                return;
            }

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

    // 비밀번호 확인
    $("#checkPasswordBtn").on("click", () => {
        let password = $("#checkPassword").val().trim();
        let memberNo = $("#memberNo").val().trim();
        $.ajax({
            type: "post",
            url: "/member/checkPassword",
            data: {memberNo: memberNo, password: password},
            success: function (response) {
                if (response.response) {
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

    // 회원탈퇴
    const deleteBtn = document.querySelector("#deleteBtn button");
    const confirmDeleteBtn = document.querySelector("#confirmDeleteBtn");
    const deleteForm = document.querySelector("#deleteBtn form");

    // 탈퇴 버튼 클릭 시 모달 띄우기
    deleteBtn.addEventListener("click", function (event) {
        event.preventDefault(); // 폼 제출 방지
        const deleteModal = new bootstrap.Modal(document.getElementById("confirmDeleteModal"));
        deleteModal.show();
    });

    // 모달에서 '탈퇴' 버튼 클릭 시 폼 제출
    confirmDeleteBtn.addEventListener("click", function () {
        deleteForm.submit();
    });


})