package kr.co.aura.aurastay.controller;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;
import kr.co.aura.aurastay.dto.*;
import kr.co.aura.aurastay.service.AcmRoomService;
import kr.co.aura.aurastay.service.RefundService;
import kr.co.aura.aurastay.service.ReservationService;
import kr.co.aura.aurastay.util.ReservationUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.*;

@Slf4j
@Controller
@RequestMapping("/reservation")
@RequiredArgsConstructor
public class ReservationController {
    private final ReservationService reservationService;
    private final AcmRoomService acmRoomService;
    private final RefundService refundService;

    @Value("${payment.imp.api.key}") // 고객사 식별코드
    private String apiKey;

    @Value("${payment.imp.api.secret}")
    private String secretKey;
//
//    private final RefundService refundService;
//    private IamportClient iamportClient;
//    @PostConstruct
//    public void init() {
//        this.iamportClient = new IamportClient(apiKey, apiSecret);
//    }

    @GetMapping("/stays")
    public String stays(@RequestParam("accommodationNo") int acmNo, @RequestParam("roomNo") int roomNo, @RequestParam("checkin") String checkinDate, @RequestParam("checkout") String checkoutDate, HttpSession session, Model model) {

        String url = "reservation/reservationForm";

        int countDay = ReservationUtil.getCheckDay(checkinDate, checkoutDate);

        model.addAttribute("checkinDate", checkinDate);
        model.addAttribute("checkoutDate", checkoutDate);
        model.addAttribute("countDay", countDay);

        int roomCountMin = 0;

        // 객실 수량 확인
        for (int i=0; i<countDay; i++) {
            HashMap<String, Object> rsrvMap = ReservationUtil.getRoomCheck(checkinDate, acmNo, roomNo, i);

            int acmCount = reservationService.getRemainingRooms(rsrvMap); // 숙소 번호, 룸 번호, 해당 일자
            if(i==0) roomCountMin = acmCount;

//            # '2025-03-10', 2, from -> 0
//            # '2025-03-11', 2, from -> 1
//            # '2025-03-12', 2, from -> 5
//            # -> 기간내에 마감된 객실이 있습니다.

            roomCountMin = Math.min(roomCountMin, acmCount); // 제일 작은 수량
        }

        // 객실 수량이 없으면 다시 숙소 상세보기로 이동함.
        // 0개이면 애초에 숙소 상세보기에서 예약하기 버튼 활성화 안함. -> 근데 고민하다가 누를 수 있으니 누르면 다시 리다이렉트 -> 해당 숙소 정보로 가기
        if(roomCountMin == 0){
//            url = "redirect:/reservation/album_ex";
            url = "redirect:/accommodation/memberAccommodation/"+acmNo;
        }
        // 숙소 수량 count
        model.addAttribute("acmCount", roomCountMin); // 객실 수량이 1이면..마지막 객실 알림 / 2~ 이상이면 알림 없음.

        AcmDTO acmDTO = AcmDTO.builder()
                .acmNo(acmNo)
                .roomNo(roomNo)
                .build();
        AcmDTO roomMap = acmRoomService.selectRoomDetail(acmDTO);

        model.addAttribute("acmDetail", roomMap); // 모델에 추가
        model.addAttribute("category", roomMap);   // 카테고리 목록 추가
        model.addAttribute("keyword", roomMap);     // 키워드 목록 추가
        model.addAttribute("roomDetail", roomMap);  // 객실 정보를 모델에 추가

        Object obj = session.getAttribute("dto");
//        System.out.println("member = " + obj);
//        int memberNo = ((MemberDTO) obj).getMemberNo();
        MemberDTO dto = ((MemberDTO) obj);
        model.addAttribute("dto", dto);


        // 특별 요청 예약
        List<SpecialRequestDTO> specialRequests = reservationService.getSpecialRequests();
        model.addAttribute("specialRequests", specialRequests);

        return url;
    }

    // 1번 에러
    // Content-Type 'application/x-www-form-urlencoded;charset=UTF-8' is not supported
    
