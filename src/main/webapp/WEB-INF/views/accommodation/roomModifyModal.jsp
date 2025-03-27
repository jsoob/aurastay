<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script>
    // 저장버튼이 클릭되면 정보를 서버로 전송 -> 수정할 수 있게끔 함수 구현
    function addRoomInfo() {
        //     $("input[name='roomReadNo']").val($("input[name=roomNo]")).val();
        //     $("input[name='roomReadName']").val($("input[name=roomName]").val());
        //     $("input[name='roomReadQty']").val($("input[name=roomQty]").val());
        //     $("input[name='roomReadCapacity']").val($("input[name=roomCapacity]").val());
        //     $("input[name='roomReadPrice']").val($("input[name=roomPrice]").val());
        //     $("input[name='roomReadDiscount']").val($("input[name=roomDiscount]").val());
        //     $("textarea[name='roomReadContents']").val($("textarea[name='roomContents']").val());
        //     $("select[name='roomReadViewType']").val($("select[name=roomViewType]").val());
        //
        //     let pos = $("#view").prop("selectedIndex");
        //     console.log(pos)
        //
        //     $("#roomReadViewType option:eq("+pos +")").prop("selected", true);
        //     console.log($("#roomReadViewType option:eq(pos)"));
        //
        // }

        const roomData = {
            roomNo: $("input[name='roomNo']").val(),
            acmNo: $("input[name='acmNo']").val(),
            roomName: $("input[name='roomName']").val(),
            roomQty: $("input[name='roomQty']").val(),
            roomCapacity: $("input[name='roomCapacity']").val(),
            roomPrice: $("input[name='roomPrice']").val(),
            roomDiscount: $("input[name='roomDiscount']").val(),
            roomContents: $("textarea[name='roomContents']").val(),
            roomViewType: $("select[name='roomViewType']").val()
        };


        console.log(roomNo);
        console.log(acmNo);

        $.ajax({
            url: '/room/roomUpdate', // 객실 수정 URL
            method: 'POST',
            contentType: 'application/json', // JSON 형식으로 데이터 전송
            data: JSON.stringify(roomData), // JSON 형식으로 변환
            success: function (response) {
                alert("객실 정보가 수정되었습니다.");
                $("#roomModifyModal").fadeOut(); // 모달 닫기
                location.reload(); // 페이지 새로 고침
            },
            error: function (error) {
                alert("수정에 실패했습니다.");
                console.error(error);
            }
        });
    }


</script>
<div id="roomModifyModal" class="modal" style="display:none;">
    <div class="modal-content">
        <span class="close" id="modalClose">&times;</span>

        <h2>객실 정보 수정</h2>

        <form id="roomModifyForm">
            <%-- 객실 번호는 수정하지 못하도록 hidden을 주면 되고.. --%>
            <input type="hidden" name="roomNo" id="roomNo">
                <input type="hidden" name="acmNo" id="acmNo">


            <div class="form-group">

                <h3>객실 정보</h3>
                <%--            <label>객실번호</label>--%>
                <%--            <input type="text" name="roomNo">--%>

                <label>객실명</label>
                <input type="text" name="roomName" id="roomName" placeholder="객실명을 입력하세요" required>

                <label>객실 수량</label>
                <input type="number" name="roomQty" id="roomQty" placeholder="객실 수량을 입력하세요" required min="0">

                <label>최대 인원 수</label>
                <input type="number" name="roomCapacity" id="roomCapacity" placeholder="객실 최대 인원수를 선택해주세요" required
                       min="0">

                <label>가격</label>
                <input type="text" name="roomPrice" id="roomPrice" placeholder="가격을 입력하세요" required>

                <label>할인율</label>
                <input type="text" name="roomDiscount" id="roomDiscount" placeholder="할인율을 입력하세요" required>

                <label>상세설명</label>
                <textarea name="roomContents" id="roomContents" placeholder="객실에 대한 상세정보를 입력하세요" rows="4"
                          required></textarea>

                <label>View Type</label>
                <select name="roomViewType" id="roomViewType" required>
                    <option value="none">숙소의 대표적인 뷰 타입을 선택해주세요</option>
                    <option value="cityView">City View (시티뷰)</option>
                    <option value="mountainView">Mountain View (마운틴뷰)</option>
                    <option value="oceanView">Ocean View (오션뷰)</option>
                    <option value="poolView">Pool View (수영장뷰)</option>
                    <option value="gardenView">Garden View (정원뷰)</option>
                </select>
            </div>

            <div class="modal-footer">
                <input type="button" id="closeModal" class="btn btn-modalclose" value="닫기">
                <input type="button" id="saveButton" class="btn btn-modalsave" value="저장" onclick="addRoomInfo()">
            </div>
        </form>
    </div>
</div>