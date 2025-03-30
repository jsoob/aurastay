<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 재설정 완료</title>
    <style>
        .main {
            display: flex;
        }
        .completeContainer {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 50px;
        }
        .completeContainer {
            max-width: 500px;
            margin: auto;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            text-align: center;
        }
        #completeDiv > h3 {
            color: #ff385c;
            margin-top: 20px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        p {
            font-size: 16px;
            color: #666;
            margin-top: 20px;
            margin-bottom: 20px;
        }
        .signInBtn {
            display: inline-block;
            padding: 12px 20px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
            text-decoration: none;
            margin-top: 20px;
            margin-bottom: 20px;
            background-color: white;
            color: #ff385c;
            border: 1px solid #ff385c;
        }
        .signInBtn:hover {
            background-color: #ff385c;
            color: white;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="/css/main.css">
</head>
<body>
<jsp:include page="./main/basic-header.jsp"/>
<div class="main">
<div class="completeContainer">
    <div id="completeDiv"><h3>비밀번호 재설정 완료</h3></div>
    <p>이제 새로운 비밀번호로 로그인할 수 있습니다.</p>
    <a href="/login" class="signInBtn">로그인하기</a>
</div>
</div>
<jsp:include page="./main/footer.jsp"/>
</body>
</html>