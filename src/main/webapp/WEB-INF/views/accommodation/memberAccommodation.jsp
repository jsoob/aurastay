<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

    <title>${dto.acmName} 상세페이지</title>

    <!-- main.CSS 파일 연결 -->
    <link rel="stylesheet" type="text/css" href="../css/main.css">

</head>

<jsp:include page="../main/header.jsp"/>

<body>
<h3>숙소 상세페이지가 정상적으로 나오고 있습니다.</h3>

<div class="container">
    <h1>${dto.acmName}</h1>

    <!-- 숙소 이미지 표시 -->
    <div class="info-card">
        <label class="form-label">숙소 이미지</label>
        <c:if test="${not empty images}">
            <div class="row">
                <c:forEach var="image" items="${images}">
                    <div class="col-4">
                        <img src="/accommodation/views/${image.filename}" alt="숙소 이미지" class="img-fluid"
                             style="width:100%; height:auto; cursor: pointer;"/>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty images}">
            <p>이미지가 없습니다.</p>
        </c:if>
    </div>

    <%-- 추가적인 이미지 표시 (캐러셀 등) --%>
    <c:if test="${not empty accommodations}">
        <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <c:forEach var="accommodation" items="${accommodations}" varStatus="imgStatus">
                    <div class="carousel-item ${imgStatus.first ? 'active' : ''}">
                        <img src="/accommodation/views/${accommodation.filename}" class="d-block w-100" alt="숙소 이미지">
                    </div>
                </c:forEach>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">이전</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">다음</span>
            </button>
        </div>
    </c:if>
    <%-- 숙소 이미지 끝 --%>

    <%-- 숙소 정보 표시 --%>
    <c:if test="${not empty dto}">
        <h3>${dto.acmAddress}</h3>
        <h4>전화번호: ${dto.acmTel}</h4>
        <h4>특징(타이틀제목은 나중에 삭제할 예정): ${dto.contents}</h4>
        <h4>체크인 ${dto.checkinTime}</h4>
        <h4>체크아웃 ${dto.checkoutTime}</h4>
        <h4>사업자번호 ${dto.businessNo}</h4>
        <h4>편의시설 ${dto.amenitiesName}</h4>
    </c:if>
    <c:if test="${empty dto}">
        <p>숙소 정보를 불러오는 데 실패했습니다.</p>
    </c:if>

    <c:if test="${not empty categories}">
        <h4>카테고리:</h4>
        <ul>
            <c:forEach var="category" items="${categories}">
                <li>${category.categoryName}</li> <!-- 카테고리 번호 출력 -->
            </c:forEach>
        </ul>
    </c:if>

    <c:if test="${not empty keywords}">
        <h4>키워드:</h4>
        <ul>
            <c:forEach var="keyword" items="${keywords}">
                <li>${keyword.keywordName}</li> <!-- 키워드 이름 출력 -->
            </c:forEach>
        </ul>
    </c:if>

<%-- 숙소 정보 불러오기 끝 --%>

    <%-- 객실 정보 표시 --%>
    <c:if test="${not empty room}">
        <h2>객실 정보</h2>
        <c:forEach var="r" items="${room}">
            <h4>객실명: ${r.roomName}</h4>
            <p>객실 수: ${r.roomQty}</p>
            <p>객실 가격: ${r.roomPrice}</p>
            <p>객실 할인: ${r.roomDiscount}</p>
            <p>객실 설명: ${r.roomContents}</p>
            <p>최대 수용 인원: ${r.roomCapacity}</p>
            <hr>
        </c:forEach>
    </c:if>
    <c:if test="${empty room}">
        <p>객실 정보가 없습니다.</p>
    </c:if>
    <%-- 객실 정보 불러오기 끝 --%>


</div>

</body>

<jsp:include page="../main/footer.jsp"/>

</html>
