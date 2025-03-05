<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <link rel="stylesheet" href="/css/main.css">
</head>
<header>

    <nav class="navbar navbar-expand-md fixed-top bg-light">
        <div class="container">
            <a class="navbar-brand" href="#">logo</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
                    aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">

                <form class="mx-auto search-bar" style="width: 40%">
                    <input class="form-control me-2" type="search" style="width: 70%;float: left;" aria-label="Search">
                    <button class="btn btn-danger w-40" style="width: 20%" type="submit">검색</button>
                </form>
                <div class="dropdown">
                    <button class="btn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="/img/menu.png" alt="menu">
                        <img src="/img/profile.png" alt="profile">
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="/member/login">로그인</a></li>
                        <li><a class="dropdown-item" href="/member/emailSignUp">회원가입</a></li>
                    </ul>
                </div>
            </div>
        </div>

    </nav>
<nav>
    <div class="container">
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-md-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Link</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" aria-disabled="true">Disabled</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
</header>
