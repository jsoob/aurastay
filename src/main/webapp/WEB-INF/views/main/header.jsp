<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header>
    <a href="/main"><img src="/img/AURAlogo.png" alt="logo"></a>
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
</header>
