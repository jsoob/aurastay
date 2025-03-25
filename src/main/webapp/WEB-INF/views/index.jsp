<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>index</title>
</head>
<body>
    <h3>index</h3>
    <ul>
        <li><a href="reservation/album_ex">숙소 목록보기</a></li>
        <li><a href="reservation/stays?accommodationNo=2&roomNo=1&checkin=2025-03-10&checkout=2025-03-15">숙소 예약하기(수량x)</a></li>
        <li><a href="reservation/stays?accommodationNo=2&roomNo=1&checkin=2025-03-19&checkout=2025-03-20">숙소 예약하기(잔여1)</a></li>
        <li><a href="reservation/stays?accommodationNo=2&roomNo=1&checkin=2025-03-20&checkout=2025-03-25">숙소 예약하기(잔여빵빵)</a></li>
        <li><a href="reservation/mystays">예약 조회하기</a></li>
        <li><a href="reservation/oldmystays">예약 조회하기(NODATA)</a></li>
    </ul>
</body>
</html>