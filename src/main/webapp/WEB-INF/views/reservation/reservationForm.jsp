<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>예약 요청</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <link rel="stylesheet" href="/css/rsrv/rsrv.css">
    <script>

        $(() => {
            const toastTrigger = document.getElementById('rsrvCommBtn');
            const toastLiveExample = document.getElementById('rsrvComm');
            if (toastTrigger) {
                toastTrigger.addEventListener('click', () => {
                    const toast = new bootstrap.Toast(toastLiveExample);
                    toast.show();
                });
            }
        });
    </script>
</head>
<body>
<h3><a href="/">목록가기</a></h3>

<%-- 실제 html --%>
<div class="container rsrv-container">
    <div class="rsrv-title-container">
        <h1><a class="text-decoration-none text-dark" href="/accomodation"><span
                class="px-2 rsrv-back-circleBtn fs-3 fw-bold"><</span></a> 예약 요청</h1>
    </div>

    <div class="d-flex p-4 gap-4 py-md-5 justify-content-center"> <%-- align-items-center --%>

        <div class="left-container">

            <div class="last-rsrv">
                <div class="box-border mb-3">
                    <div class="row px-2">
                        <div class="row fs-5 pb-1">
                            <div class="col-sm-12">
                                <span>마지막 객실</span> <i class="bi-alarm" style="font-size: 1.5rem; color: #ff3665;"></i>
                            </div>
                        </div>
                        <div class="fs-6">선택하신 날짜에 이 요금으로 이용 가능한 마지막 AuraStay 객실 입니다.</div>
                    </div>
                </div>

            </div>


            <h3 class="mb-4">예약 정보</h3>
            <div class="box-border mb-3 ps-4">
                <div class="row mb-3">
                    <div class="fs-5 mb-3">룸 타입</div>
                    <div class="fs-5 fw-bold">E°SO 이소하우스 60평 독채</div>
                    <div class="fs-6 fw-bold">디럭스 더블 - 저층 배정(소나무 or 레이크 뷰 랜덤 배정)</div>
                </div>
                <div class="row mb-3">
                    <div class="col-sm-6">
                        <div class="fs-10">체크인</div>
                        <div class="">
                            <div class="fw-bold">2025.03.10 (월)</div>
                            <div class="">15:00</div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="fs-10">체크아웃</div>
                        <div class="">
                            <div class="fw-bold">2025.03.11 (화)</div>
                            <div class="">11:00</div>
                        </div>
                    </div>

                    <div class="col-sm-6">
                        <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="none" size="1.4" unit="rem" viewBox="0 0 24 24" class="platform-site-11026c0">
                            <%-- 머리 --%>
                            <path fill="#1A1A1A" fill-rule="evenodd" d="M12.25 4.414a3.75 3.75 0 1 0 0 7.5 3.75 3.75 0 0 0 0-7.5M7 8.164a5.25 5.25 0 1 1 10.5 0 5.25 5.25 0 0 1-10.5 0" clip-rule="evenodd"></path>
                            <%-- 몸통 --%>
                            <path fill="#1A1A1A" fill-rule="evenodd" d="M19.19 16.539c-3.721-4.094-10.159-4.094-13.88 0a4.07 4.07 0 0 0-1.06 2.74v1.017c0 .203.165.368.368.368h15.264a.37.37 0 0 0 .368-.368v-1.017c0-1.014-.378-1.99-1.06-2.74M4.2 15.529c4.316-4.748 11.784-4.748 16.1 0a5.57 5.57 0 0 1 1.45 3.75v1.017a1.87 1.87 0 0 1-1.868 1.868H4.618a1.87 1.87 0 0 1-1.868-1.868v-1.017c0-1.387.517-2.723 1.45-3.75" clip-rule="evenodd"></path>
                        </svg>
                        <span class="fs-10">기준 2명 / 최대 2명</span>
                    </div>
                </div>
            </div>
            <%-- 숙소 예약 정보 끝 --%>

            <div class="box-border mb-3">
                <div class="row px-2 mb-3">
                    <div class="fs-6 mb-3">특별 요청하기 (선택사항)</div>
                    <div class="fs-10 mb-2">특별 요청의 반영 여부는 숙소의 개별적인 사정에 따라 결정되며 보장되지 않습니다.</div>
                     <div class="row mb-2">
                         <div class="col-sm-6 ">
                             <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1">
                             <label class="form-check-label" for="inlineCheckbox1">금연 객실을 원합니다.</label>
                         </div>
                         <div class="col-sm-6 ">
                             <input class="form-check-input" type="checkbox" id="inlineCheckbox2" value="option1">
                             <label class="form-check-label" for="inlineCheckbox2">트윈 베트를 원합니다.</label>
                         </div>
                     </div>
                     <div class="row mb-2">
                         <div class="col-sm-6 ">
                             <input class="form-check-input" type="checkbox" id="inlineCheckbox3" value="option1">
                             <label class="form-check-label" for="inlineCheckbox3">늦은 체크인을 하기 원합니다.</label>
                         </div>
                         <div class="col-sm-6 ">
                             <input class="form-check-input" type="checkbox" id="inlineCheckbox4" value="option1">
                             <label class="form-check-label" for="inlineCheckbox4">넓은 침대를 원합니다.</label>
                         </div>
                     </div>
                     <div class="row mb-2">
                         <div class="col-sm-6 mb-3">
                             <input class="form-check-input" type="checkbox" id="inlineCheckbox5" value="option1">
                             <label class="form-check-label" for="inlineCheckbox5">고층 객실을 원합니다.</label>
                         </div>
                         <hr>
                     </div>

                     <div class="row">
                         <div class="mb-2">그 외, 추가 요청을 입력하시기 바랍니다.</div>
                         <div >
                             <textarea name="" class="py-2 box-border" rows="3"></textarea>
                         </div>
                     </div>
                </div>
            </div>
            <%-- 특별 요청하기 끝 --%>

            <div class="box-border mb-3">
                <div class="row px-2 mb-3">
                    <div class="fs-6 mb-3">기본 규칙</div>
                    <div class="fs-10 mb-2">훌륭한 게스트가 되기 위한 몇 가지 간단한 규칙을 지켜주실 것을 모든 게스트에게 당부드리고 있습니다.</div>
                    <div class="row mb-2 ps-4">
                        <ul class="fs-10 ps-4">
                            <li>
                                숙소 이용규칙을 준수하세요.
                            </li>
                            <li>
                                호스트의 집도 자신의 집처럼 아껴주세요.
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
        <%-- left 끝 --%>

        <div class="right-container">
            <div class="fs-4 mb-3">숙소</div>
            <div style="height: 34%;">
                <ul class="rsv dropdown-menu d-grid gap-1 p-4"><%-- data-bs-theme="light" --%> <%-- bottom: -150px; --%>
                    <li class="d-flex gap-2 pb-2 lh-sm text-start">
                        <img class="acm-img-thumbnail radius_12"
                             src="https://a0.muscache.com/im/pictures/0f52b46a-16fe-472f-a04b-eec52680f162.jpg?aki_policy=large"
                             alt="">
                        <div class="w-100 ms-1">
                            <strong class="d-block">E°SO 이소하우스 60평 독채</strong>
                            <p class="mb-2">펜션</p>
                            <p class="fs-10 mb-2">강원도 강릉시 창해로 307</p>
                            <div class="float-start me-2">
                                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor"
                                     class="mb-1 bi bi-star-fill" viewBox="0 0 16 16">
                                    <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                </svg>
                                4.93(114)
                            </div>
                            <div class="fw-bold">•<span class="ms-1">해변(키워드명)</span></div>
                        </div>
                    </li>

                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li class="fs-5">요금 세부정보</li>
                    <%--                    <li>₩544,500 x 5박 ₩2,722,500</li>--%>
                    <li class="d-flex gap-2 py-1 lh-sm fs-10 pe-2">
                        <div class="col-sm-8 text-start"><span name="">₩544,500</span> x <span>5</span>박</div>
                        <div class="col-sm-4 text-end">₩2,722,500</div>
                    </li>

                    <li class="d-flex gap-2 py-1 lh-sm fs-10 pe-2">
                        <div class="col-sm-8 text-start">
                            <button id="rsrvCommBtn" class="btn-none text-decoration-underline text-dark px-0">AURASTAY 서비스
                                수수료
                            </button>
                        </div>
                        <div class="col-sm-4 text-end">₩422,789</div>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li  class="d-flex gap-2 py-1 lh-sm pe-2">
                        <div class="col-sm-8 text-start">총액 <span class="fw-bold">(KRW)</span>
                        </div>
                        <div class="col-sm-4 text-end"><span class="fw-bold">₩3,145,289</span></div>
                    </li>
                </ul>

                <%--                <div aria-live="polite" aria-atomic="true" class="d-flex justify-content-center align-items-center w-100">--%>

                <div class="toast-container p-3 top-180" style="top: 100px; position: relative;">
                    <div id="rsrvComm" class="toast shadow-lg" role="alert" aria-live="assertive" aria-atomic="true" style="border: 2px solid #e3e3e3;">
                        <div class="toast-header p-3 ps-2">
                            <div class="d-flex">
                                <button type="button" class="btn-close m-2 my-0" data-bs-dismiss="toast" aria-label="Close"></button>
                                수수료는 에어비앤비 플랫폼을 운영하고 연중무휴 고객 지원과 같은 다양한 서비스를 제공하는데 사용됩니다.
                                부가가치세(VAT)가 포함된 가격입니다.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%-- 드롭메뉴 --%>

            <div class="rsrv-btn-div">
                <button class="btn btn-primary btn-pink p-3">예약 신청 및 결제</button>
            </div>
        </div>
        <%-- right 끝 --%>
    </div>
</div>
</body>
</html>