    // 2번 에러
    // Resolved [org.springframework.http.converter.HttpMessageNotReadableException: JSON parse error:
    // Unrecognized token 'payment': was expecting (JSON String, Number, Array, Object or token 'null', 'true' or 'false')]
    @PostMapping("/payment")
    @ResponseBody
    public String payment(@RequestBody Map<String, Object> jsonData ) {
        // , @RequestParam(value = "specialRequests", required = false) Integer[] specialRequests, @ModelAttribute ReservationDTO reservationDTO
        log.info("jsonData >>>>>>>>>>>>>>>>>>>>>>>>>> {}", jsonData);
//      jsonData >>>>>>>>>>>>>>>>>>>>>>>>>>
//      {payment={status=PAID, id=1-385219, transactionId=0195b214-2f8a-2da1-7d45-b2a5d94b79e7, merchantId=merchant-bf82b603-be66-4474-9cc1-03d3199fa24c, storeId=store-4b8d38b9-6775-4065-9eb0-6d3d89d63815, method={type=PaymentMethodEasyPay, provider=KAKAOPAY, easyPayMethod={type=PaymentMethodEasyPayMethodCharge}}, channel={type=TEST, id=channel-id-abe78f42-5b5b-4a97-9bb8-c582e7792623, key=channel-key-6509c147-0348-470a-a3b5-5cb7138919dc, name=토스페이먼츠 결제창 일반결제, pgProvider=TOSSPAYMENTS, pgMerchantId=iamporttest_3}, version=V2, requestedAt=2025-03-20T05:43:42.24716878Z, updatedAt=2025-03-20T05:44:07.094514771Z, statusChangedAt=2025-03-20T05:44:07.065193154Z, orderName=스카이베이 호텔 경포, amount={total=1500000, taxFree=0, vat=136364, supply=1363636, discount=0, paid=1500000, cancelled=0, cancelledTaxFree=0}, currency=KRW, customer={id=port-customer-id-0195b214-2f93-ad54-dc47-5e081a5a4c44, name=김우씨, email=kmhe0128@naver.com, phoneNumber=01011111111}, promotionId=, isCulturalExpense=false, country=MT, paidAt=2025-03-20T05:44:07.065193154Z, pgTxId=tiamp20250320144343qG2I6, pgResponse={"mId":"tiamporttest_3","lastTransactionKey":"txrd_a01jps193xfn59tj0e3gbsf8jfh","paymentKey":"tiamp20250320144343qG2I6","orderId":"1-385219","orderName":"스카이베이 호텔 경포","taxExemptionAmount":0,"status":"DONE","requestedAt":"2025-03-20T14:43:43+09:00","approvedAt":"2025-03-20T14:44:06+09:00","useEscrow":false,"cultureExpense":false,"card":null,"virtualAccount":null,"transfer":null,"mobilePhone":null,"giftCertificate":null,"cashReceipt":null,"cashReceipts":null,"discount":null,"cancels":null,"secret":"ps_0RnYX2w5327zNGQpdpaKVNeyqApQ","type":"NORMAL","easyPay":{"provider":"카카오페이","amount":1500000,"discountAmount":0},"country":"KR","failure":null,"isPartialCancelable":true,"receipt":{"url":"https://dashboard.tosspayments.com/receipt/redirection?transactionId=tiamp20250320144343qG2I6&ref=PX"},"checkout":{"url":"https://api.tosspayments.com/v1/payments/tiamp20250320144343qG2I6/checkout"},"transactionKey":"txrd_a01jps193xfn59tj0e3gbsf8jfh","currency":"KRW","totalAmount":1500000,"balanceAmount":1500000,"suppliedAmount":1363636,"vat":136364,"taxFreeAmount":0,"method":"간편결제","version":"2022-07-27","metadata":null}, receiptUrl=https://dashboard.tosspayments.com/receipt/redirection?transactionId=tiamp20250320144343qG2I6&ref=PX, disputes=[]}, guestName=김우씨, guestPhoneNumber=01011111111, guestEmail=kmhe0128@naver.com, residenceCountry=몰타, memberNo=1, roomNo=1, reservationDetailsRequest=gggggg, acmNo=2, specialRequests=[1, 3, 5], orderName=스카이베이 호텔 경포, totalAmount=500000}

        int status = reservationService.addReservation(jsonData);

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("status", status);

         return jsonObject.toJSONString();
         // "redirect:/reservation/mystays";
    }

    @GetMapping("/mystays")
    public String myStays(@RequestParam(value = "rsStatus", defaultValue = "1") int reservationStatus, HttpSession session, Model model) {
        log.info("mystays");
//        log.info("reservationStatus >>>>>>>>>>>>>>> {}", reservationStatus);

        // 가져온 회원 번호
        Object dto = session.getAttribute("dto");
        int memberNo = ((MemberDTO) dto).getMemberNo();
//        int memberNo = 2;

        ReservationDTO reservationDTO = ReservationDTO.builder().memberNo(memberNo).reservationStatus(reservationStatus).build();

        // 예약 조회
        List<ReservationDTO> reservationList = reservationService.getReservations(reservationDTO);

        model.addAttribute("rsStatus", reservationStatus);
        model.addAttribute("rsList", reservationList);

        return "reservation/myReservation";
    }

