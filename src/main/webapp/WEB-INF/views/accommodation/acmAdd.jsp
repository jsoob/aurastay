<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>숙소 등록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- accAdd.CSS 파일 연결 -->
    <link rel="stylesheet" type="text/css" href="../css/acm.css">

    <script>

        $(document).ready(function () {
            // 파일 입력 필드 추가
            $("#btn").click(function () {
                let newFileInput = '<input type="file" name="file[]"><br>';
                $(this).before(newFileInput);
            });

            // 모달 열기
            $("#showModal").click(function () {
                $("#roomModal").fadeIn();
            });

            // 모달 닫기
            $("#closeModal, .close ,#saveButton").click(function () {
                $("#roomModal").fadeOut();
            });

            // 모달 바깥 영역 클릭 시 닫기
            $(window).click(function (event) {
                if ($(event.target).is("#roomModal")) {
                    $("#roomModal").fadeOut();
                }
            });
        });

        // 숫자 입력을 제한하는 함수 (객실 수량, 최대 인원수 : 수량을 체크할 때 -(마이너스) 값이 올 수 없도록 설정)
        function preventNegativeInput(event) {
            if (event.target.value < 0) {
                event.target.value = 0;     // 음수가 입력되면 0으로 설정
            }
        }

        // 각 입력 필드에 음수 입력 방지 기능 추가 (객실 수량, 최대 인원수 input 발생시 해당 함수 실행)
        document.getElementById("roomQty").addEventListener("input", preventNegativeInput);
        document.getElementById("roomCapacity").addEventListener("input", preventNegativeInput);
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
                <input type="time" class="form-control" name="checkinTime" value="${dto.checkinTime}" required>
            </div>
            <div class="check-item">
                <%--체크아웃--%>
                <label class="form-label">체크아웃</label>
                <input type="time" class="form-control" name="checkoutTime" value="${dto.checkoutTime}" required>
            </div>
        </div>
        <br>
        <div class="form-group">
            <%--내용--%>
            <label>내용</label>
            <label>
                <textarea name="contents" placeholder="숙소에 대한 정보를 입력하세요" rows="4" required></textarea>
            </label>
        </div>
        <div>
            <div class="form-group">
                <%-- 카테고리 --%>
                <label>Category</label>
                <div class="checkbox-group">
                    <c:forEach var="category" items="${categories}">
                        <label>
                            <input type="radio" name="categoryNo"
                                   value="${category.categoryNo}">${category.categoryName}</label>
                        <%--                        <c:out value="${categories}" default="categories 없는데요"></c:out>--%>
                    </c:forEach>
                    <%--                    <label><input type="checkbox" name="category" value="호텔"> 호텔</label>--%>
                    <%--                    <label><input type="checkbox" name="category" value="리조트"> 리조트</label>--%>
                    <%--                    <label><input type="checkbox" name="category" value="풀빌라"> 풀빌라</label>--%>
                    <%--                    <label><input type="checkbox" name="category" value="펜션"> 펜션</label>--%>
                    <%--                    <label><input type="checkbox" name="category" value="한옥"> 한옥</label>--%>
                    <%--                    <label><input type="checkbox" name="category" value="캠핑장"> 캠핑장</label>--%>
                    <%--                    <label><input type="checkbox" name="category" value="게스트하우스"> 게스트하우스</label>--%>
                </div>
            </div>


            <label>편의시설</label> <%--슬리퍼, 암막커튼, 에어컨, 방음.. 구분지어서 생각해볼 것--%>
            <%-- 여기 편의시설 정보 추가해야한다 --%>

        </div>

        <jsp:include page="roomModal.jsp"/>

        <br>
        <button id="showModal" type="button" class="btn btn-add-room"> <%--juery를 사용하여 modal창으로 보여주기--%>
            객실 정보 추가
        </button>
        <br><br>


        <div class="form-group">
            <%-- 키워드 --%>
            <label>Keyword</label>
            <div class="checkbox-group">
                <c:forEach var="keyword" items="${keywords}">
                    <label><input type="checkbox" name="keywordNo[]" <%--여러 개 선택해서 처리될 때는 배열로 받기 때문에 []--%>
                                  value="${keyword.keywordNo}">${keyword.keywordName}</label>
                    <%--                        <c:out value="${keywords}" default="keywords 없음!" />--%>
                </c:forEach>
                <%--                    <label><input type="checkbox" name="keyword" value="명동"> 명동</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="홍대"> 홍대</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="강남"> 강남</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="종로"> 종로</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="잠실"> 잠실</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="인천"> 인천</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="속초"> 속초</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="강릉"> 강릉</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="보성"> 보성</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="부산"> 부산</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="대구"> 대구</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="대전"> 대전</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="목포"> 목포</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="포항"> 포항</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="전주"> 전주</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="수원"> 수원</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="양양"> 양양</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="광안리"> 광안리</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="해운대"> 해운대</label>--%>
                <%--                    <label><input type="checkbox" name="keyword" value="제주도"> 제주도</label>--%>

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

        <div class="container">
            <div class="pink-box">
                <%--키워드 아래에 첨부파일과 버튼을 배치하기--%>
                <div clas="form-group">
                    <label class="form-label">첨부파일</label>
                    <input type="file" name="files" multiple> <%--여러 개의 파일을 선택할 수 있도록 multiple 추가--%>
                    <input type="button" value="추가" id="btn">
                </div>

            </div>

            <div class="btn-container">
                <button type="submit" class="btn btn-submit">등록</button>
                <button type="reset" class="btn btn-cancel">취소</button>
            </div>

        </div>
    </form>
</div>

</body>

<jsp:include page="../comm/footer.jsp"/>
</html>
