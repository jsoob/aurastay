<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <link rel="stylesheet" href="/css/main-header.css">
</head>
<header>
    <div class="header">
        <img src="/img/AURAlogo.png" alt="logo">
        <div>
            <form action="">
                <div class="search">
                    <input type="text" name="keyword" placeholder="여행지 검색">
                    <button type="submit"><img src="/img/search.png"></button>
                </div>
            </form>
        </div>

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
    <nav class="nav-list">
        <ul>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/51f5cf64-5821-400c-8033-8a10c7787d69.jpg" alt="">한옥</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/bcd1adc0-5cee-4d7a-85ec-f6730b0f8d0c.jpg" alt="">펜션</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/7630c83f-96a8-4232-9a10-0398661e2e6f.jpg" alt="">게스트하우스</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/251c0635-cc91-4ef7-bb13-1084d5229446.jpg" alt="">호텔</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/48b55f09-f51c-4ff5-b2c6-7f6bd4d1e049.jpg" alt="">추가</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/3fb523a0-b622-4368-8142-b5e03df7549b.jpg" alt="">추가</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/3b1eb541-46d9-4bef-abc4-c37d77e3c21b.jpg" alt="">추가</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/aaa02c2d-9f0d-4c41-878a-68c12ec6c6bd.jpg" alt="">추가</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/3271df99-f071-4ecf-9128-eb2d2b1f50f0.jpg" alt="">추가</a>
            </li>
            <li>
                <a href=""><img src="https://a0.muscache.com/pictures/31c1d523-cc46-45b3-957a-da76c30c85f9.jpg" alt="">추가</a>
            </li>
            <li>
                <a href=""><button class="btn filter-btn"><img src="/img/filter.png" alt="filterIcon">필터</button></a>
            </li>
        </ul>
    </nav>
</header>
