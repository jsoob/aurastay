<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>숙소 등록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            crossorigin="anonymous"></script>
    <style>
        .main-content {
            width: calc(100% - 250px); /* 사이드바 제외한 공간 꽉 차게 설정 */
            margin-left: auto;
            margin-right: auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .btn {
            padding: 10px;
            font-size: 16px;
        }
    </style>
</head>
<jsp:include page="../comm/header.jsp"/>
<jsp:include page="../comm/sidebar.jsp"/>
<body>


<div class="main-content">
    <h2>숙소 등록</h2>
    <form>
        <div class="mb-3">
            <label class="form-label">숙소명</label>
            <input type="text" class="form-control" name="acmname" placeholder="숙소명을 입력하세요" required>
        </div>
        <div class="mb-3">
            <label class="form-label">주소</label>
            <input type="text" class="form-control" name="acmaddress" placeholder="주소를 입력하세요" required>
        </div>
        <div class="mb-3">
            <label class="form-label">연락처</label>
            <input type="tel" class="form-control" name="acmtel" size=10 maxlength=11 placeholder="연락처를 입력하세요" required>
        </div>
        <div class="mb-3">
            <label class="form-label">체크인</label>
            <input type="time" class="form-control" name="checkin" required>
        </div>
        <div class="mb-3">
            <label class="form-label">체크아웃</label>
            <input type="time" class="form-control" name="checkout" required>
        </div>
        <div class="mb-3">
            <label class="form-label">내용</label>
            <textarea class="form-control" name="acmcontents" placeholder="숙소에 대한 정보를 입력하세요" rows="4"
                      required></textarea>
        </div>
        <div>
            <%--숙박정보에 따른 이미지 파일 첨부--%>
        </div>
        <div>
            <button type="submit" class="btn btn-primary">등록</button>
            <button type="reset" class="btn btn-secondary">취소</button>
        </div>
    </form>
</div>


</body>
<jsp:include page="../comm/footer.jsp"/>
</html>
