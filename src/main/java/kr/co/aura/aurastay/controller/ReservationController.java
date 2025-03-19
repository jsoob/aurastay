package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.dto.AcmDTO;
import kr.co.aura.aurastay.dto.ReservationDTO;
import kr.co.aura.aurastay.dto.SpecialRequestDTO;
import kr.co.aura.aurastay.service.AcmRoomService;
import kr.co.aura.aurastay.service.ReservationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

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
    public String stays(@RequestParam("accommodationNo") int accommodationNo, @RequestParam("roomNo") int roomNo, @RequestParam("checkin") String checkin, @RequestParam("checkout") String checkout, Model model) throws ParseException {
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

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        Date intDate = null;
        Date outDate = null;

//        try {
            intDate = new Date(dateFormat.parse(checkin).getTime());
            outDate = new Date(dateFormat.parse(checkout).getTime());
//        } catch (ParseException e) {
//            throw new RuntimeException(e);
//        }

        long calculate = outDate.getTime() - intDate.getTime(); // out - int
        int countDay = (int) (calculate / ( 24*60*60*1000));

//        System.out.println("countDay: " + countDay);

        model.addAttribute("checkinDate", checkin);
        model.addAttribute("checkoutDate", checkout);
        model.addAttribute("countDay", countDay);

        int roomCountMin = 0;

        // 객실 수량 확인
        for (int i=0; i<countDay; i++) {
            Date rsrvDate = dateFormat.parse(checkin);
            Calendar cal = Calendar.getInstance();
            cal.setTime(rsrvDate);

            cal.add(Calendar.DAY_OF_MONTH, i);
            // 결과 날짜를 포맷 형식에 맞게 변환합니다.
            String getDate = dateFormat.format(cal.getTime());

            //
            HashMap<String, Object> rsrvMap = new HashMap<>();
            rsrvMap.put("accommodationNo", accommodationNo);
            rsrvMap.put("roomNo", roomNo);
            rsrvMap.put("getDate", getDate);

            int acmCount = reservationService.getRemainingRooms(rsrvMap); // 숙소 번호, 룸 번호, 해당 일자
            // (int accommodationNo, int roomNo, String getDate)
            if(i==0) roomCountMin = acmCount;

//            # '2025-03-10', 2, from -> 0
//            # '2025-03-11', 2, from -> 1
//            # '2025-03-12', 2, from -> 5
//            # '2025-03-13', 2, from -> 2
//            # '2025-03-14', 1, from -> 3
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

    // Content-Type 'application/x-www-form-urlencoded;charset=UTF-8' is not supported
    @PostMapping("/payment")
    public String payment(@RequestBody HashMap<String, Object> map, @RequestParam(value = "specialRequests", required = false) Integer[] specialRequests, @ModelAttribute ReservationDTO reservationDTO ) {
        System.out.println("payment >>>>>>>>>>>>>>>>>>>>>>>>>>");
        System.out.println(map);

        return "/reservation/myReservation";
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