    @GetMapping("/mystay")
    public String mystayDetail(@RequestParam(value = "rsNo", required = true) int rsNo, HttpSession session, Model model) {
        // 가져온 회원 번호
        Object dto = session.getAttribute("dto");
        int memberNo = ((MemberDTO) dto).getMemberNo();
//        int memberNo = 2;

        ReservationDTO reservationDTO = ReservationDTO.builder().memberNo(memberNo).reservationNo(rsNo).build();

        // 예약 조회
        ReservationDTO rsDTO = reservationService.getReservationDetail(reservationDTO);
        model.addAttribute("rsrv", rsDTO);

        AcmDTO roomMap = acmRoomService.selectRoomDetail(rsDTO.getAcmDTO());

        model.addAttribute("category", roomMap);   // 카테고리 목록 추가
        model.addAttribute("keyword", roomMap);     // 키워드 목록 추가
        model.addAttribute("roomDetail", roomMap);  // 객실 정보를 모델에 추가

        return "reservation/myReservationDetail";
    }

    @PostMapping("/staycancel")
    public String stayCancel(
            @RequestParam(value = "rsNo", required = true) int rsNo,
            @RequestParam(value = "cancelReasons", required = true) String cancelReasons, HttpSession session, Model model) {
        // 가져온 회원 번호
        Object dto = session.getAttribute("dto");
        int memberNo = ((MemberDTO) dto).getMemberNo();
//        int memberNo = 2;

        // 예약 취소 요청
        reservationService.cancelReservationReq(memberNo, rsNo, cancelReasons);
        // 예약 조회
//        ReservationDTO rsDTO = reservationService.getReservationDetail(reservationDTO);

        return "redirect:/reservation/mystays";
    }

    @GetMapping("/rsList")
    public String rsList(Model model) {
        return "reservation/rsList";
    }
    @GetMapping("/cancelList")
    public String cancelList(Model model) {
        return "reservation/cancelList";
    }

    @GetMapping("/bAcmList")
    public ResponseEntity<Map<String, Object>> bAcmList(
//            @RequestBody(required = true) RsJsonDTO rsJsonDTO,
              @RequestParam(value = "businessNo", required = true) int businessNo,
              @RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
              @RequestParam(name = "search", required = false) String search) {
        log.info("숙소 목록 조회");

        int pageSize = 4;      // 페이지당 항목 수
        List<AccommodationDTO> list = acmRoomService.getBnsAcmList(businessNo, currentPage, pageSize, search);

        // 총 숙소 개수를 가져오는 서비스 메서드 호출
        int totalItems = acmRoomService.countAcmAll(businessNo, search);       // 총 숙소 개수
        // 총 페이지 수 계산
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        // 페이지 블록 계산
        int blockSize = 10;             // 블록당 페이지 수
        int currentBlock = (currentPage - 1) / blockSize;       // 현재 블록
        int startPage = currentBlock * blockSize + 1;           // 블록의 시작 페이지
        int endPage = Math.min(startPage + blockSize - 1, totalPages);  // 블록의 끝 페이지

        HashMap<String, Object> acmData = new HashMap<>();
        acmData.put("currentPage", currentPage);
        acmData.put("totalCount", totalItems); // 갯수
        acmData.put("totalPages", totalPages);
        acmData.put("startPage", startPage);
        acmData.put("endPage", endPage);
        acmData.put("search", search);
        acmData.put("list", list);

        // 다음 버튼 표시 여부 설정
        acmData.put("hasNext",  currentPage < endPage);

//        System.out.println("acmData = " + acmData);

        return new ResponseEntity<>(acmData, HttpStatus.OK);
    }

