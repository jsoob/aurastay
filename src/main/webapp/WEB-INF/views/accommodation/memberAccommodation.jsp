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

</head>
<body>
<h3> 숙소 상세페이지가 정상적으로 나오고 있긴 합니다.</h3>

<div class="container">
    <h1>${dto.acmName}</h1>

</div>
<c:if test="${not empty dto}">
    <h1>${dto.acmName}</h1>
    <h3>${dto.acmAddress}</h3>
    <h4>전화번호: ${dto.acmTel}</h4>
</c:if>
<c:if test="${empty dto}">
    <p>숙소 정보를 불러오는 데 실패했습니다.</p>
</c:if>


</body>
</html>
