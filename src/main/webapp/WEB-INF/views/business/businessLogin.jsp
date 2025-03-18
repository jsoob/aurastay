<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title> </title>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
    <form action="/loginProcess" class="mx-auto w-50" method="post">
        <div>
            <div class="mb-3">
                <label for="memberEmail" class="form-label">이메일</label>
                <input type="email" class="form-control" id="memberEmail" name="memberEmail" placeholder="이메일을 입력하세요">
            </div>

            <div class="mb-3">
                <label for="memberPassword" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="memberPassword" name="memberPassword"
                       placeholder="비밀번호를 입력하세요">
            </div>
            <input type="submit" class="btn btn-outline-primary" value="로그인">
            <div class="TextButton_container">
                <span><a href="/business/signUp">회원가입</a></span>
                <span><a href="">비밀번호 찾기</a></span>
            </div>
        </div>
    </form>
</div>
</body>
</html>