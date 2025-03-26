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