    @GetMapping("/bRoomList")
    public ResponseEntity<Map<String, Object>> bRoomList(
            @RequestParam(value = "acmNo", required = true) int acmNo,
            @RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name = "search", required = false) String search) {
        log.info("객실 목록 조회");

        int pageSize = 4;      // 페이지당 항목 수
        List<RoomDTO> list = acmRoomService.getBnsRoomList(acmNo, currentPage, pageSize, search);

        // 총 숙소 개수를 가져오는 서비스 메서드 호출
        int totalItems = acmRoomService.countRoomAll(acmNo, search);       // 총 숙소 개수
        // 총 페이지 수 계산
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        // 페이지 블록 계산
        int blockSize = 10;             // 블록당 페이지 수
        int currentBlock = (currentPage - 1) / blockSize;       // 현재 블록
        int startPage = currentBlock * blockSize + 1;           // 블록의 시작 페이지
        int endPage = Math.min(startPage + blockSize - 1, totalPages);  // 블록의 끝 페이지

        HashMap<String, Object> roomData = new HashMap<>();
        roomData.put("currentPage", currentPage);
        roomData.put("totalCount", totalItems); // 갯수
        roomData.put("totalPages", totalPages);
        roomData.put("startPage", startPage);
        roomData.put("endPage", endPage);
        roomData.put("search", search);
        roomData.put("list", list);

        // 다음 버튼 표시 여부 설정
        roomData.put("hasNext",  currentPage < endPage);

//        System.out.println("roomData = " + roomData);

        return new ResponseEntity<>(roomData, HttpStatus.OK);
    }

    @GetMapping("/bRsList")
    public ResponseEntity<Map<String, Object>> bRsList(
            @RequestParam(value = "businessNo", required = true) int businessNo,
            @RequestParam(value = "acmNo", required = false) int acmNo,
            @RequestParam(value = "roomNo", required = false) int roomNo,
            @RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name = "search", required = false) String search) {
        log.info("예약 목록 조회");

        int pageSize = 10;      // 페이지당 항목 수
        List<ReservationDTO> list = reservationService.getBnsRsList(businessNo, acmNo, roomNo, currentPage, pageSize, search);

        // 총 숙소 개수를 가져오는 서비스 메서드 호출
        int totalItems = reservationService.countRsAll(businessNo, acmNo, roomNo, search);       // 총 숙소 개수
        // 총 페이지 수 계산
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        // 페이지 블록 계산
        int blockSize = 10;             // 블록당 페이지 수
        int currentBlock = (currentPage - 1) / blockSize;       // 현재 블록
        int startPage = currentBlock * blockSize + 1;           // 블록의 시작 페이지
        int endPage = Math.min(startPage + blockSize - 1, totalPages);  // 블록의 끝 페이지

        HashMap<String, Object> rsData = new HashMap<>();
        rsData.put("currentPage", currentPage);
        rsData.put("totalCount", totalItems); // 갯수
        rsData.put("totalPages", totalPages);
        rsData.put("startPage", startPage);
        rsData.put("endPage", endPage);
        rsData.put("search", search);
        rsData.put("list", list);

        // 다음 버튼 표시 여부 설정
        rsData.put("hasNext",  currentPage < endPage);

//        System.out.println("rsData = " + rsData);

        return new ResponseEntity<>(rsData, HttpStatus.OK);
    }

    @GetMapping("/getRsCancel")
    public ResponseEntity<Map<String, Object>> getRsCancel(@ModelAttribute ReservationDTO rsDTO ) {
        log.info("예약 취소 조회");
//        ReservationDTO rsDTO = ReservationDTO.builder().reservationNo(rsNo).build();

        rsDTO = reservationService.getRsCancel(rsDTO);

        HashMap<String, Object> rsCancelData = new HashMap<>();
        rsCancelData.put("rsCancelInfo", rsDTO);

        return new ResponseEntity<>(rsCancelData, HttpStatus.OK);
    }

    @GetMapping("/cancelRs")
    public ResponseEntity<Map<String, Object>> cancelRs (
            @RequestParam(value = "rsNo", required = true) int rsNo,
            @RequestParam(value = "cancelStatus", required = true) int cancelStatus,
            @RequestParam(value = "paymentNo", required = true) int paymentNo
    ) {
        log.info("예약 취소");
        log.info("rsNo = {} ", rsNo);
        log.info("cancelStatus = {} ", cancelStatus);
        log.info("paymentNo = {} ", paymentNo);

        PaymentDTO paymentDTO = PaymentDTO.builder()
                .paymentNo(paymentNo)
                .reservationNo(rsNo)
                .paymentCancelId("paymentCancelId")
                .paymentStatus(cancelStatus)
                .build();

        ReservationDTO rsDTO = ReservationDTO.builder()
                .reservationNo(rsNo)
                .reservationStatus(cancelStatus)
                .payment(paymentDTO)
                .build();

        reservationService.cancelReservationRes(rsDTO);

        return ResponseEntity.ok().build();
    }

    @GetMapping("/cancelRsPay")
    public ResponseEntity<Map<String, Object>> cancelRsPay(@ModelAttribute RefundRequest refundRequest) {
        log.info("예약 취소 상태 변경");
//        log.info("refundRequest.getImpUid() = " + refundRequest.getImpUid());
//        log.info("refundRequest.getMerchantUid() = " + refundRequest.getMerchantUid());
        log.info("주문 상품 환불 진행 : 주문 번호 {}", refundRequest.getMerchantUid());

//        boolean result = refundService.processRefund(refundRequest);
//        System.out.println("result = " + result);
        String token = null;
        try {
//            token = refundService.getToken(apiKey, secretKey);
            token = refundService.getAccessToken(apiKey, secretKey);

//            System.out.println("token = " + token);
            refundService.refundRequest(token, refundRequest.getMerchantUid(), refundRequest.getReason());
        } catch (IOException e) {
            System.out.println("주문 상품 환불 진행 에러");
            throw new RuntimeException(e);
        }

        HashMap<String, Object> rsCancelData = new HashMap<>();

        return new ResponseEntity<>(rsCancelData, HttpStatus.OK);
    }


}
