<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>예약 목록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- acmList.CSS 파일 연결 -->
    <link rel="stylesheet" type="text/css" href="../css/acmList.css">

    <link rel="stylesheet" href="/css/rsrv/rsrv.css">
    <link rel="stylesheet" href="/css/rsrv/business-rsrv.css">

    <script>

        $(document).ready(function () {
            const modal = document.querySelector('.modal');

            // 모달 열기
            $("#acmName, .modal_btn").click(function () {
                selectAcmList();

                //'on' class 추가
                modal.classList.add('on');
            });

            $("#rsAcmModalTable tbody").on('click', 'td', function() {
                // console.log($(this).children());
                // console.log($(this).children().eq(0).text());

                let acmNo = $(this).closest('tr').find('td:first').text();
                console.log("acmNo = ", acmNo);

                let acmName = $(this).closest('tr').find('td').eq(1).text();
                console.log("acmName = ", acmName);

                $("#acmNo").val(acmNo);
                $("#acmName").val(acmName);

                //'on' class 제거
                modal.classList.remove('on');
            });

            //닫기 버튼을 눌렀을 때 모달팝업이 닫힘
            $(".close_btn").click(function () {
                //'on' class 제거
                modal.classList.remove('on');
            });

            $(window).click(function (event) {
                if ($(event.target).is("#rsAcmModal")) {
                    modal.classList.remove('on');
                }
            });
        });

        function selectAcmList(cp) {
            let search = $("#searchInput").val();
            let currentPage = cp === null ? 1 : cp;

            console.log("cp = ", cp);

            $.ajax({
                url: "/reservation/bAcmList",
                type: "get",
                contentType: "application/json",
                // data: JSON.stringify({businessNo: '2025032711', search: search}),
                data: {businessNo: '2136548211', currentPage: currentPage,  search: search},
                success: function (data) {
                    console.log(data);

                    $("#rsAcmModalTable #rsAcmModalBody").empty();

                    data.list.forEach(acmInfo =>
                        $("#rsAcmModalTable #rsAcmModalBody")
                            .append(
                                '<tr>' +
                                '<td>' +acmInfo.acmNo + '</td>' +
                                '<td>' +acmInfo.acmName + '</td>' +
                                '<td>' +acmInfo.acmAddress + '</td>' +
                                '<td>' + (acmInfo.acmTel).replace(/[^0-9]/g, "")
                                    .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`) + '</td>' +
                                '<td>' +acmInfo.checkinTime + '</td>' +
                                '<td>' +acmInfo.checkoutTime + '</td>' +
                                '</tr>'
                            )
                    );

                    $("#rsAcmModalTable #rsAcmModalFoot").empty();

                    let pagination = $('<div class="pagination"></div>');

                    if(data.currentPage > 1) {
                        let prevBtn = $("<button class='btn' onclick='selectAcmList("+(data.currentPage-1)+")'>이전</button>");
                        pagination.append(prevBtn);
                    }

                    let span = $('<span></span>');
                    for(let i=(data.startPage); i<=(data.endPage); i++ ) {
                        if(i == data.currentPage) {
                            span.append("<strong>"+i+"</strong>");
                        } else {
                            span.append("<button class='btn' onclick='selectAcmList("+i+")'>이전</button>");
                        }
                    }
                    pagination.append(span);

                    if(data.hasNext) {
                        let nextBtn = $("<button class='btn' onclick='selectAcmList("+(data.currentPage+1)+")'>다음</button>");
                        pagination.append(nextBtn);
                    }

                    $("#rsAcmModalTable #rsAcmModalFoot").append(pagination);


                },
                error: function () {
                    console.log("조회 실패");
                }
            });
        }

    </script>
</head>
<body id="addListPage" class="addList">

<jsp:include page="../comm/header.jsp"/>
<jsp:include page="../comm/sidebar.jsp"/>

<div class="main-content">
    <h2 class="text-center">📌 예약 목록 📌 </h2>

    <div id="rsAcmModal" class="modal">
        <div class="modal_popup min-w-500 max-w-700 w-50">
            <h3>숙소 정보</h3>

            <div class="search-container">
                <input type="text" id="searchInput" name="search" placeholder="숙소명 또는 전화번호 입력" oninput="validateSearchInput()">
                <button type="submit">검색</button>
            </div>

            <div class="form-group">
                <table id="rsAcmModalTable" class="table table-striped table-hover">
                    <thead id="rsAcmModalHead">
                        <tr>
                            <th>숙소번호</th>
                            <th>숙소이름</th>
                            <th>주소</th>
                            <th>연락처</th>
                            <th>체크인</th>
                            <th>체크아웃</th>
                        </tr>
                    </thead>

                    <tbody id="rsAcmModalBody">

                    </tbody>

                    <tfoot id="rsAcmModalFoot">

                    </tfoot>
                </table>
            </div>

            <div class="pagination">

            </div>


            <div class="footer">
                <button type="button" class="close_btn float-end">닫기</button>
            </div>
        </div>
    </div>

    <div class="search-container jc-s">
        <input type="hidden" id="acmNo" name="acmNo">
        <input type="text" id="acmName" name="acmName" placeholder="숙소명" readonly onfocus="this.blur()" class="bckc-gray">
        <button id="showAcmModal" type="button" class="btn btn-add-room modal_btn">숙소 검색</button>
    </div>

    <jsp:include page="../comm/footer.jsp"/>
</div>

</body>
</html>
