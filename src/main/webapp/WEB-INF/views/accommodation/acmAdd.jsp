<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>숙소 등록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- accAdd.CSS 파일 연결 -->
    <link rel="stylesheet" type="text/css" href="../css/acm.css">

    <script>
        $(document).ready(function () {
            $("#btn").click(function () {
                // 새로운 파일 입력 필드 추가
                let newFileInput = '<input type="file" name="file">';
                $(this).before(newFileInput); // 버튼 앞에 추가
            });
        });
    </script>

</head>

<jsp:include page="../comm/header.jsp"/>
<jsp:include page="../comm/sidebar.jsp"/>

<body>
<div class="main-content">
    <h2>숙소 등록</h2>
    <form action="/accommodation/acmAdd" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <%--숙소명--%>
            <label>숙소명</label>
            <input type="text" name="acmName" placeholder="숙소명을 입력하세요" required>
        </div>
        <div class="form-group">
            <%--주소--%>
            <label>주소</label>
            <input type="text" name="acmAddress" placeholder="주소를 입력하세요" required>
        </div>
        <div class="form-group">
            <%--연락처--%>
            <label>연락처</label>
            <input type="tel" name="acmTel" size=10 maxlength=11 placeholder="연락처를 입력하세요" required>
        </div>
        <div class="check-group">
            <div class="check-item">
                <%--체크인--%>
                <label class="form-label">체크인</label>
                <input type="datetime-local" class="form-control" name="checkinTime" required>
            </div>
            <div class="check-item">
                <%--체크아웃--%>
                <label class="form-label">체크아웃</label>
                <input type="datetime-local" class="form-control" name="checkoutTime" required>
            </div>
        </div>
        <br>
        <div class="form-group">
            <%--내용--%>
            <label>내용</label>
            <textarea name="contents" placeholder="숙소에 대한 정보를 입력하세요" rows="4" required></textarea>
        </div>
        <div>
            <div class="form-group">
                <%-- 카테고리 --%>
                <label>Category</label>
                <div class="checkbox-group">
                    <label><input type="checkbox" name="category" value="호텔"> 호텔</label>
                    <label><input type="checkbox" name="category" value="리조트"> 리조트</label>
                    <label><input type="checkbox" name="category" value="풀빌라"> 풀빌라</label>
                    <label><input type="checkbox" name="category" value="펜션"> 펜션</label>
                    <label><input type="checkbox" name="category" value="한옥"> 한옥</label>
                    <label><input type="checkbox" name="category" value="캠핑장"> 캠핑장</label>
                    <label><input type="checkbox" name="category" value="게스트하우스"> 게스트하우스</label>
                </div>
            </div>

            <div class="form-group">
                <%-- 키워드 --%>
                <label>Keyword</label>
                <div class="checkbox-group">
                    <label><input type="checkbox" name="keyword" value="명동"> 명동</label>
                    <label><input type="checkbox" name="keyword" value="홍대"> 홍대</label>
                    <label><input type="checkbox" name="keyword" value="강남"> 강남</label>
                    <label><input type="checkbox" name="keyword" value="종로"> 종로</label>
                    <label><input type="checkbox" name="keyword" value="잠실"> 잠실</label>
                    <label><input type="checkbox" name="keyword" value="인천"> 인천</label>
                    <label><input type="checkbox" name="keyword" value="속초"> 속초</label>
                    <label><input type="checkbox" name="keyword" value="강릉"> 강릉</label>
                    <label><input type="checkbox" name="keyword" value="보성"> 보성</label>
                    <label><input type="checkbox" name="keyword" value="부산"> 부산</label>
                    <label><input type="checkbox" name="keyword" value="대구"> 대구</label>
                    <label><input type="checkbox" name="keyword" value="대전"> 대전</label>
                    <label><input type="checkbox" name="keyword" value="목포"> 목포</label>
                    <label><input type="checkbox" name="keyword" value="포항"> 포항</label>
                    <label><input type="checkbox" name="keyword" value="전주"> 전주</label>
                    <label><input type="checkbox" name="keyword" value="수원"> 수원</label>
                    <label><input type="checkbox" name="keyword" value="양양"> 양양</label>
                    <label><input type="checkbox" name="keyword" value="광안리"> 광안리</label>
                    <label><input type="checkbox" name="keyword" value="해운대"> 해운대</label>
                    <label><input type="checkbox" name="keyword" value="제주도"> 제주도</label>

                </div>
            </div>


            <%-- 카테고리 : 드롭다운으로 했을 때 --%>
            <%--            <label for="category">Category</label>--%>
            <%--            <select id="category" name="category_no" required>--%>
            <%--                <c:forEach var="category" items="${categories}">--%>
            <%--                    <option value="${category.category_no}">${category.category_name}</option>--%>
            <%--                </c:forEach>--%>
            <%--            </select>--%>
            <%-- 키워드 : 드롭다운으로 했을 때 --%>
            <%--            <label for="keyword">Keyword</label>--%>
            <%--            <select id="keyword" name="keyword" required>--%>
            <%--                <c:forEach var="keyword" items="${keywords}">--%>
            <%--                    <option value="${keyword.keyword_no}">${keyword.keyword_name}</option>--%>
            <%--                </c:forEach>--%>
            <%--            </select>--%>

        </div>
        <div>
            <label class="form-label">첨부파일</label>
            <input type="file" name="files" multiple> <%--여러 개의 파일을 선택할 수 있도록 multiple 추가--%>
            <input type="button" value="추가" id="btn">
        </div>

        <div class="btn-container">
            <button type="submit" class="btn btn-primary">등록</button>
            <button type="reset" class="btn btn-secondary">취소</button>
        </div>
    </form>
</div>
</body>

<jsp:include page="../comm/footer.jsp"/>
</html>
