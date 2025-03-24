<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>숙소 목록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- acmList.CSS 파일 연결 -->
    <link rel="stylesheet" type="text/css" href="../css/acmList.css">

    <script>
        // 하이픈 포함 여부를 체크하는 함수
        function validateSearchInput() {
            var searchInput = document.getElementById("searchInput").value;
            var errorMessage = document.getElementById("errorMessage");

            // 하이픈이 포함된 경우
            if (searchInput.includes("-")) {
                errorMessage.style.display = "block"; // 메시지 표시
                errorMessage.innerText = "- 표시 없이 숫자만 입력하세요.";
                return false; // 폼 제출 방지
            } else {
                errorMessage.style.display = "none"; // 메시지 숨김
            }
            return true; // 폼 제출 허용
        }
    </script>
</head>
<body id="addListPage" class="addList">

<jsp:include page="../comm/header.jsp"/>
<jsp:include page="../comm/sidebar.jsp"/>

<div class="main-content">
    <h2 class="text-center">📌 숙소 목록 📌 </h2>
    <form action="acmList" method="get" onsubmit="return validateSearchInput();">
        <div class="search-container">
            <input type="text" id="searchInput" name="search" placeholder="숙소명 또는 전화번호 입력" oninput="validateSearchInput()">
            <button type="submit">검색</button>
        </div>
        <small id="errorMessage"></small> <!-- 에러 메시지 -->

        <div class="form-group">
            <table class="table table-striped table-hover">
                <tr>
                    <th>숙소번호</th>
                    <th>숙소이름</th>
                    <th>주소</th>
                    <th>연락처</th>
                    <th>체크인</th>
                    <th>체크아웃</th>
                </tr>
                <c:forEach var="dto" items="${list}">
                    <tr>
                        <td>${dto.acmNo}</td>
                        <td><a href="acmInfo?acmNo=${dto.acmNo}">${dto.acmName}</a></td>
                        <td>${dto.acmAddress}</td>
                        <td>${dto.acmTel.substring(0, 3)}-${dto.acmTel.substring(3, 7)}-${dto.acmTel.substring(7)}</td>
                        <td>${dto.checkinTime}</td>
                        <td>${dto.checkoutTime}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </form>

    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="acmList?currentPage=${currentPage - 1}">이전</a>
        </c:if>

        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <strong>${i}</strong>
                </c:when>
                <c:otherwise>
                    <a href="acmList?currentPage=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${hasNext}">
            <a href="acmList?currentPage=${endPage + 1}">다음</a>
        </c:if>
    </div>

    <jsp:include page="../comm/footer.jsp"/>
</div>

</body>
</html>
