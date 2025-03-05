<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>index</title>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        .dropdown > .btn {
            border-radius: 30px;
            background-color: white;
        }
        .btn:hover {
            box-shadow: 1px 2px 2px lightgray;
        }
        #logo {
            width: 200px;
        }
        .modal {
            text-align: center;
        }
        a{
            text-decoration: none;
        }
        .snsLogin {
            margin: 50px auto;
        }
        
    </style>
</head>
<body>
    <h3>index</h3>
    <ul>
        <li><a href="/member/login">로그인</a></li>
    </ul>

    <div class="dropdown">
        <button class="btn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
            <img src="/img/menu.png" alt="menu">
            <img src="/img/profile.png" alt="profile">
        </button>
        <ul class="dropdown-menu">
            <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#loginModal">로그인</a></li>
            <li><a class="dropdown-item" href="#">회원가입</a></li>
            <li><a class="dropdown-item" href="#">Something else here</a></li>
        </ul>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="loginModalLabel">로그인</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <img src="/img/AURAlogo.png" id="logo" alt="logo">

                    <div class="snsLogin">
                    <h5>----여기는 간편로그인 위치----</h5>
                    <h5>----여기는 간편로그인 위치----</h5>
                    <h5>----여기는 간편로그인 위치----</h5>
                    </div>

                    <div>
                        <a href="/member/emailLogin">이메일로 시작하기></a>
                        <a href="">사업자로 시작하기></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>