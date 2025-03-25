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
                <h5 class="modal-title" id="confirmDeleteLabel">회원 탈퇴 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                정말 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" id="confirmDeleteBtn" class="btn btn-danger">탈퇴</button>
            </div>
        </div>
    </div>
</div>

<script src ="/js/mypage.js"></script>
</body>
</html>

