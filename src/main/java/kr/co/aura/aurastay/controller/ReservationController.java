package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.dto.AcmDTO;
import kr.co.aura.aurastay.dto.SpecialRequestDTO;
import kr.co.aura.aurastay.service.AcmRoomService;
import kr.co.aura.aurastay.service.ReservationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    public String stays(@RequestParam("roomNo") String roomNo, @RequestParam("checkin") String checkin, @RequestParam("checkout") String checkout, Model model) {
        String url = "reservation/reservationForm";
        // "redirect:reservation/album_ex";

        int roomCountMin = 1;

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

        // 객실 수량 확인
//        for () {
//        int acmCount = reservationService.getCount(1); // 숙소 번호
//            select rm.room_qty - IFNULL(sum(rs.room_no), 0)
//            from
//            room rm
//            left outer join
//            reservation rs
//            on rm.room_no = rs.room_no
//            and '2025-03-15' between STR_TO_DATE(rs.checkin_date, '%Y-%m-%d') and STR_TO_DATE(rs.checkout_date, '%Y-%m-%d')
//            where
//            rm.room_no = 1
//            group by rm.room_no;

//            # '2025-03-10', 2, from -> 0
//            # '2025-03-11', 2, from ->
//            # '2025-03-12', 2, from
//            # '2025-03-13', 2, from
//            # '2025-03-14', 1 from
//            # -> 기간내에 마감된 객실이 있습니다.

//            roomCountMin = Math.min(roomCountMin, 2);
//        }

        // 객실 수량 확인..
        // 0개이면 애초에 예약하기 버튼 활성화 안함. -> 근데 고민하다가 누를 수 있으니 누르면 다시 리다이렉트 -> 해당 숙소 정보로 가기
        // 숙소 수량 count
        model.addAttribute("acmCount", 2); // 객실 수량이 1이면..마지막 객실 알림 / 2~ 이상이면 알림 없음.

        // 숙소 정보 조회
        // 숙소 DTO 값 받아오기.
        HashMap<String, Object> map = acmRoomService.selectRoomDetail();
        System.out.println("map : ");
        System.out.println(map);

        // 숙소 조회

        // 특별 요청 예약
        List<SpecialRequestDTO> specialRequests = reservationService.getSpecialRequests();
        model.addAttribute("specialRequests", specialRequests);

        return url;
    }
    
    @GetMapping("/mystays")
    public String myStays(Model model) {
        // 예약 조회
        List<SpecialRequestDTO> specialRequests = reservationService.getSpecialRequests();
        model.addAttribute("specialRequests", specialRequests);

        return "reservation/myReservation";
    }

    @GetMapping("/mystay")
    public String mystayDetail(Model model) {
        return "reservation/myReservationDetail";
    }
    

    @GetMapping("/album_ex")
    public String album_ex(Model model) {
        return "reservation/album_ex";
    }

}
