<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/css/rsrv/rsrv-cancelModal.css">

<div id="rsResetModal" class="modal cancelModal">
    <div class="modal_popup min-w-500 max-w-700 w-50">
        <h3 class="d-fr mt-0">예약 취소 요청 정보
            <span class="cancel"></span>
            <button type="button" class="close_btn float-end">닫기</button>
        </h3>

        <div class="form-group">
            <div class="modal-body my-20">
                <div class="row mb-3">
                    <div class="col-sm-3">
                        <div class="input-group">
                            <label>예약번호</label>
                            <input type="text" name="rsNo" class="form-control fs-10 bckc-gray" value="" readonly>
                        </div>
                    </div>
                    <div class="col-sm-8">
                        <div class="input-group">
                            <label>예약 정보</label>
                            <input type="text" name="rsInfoText" class="form-control fs-10 bckc-gray" value="" readonly>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="input-group">
                        <label>취소 사유</label>
                        <div class="mb-3" style="padding-right: 41px;">
                            <textarea id="cancelReasons" name="cancelReasons" class="py-2 box-border bckc-gray" disabled rows="3" required></textarea>
                        </div>
                        <div class="row">
                            <div class="col-sm-3">
                                <label>취소 요청일</label>
                                <input type="text" name="cancelDate" class="form-control fs-10 bckc-gray" value="" readonly>
                            </div>
                            <div class="col-sm-3">
                                <label>취소 응답일</label>
                                <input type="text" name="cancelRespDate" class="form-control fs-10 bckc-gray" value="" readonly>
                            </div>
                            <div class="col-sm-3">
                                <label>상태</label>
                                <input type="text" name="cancelStatus" class="form-control fs-10 bckc-gray" value="" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">

            </div>
        </div>
    </div>
</div>