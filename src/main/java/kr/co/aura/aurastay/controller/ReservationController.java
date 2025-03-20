package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.dto.AcmDTO;
import kr.co.aura.aurastay.dto.ReservationDTO;
import kr.co.aura.aurastay.dto.SpecialRequestDTO;
import kr.co.aura.aurastay.service.AcmRoomService;
import kr.co.aura.aurastay.service.ReservationService;
import kr.co.aura.aurastay.util.ReservationUtil;
import lombok.RequiredArgsConstructor;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/reservation")
@RequiredArgsConstructor
public class ReservationController {
    private final ReservationService reservationService;
    private final AcmRoomService acmRoomService;

    @GetMapping("/stays")
    // roomNo
    //checkin
    //checkout
    // 예약하기 버튼 클릭시 가게
    public String stays(@RequestParam("accommodationNo") int accommodationNo, @RequestParam("roomNo") int roomNo, @RequestParam("checkin") String checkin, @RequestParam("checkout") String checkout, Model model) {
        // 에어비앤비 getParameter
        // checkin=2025-04-15&
        // checkout=2025-04-16&
        // numberOfGuests=1&
        // numberOfAdults=1&
        // guestCurrency=KRW&
        // productId=730576608330784746&
        // isWorkTrip=false&
        // numberOfChildren=0&
        // numberOfInfants=0&
        // numberOfPets=0&
        // code=HM2QXJHCAJ&
        // orderId=1376602254524241888

        String url = "/reservation/reservationForm";

//        System.out.println("accommodationNo: " + accommodationNo);
//        System.out.println("roomNo: " + roomNo);
//        System.out.println("checkin: " + checkin);
//        System.out.println("checkout: " + checkout);

        int countDay = ReservationUtil.getCheckDay(checkin, checkout);

        model.addAttribute("checkinDate", checkin);
        model.addAttribute("checkoutDate", checkout);
        model.addAttribute("countDay", countDay);

        int roomCountMin = 0;

        // 객실 수량 확인
        for (int i=0; i<countDay; i++) {
            HashMap<String, Object> rsrvMap = ReservationUtil.getRoomCheck(checkin, accommodationNo, roomNo, i);

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
            url = "redirect:/reservation/album_ex";
        }
        // 숙소 수량 count
        model.addAttribute("acmCount", roomCountMin); // 객실 수량이 1이면..마지막 객실 알림 / 2~ 이상이면 알림 없음.

        // 숙소 정보 조회
        // 숙소 DTO 값 받아오기.
        HashMap<String, Object> roomDetail = acmRoomService.selectRoomDetail(accommodationNo, roomNo);
//        System.out.println("roomDetail : ");
//        System.out.println(roomDetail);

        model.addAttribute("roomDetail", roomDetail);

        // 숙소 조회

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
    // @RequestParam(value = "payment")
    public String payment(@RequestBody Map<String, Object> jsonData ) {
        // , @RequestParam(value = "specialRequests", required = false) Integer[] specialRequests, @ModelAttribute ReservationDTO reservationDTO
        System.out.println("jsonData >>>>>>>>>>>>>>>>>>>>>>>>>>");
        System.out.println(jsonData);

        int status = reservationService.addReservation(jsonData);

//      jsonData >>>>>>>>>>>>>>>>>>>>>>>>>>
//      {payment={status=PAID, id=1-385219, transactionId=0195b214-2f8a-2da1-7d45-b2a5d94b79e7, merchantId=merchant-bf82b603-be66-4474-9cc1-03d3199fa24c, storeId=store-4b8d38b9-6775-4065-9eb0-6d3d89d63815, method={type=PaymentMethodEasyPay, provider=KAKAOPAY, easyPayMethod={type=PaymentMethodEasyPayMethodCharge}}, channel={type=TEST, id=channel-id-abe78f42-5b5b-4a97-9bb8-c582e7792623, key=channel-key-6509c147-0348-470a-a3b5-5cb7138919dc, name=토스페이먼츠 결제창 일반결제, pgProvider=TOSSPAYMENTS, pgMerchantId=iamporttest_3}, version=V2, requestedAt=2025-03-20T05:43:42.24716878Z, updatedAt=2025-03-20T05:44:07.094514771Z, statusChangedAt=2025-03-20T05:44:07.065193154Z, orderName=스카이베이 호텔 경포, amount={total=1500000, taxFree=0, vat=136364, supply=1363636, discount=0, paid=1500000, cancelled=0, cancelledTaxFree=0}, currency=KRW, customer={id=port-customer-id-0195b214-2f93-ad54-dc47-5e081a5a4c44, name=김우씨, email=kmhe0128@naver.com, phoneNumber=01011111111}, promotionId=, isCulturalExpense=false, country=MT, paidAt=2025-03-20T05:44:07.065193154Z, pgTxId=tiamp20250320144343qG2I6, pgResponse={"mId":"tiamporttest_3","lastTransactionKey":"txrd_a01jps193xfn59tj0e3gbsf8jfh","paymentKey":"tiamp20250320144343qG2I6","orderId":"1-385219","orderName":"스카이베이 호텔 경포","taxExemptionAmount":0,"status":"DONE","requestedAt":"2025-03-20T14:43:43+09:00","approvedAt":"2025-03-20T14:44:06+09:00","useEscrow":false,"cultureExpense":false,"card":null,"virtualAccount":null,"transfer":null,"mobilePhone":null,"giftCertificate":null,"cashReceipt":null,"cashReceipts":null,"discount":null,"cancels":null,"secret":"ps_0RnYX2w5327zNGQpdpaKVNeyqApQ","type":"NORMAL","easyPay":{"provider":"카카오페이","amount":1500000,"discountAmount":0},"country":"KR","failure":null,"isPartialCancelable":true,"receipt":{"url":"https://dashboard.tosspayments.com/receipt/redirection?transactionId=tiamp20250320144343qG2I6&ref=PX"},"checkout":{"url":"https://api.tosspayments.com/v1/payments/tiamp20250320144343qG2I6/checkout"},"transactionKey":"txrd_a01jps193xfn59tj0e3gbsf8jfh","currency":"KRW","totalAmount":1500000,"balanceAmount":1500000,"suppliedAmount":1363636,"vat":136364,"taxFreeAmount":0,"method":"간편결제","version":"2022-07-27","metadata":null}, receiptUrl=https://dashboard.tosspayments.com/receipt/redirection?transactionId=tiamp20250320144343qG2I6&ref=PX, disputes=[]}, guestName=김우씨, guestPhoneNumber=01011111111, guestEmail=kmhe0128@naver.com, residenceCountry=몰타, memberNo=1, roomNo=1, reservationDetailsRequest=gggggg, accommodationNo=2, specialRequests=[1, 3, 5], orderName=스카이베이 호텔 경포, totalAmount=500000}

//        System.out.println("specialRequests : "+ Arrays.toString(specialRequests));
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("status", status);

         return jsonObject.toJSONString();
         // "redirect:/reservation/myReservation";
    }

    
    @GetMapping("/mystays")
    public String myStays(Model model) {
        // 예약 조회
        List<SpecialRequestDTO> specialRequests = reservationService.getSpecialRequests();
        model.addAttribute("specialRequests", specialRequests);

        return "/reservation/myReservation";
    }

    @GetMapping("/mystay")
    public String mystayDetail(Model model) {
        return "/reservation/myReservationDetail";
    }
    

    @GetMapping("/album_ex")
    public String album_ex(Model model) {
        return "/reservation/album_ex";
    }

}
