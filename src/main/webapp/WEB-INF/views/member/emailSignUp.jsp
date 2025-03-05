<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title> </title>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</head>
<body class="container mt-5">
<h3 class="text-center">회원가입</h3>
<form action="emailSignUpOk" class="mx-auto w-50" method="post">
    <div class="mb-3">
        <label for="email" class="form-label">이메일</label>
        <input type="email" id="email" name="memberEmail" class="form-control" required>
    </div>

    <div class="mb-3">
        <label for="password" class="form-label">비밀번호</label>
        <input type="password" id="password" name="memberPassword" class="form-control" required>
    </div>

    <div class="mb-3">
        <label for="confirmPassword" class="form-label">비밀번호 확인</label>
        <input type="password" id="confirmPassword" class="form-control" required>
        <div id="passwordError" class="text-danger small"></div>
    </div>

    <div class="mb-3">
        <label for="nickname" class="form-label">닉네임</label>
        <input type="text" id="nickname" name="memberNickName" class="form-control" required>
    </div>

    <div class="mb-3">
        <label for="name" class="form-label">이름</label>
        <input type="text" id="name" name="memberName" class="form-control" required>
    </div>

    <div class="mb-3">
        <label class="form-label">전화번호</label>
        <div class="d-flex">
            <input type="text" id="phone1" name="phone1" class="form-control me-2" maxlength="3" required>
            <span class="align-self-center">-</span>
            <input type="text" id="phone2" name="phone2" class="form-control mx-2" maxlength="4" required>
            <span class="align-self-center">-</span>
            <input type="text" id="phone3" name="phone3" class="form-control ms-2" maxlength="4" required>
        </div>
    </div>
    <button type="submit" class="btn btn-outline-secondary w-100">가입하기</button>
</form>
</body>
</html>
