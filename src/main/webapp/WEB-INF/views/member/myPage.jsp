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


    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/mypage.css">

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
                <input type="text" id="name" name="memberName" value="${dto.memberName}" readonly>
            </div>

            <div class="form-group">
                <label>닉네임</label>
                <input type="text" id="nickname" name="memberNickname" value="${dto.memberNickname}" readonly>
            </div>

            <div class="form-group">
                <label>전화번호</label>
                <input type="text" id="phone" name="memberPhoneNumber" value="${dto.memberPhoneNumber}" readonly>
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
                    <input type="password" id="checkPassword" class="form-control me-2" placeholder="비밀번호">
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

<!-- 회원 탈퇴 모달 -->
<div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmDeleteLabel">회원 탈퇴</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>
                    1. 현재 사용중인 계정 정보는 복구 불가능합니다.
                    탈퇴시 현재 사용하고 계신 계정 정보는 재생이 불가능한 방법으로 파기되며 본인과 타인 모두 복구가 불가능합니다.
                    현재 사용중인 이메일의 경우 탈퇴 후 7일 이후부터 동일 아이디로 재가입이 가능합니다.
                </p>
                <p>
                    2. 회원 탈퇴 시 회원님의 포인트는 소멸되며 어떠한 경우에도 복구할 수 없습니다.
                </p>
                <p>
                    3. 게시판형 서비스에 등록된 게시물은 삭제되지 않고 유지됩니다.
                    이용후기와 같은 게시판형 서비스에 등록한 게시물은 삭제되지 않고 유지됩니다.
                    탈퇴 후에는 회원정보가 삭제되어 본인 여부를 확인할 수 있는 방법이 없으므로, 게시글을 임의로 삭제할 수 없습니다.
                    삭제를 원하는 게시물이 있을 경우, 반드시 삭제 후 탈퇴 하시기 바라며, 필요한 데이터는 미리 백업을 해주시기 바랍니다.
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" id="confirmDeleteBtn" class="btn btn-danger">탈퇴</button>
            </div>
        </div>
    </div>
</div>

<script src="/js/mypage.js"></script>
</body>
</html>