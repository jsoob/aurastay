<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>숙소 등록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- accAdd.CSS 파일 연결 -->
    <link rel="stylesheet" type="text/css" href="../css/acm.css">
</head>

<jsp:include page="../comm/header.jsp"/>
<jsp:include page="../comm/sidebar.jsp"/>

<body>
<div class="main-content">
    <h2>숙소 등록</h2>
    <form>
        <div class="form-group">
            <label>숙소명</label>
            <input type="text" name="acmname" placeholder="숙소명을 입력하세요" required>
        </div>
        <div class="form-group">
            <label>주소</label>
            <input type="text" name="acmaddress" placeholder="주소를 입력하세요" required>
        </div>
        <div class="form-group">
            <label>연락처</label>
            <input type="tel" name="acmtel" size=10 maxlength=11 placeholder="연락처를 입력하세요" required>
        </div>
        <div class="check-group">
            <div class="check-item">
                <label class="form-label">체크인</label>
                <input type="time" class="form-control" name="checkin" required>
            </div>
            <div class="check-item">
                <label class="form-label">체크아웃</label>
                <input type="time" class="form-control" name="checkout" required>
            </div>
        </div>

        <div class="form-group">
            <label>내용</label>
            <textarea name="acmcontents" placeholder="숙소에 대한 정보를 입력하세요" rows="4" required></textarea>
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
