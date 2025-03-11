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
    <form action="/acmAdd" method="post" modelAttribute="dto" enctype="multipart/form-data">
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
            <%--카테고리--%>
            <label for="category">Category</label>
            <select id="category" name="category_no" required>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.category_no}">${category.category_name}</option>
                </c:forEach>
            </select>
            <%--키워드--%>
            <label for="keyword">Keyword</label>
            <select id="keyword" name="keyword" required>
                <c:forEach var="keyword" items="${keywords}">
                    <option value="${keyword.keyword_no}">${keyword.keyword_name}</option>
                </c:forEach>
            </select>

        </div>
        <div>
            <label class="form-label">첨부파일</label>
            <input type="file" name="file" multiple>    <%--여러 개의 파일을 선택할 수 있도록 multiple 추가--%>
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
