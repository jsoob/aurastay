<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

    <title>main.jsp</title>

<body>

<jsp:include page="comm/header.jsp" />  <!-- 헤더 포함 -->
<jsp:include page="comm/sidebar.jsp" /> <!-- 사이드바 포함 -->

<!-- 메인 콘텐츠 -->
<div class="main-content">
    <div class="auth">
        <a href="login.jsp">로그인</a> | <a href="signup.jsp">회원가입</a>
    </div>
    <h3>등록된 숙소 정보가 없습니다.</h3>
    <h3>등록을 원한다면 <a href="/acmAdd">숙소등록</a>을 눌러주세요.</h3>
</div>

<jsp:include page="comm/footer.jsp" /> <!-- 푸터 포함 -->

</body>
</html>
