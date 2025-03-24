<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="roomModal" class="modal" style="display:none;">
    <div class="modal-content">
        <span class="close" id="modalClose">&times;</span>


        <h2>객실 정보 추가</h2>

        <div class="form-group">
            <h3>객실 정보</h3>
            <label>객실명</label>
            <input type="text" name="roomName[]" placeholder="객실명을 입력하세요" required>

            <label>객실 수량</label>
            <input type="number" name="roomQty[]" placeholder="객실 수량을 입력하세요" required min="0">

            <label>최대 인원 수</label>
            <input type="number" name="roomCapacity[]" placeholder="객실 최대 인원수를 선택해주세요" required min="0">

            <label>가격</label>
            <input type="text" name="roomPrice[]" placeholder="가격을 입력하세요" required>

            <label>할인율</label>
            <input type="text" name="roomDiscount[]" placeholder="할인율을 입력하세요" required>

            <label>상세설명</label>
            <textarea name="roomContents[]" placeholder="객실에 대한 상세정보를 입력하세요" rows="4" required></textarea>

            <label>View Type</label>
            <select name="roomViewType[]" required>
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
    </div>
</div>