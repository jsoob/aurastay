<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<header>
    <a href="/"><img src="/img/AURAlogo.png" alt="logo"></a>
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
            <%-- 인증이 안된 사용자가 볼 수 있는 리스트 --%>
            <sec:authorize access="isAnonymous()">
                <li><a class="dropdown-item" href="/login">로그인</a></li>
                <li><a class="dropdown-item" href="/member/emailSignUp">회원가입</a></li>
            </sec:authorize>
            <%-- 인증된 사용자가 볼 수 있는 리스트 --%>
            <sec:authorize access="isAuthenticated()">
                <sec:authorize access="hasRole('MEMBER')">
                    <li><a class="dropdown-item" href="/member/myPage">마이페이지</a></li>
                    <li><a class="dropdown-item" href="/wishlist">위시리스트</a></li>
                    <li><a class="dropdown-item" href="/reservation/mystays">예약내역</a></li>
                </sec:authorize>
                <sec:authorize access="hasAnyRole('MEMBER','BUSINESS')">
                    <li>
                        <form action="/logout" method="post" id="logoutForm">
                            <button type="submit" class="dropdown-item logout-btn">로그아웃</button>
                        </form>
                    </li>
                </sec:authorize>
            </sec:authorize>
        </ul>
    </div>
</header>