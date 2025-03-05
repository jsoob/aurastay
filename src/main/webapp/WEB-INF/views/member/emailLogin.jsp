<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
    <form action="" method="post">
        <div><h3>이메일로 로그인</h3></div>
        <div>
            이메일 <input type="text" name="memberEmail"><br>
            비밀번호 <input type="text" name="memberPassword">
            <input type="submit" value="로그인">
        </div>
        <div>
            <a href="">비밀번호 재설정></a> |
            <a href="/member/emailSignUp">이메일로 회원가입></a>
        </div>
    </form>
</div>
</body>
</html>