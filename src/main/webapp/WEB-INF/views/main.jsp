<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>main.jsp</title>
    <style>
        /* 전체 레이아웃 */
        .container {
            display: flex;
            min-height: 100vh;
            flex-direction: column;
            margin-left: 250px;  /* 사이드바 공간을 확보 */
        }

        /* 헤더 스타일 */
        header {
            background-color: #2c3e50; /* 사이드바와 동일한 색상 */
            color: white;
            padding: 20px;
            text-align: center;
            position: fixed;
            top: 0;
            left: 250px; /* 사이드바 크기만큼 왼쪽에 위치 */
            right: 0;
            z-index: 10;
        }

        header .logo h1 {
            margin: 0;
            font-size: 24px;
        }

        header h1 {
            margin: 0;
            font-size: 30px;
            font-weight: bold;
        }

        /* 왼쪽 메뉴 스타일 */
        .sidebar {
            width: 250px;
            background-color: #2c3e50;
            height: 100vh;  /* 화면 전체 높이 */
            color: white;
            padding-top: 20px;
            box-shadow: 2px 0px 5px rgba(0, 0, 0, 0.2);
            position: fixed; /* 화면에 고정 */
            top: 0;  /* 상단에 고정 */
            left: 0;  /* 좌측에 고정 */
            /*bottom: 0; !* 화면 아래까지 고정 *!*/
        }

        .sidebar ul {
            list-style-type: none;
            padding: 0;
            margin-top: 50px;
        }

        .sidebar ul li {
            padding: 15px;
            text-align: center;
            position: relative;
        }

        .sidebar ul li a {
            color: white;
            text-decoration: none;
            display: block;
            font-size: 16px;
            font-weight: 500;
        }

        .sidebar ul li a:hover {
            background-color: #34495e;
            border-radius: 4px;
        }

        /* 서브메뉴 스타일 */
        .sidebar ul li div {
            display: none;
            background-color: #34495e;
            position: absolute;
            left: 100%;
            top: 0;
            width: 200px;
        }

        .sidebar ul li:hover div {
            display: block;
        }

        .sidebar ul li div li {
            padding: 10px;
            text-align: left;
        }

        .sidebar ul li div li a {
            padding-left: 20px;
        }

        /* 메인 콘텐츠 스타일 */
        .main-content {
            flex: 1;
            padding: 20px;
            background-color: #ecf0f1;
            margin-left: 250px;  /* 사이드바 크기만큼 여백 추가 */
            margin-top: 80px; /* 헤더 공간만큼 여백 추가 */
        }

        /* 푸터 스타일 */
        footer {
            background-color: #2c3e50; /* 사이드바와 동일한 색상 */
            color: white;
            text-align: center;
            padding: 10px 0;
            position: absolute;  /* 푸터를 화면 하단에 고정 */
            /*bottom: 0;*/
            left: 0;
            width: 100%;  /* 화면 폭에 맞게 확장 */
        }

        footer p {
            margin: 0;
        }
    </style>
</head>
<body>

<header>
    <div class="logo">
        <h1>AURA STAY</h1>
    </div>
</header>

<div class="container">
    <!-- 왼쪽 메뉴 -->
    <div class="sidebar">
        <ul>
            <li><a href="home.jsp">홈</a></li>
            <li><a href="#">숙소관리</a>
                <div>
                    <ul>
                        <li><a href="acmAdd">숙소등록</a></li>
                        <li><a href="acmSelectAndModify">숙소 조회/변경(취소)</a></li>
                    </ul>
                </div>
            </li>
            <li><a href="total.jsp">통계</a></li>
            <li><a href="review.jsp">리뷰관리</a></li>
            <li><a href="call.jsp">고객센터</a></li>
        </ul>
    </div>

    <!-- 메인 콘텐츠 -->
    <div class="main-content">
        <div class="auth">
            <a href="login.jsp">로그인</a> | <a href="signup.jsp">회원가입</a>
        </div>
        <h3>등록된 숙소 정보가 없습니다.</h3>
        <h3>등록을 원한다면 <a href="/acmAdd">숙소등록</a>을 눌러주세요.</h3>
    </div>
</div>

<!-- 푸터 추가 -->
<footer>
    <p>&copy; 2025 AURA STAY. All Rights Reserved.</p>
</footer>

</body>
</html>
