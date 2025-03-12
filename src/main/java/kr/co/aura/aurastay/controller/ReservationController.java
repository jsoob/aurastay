package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.dto.SpecialRequestDTO;
import kr.co.aura.aurastay.service.AccommodationService;
import kr.co.aura.aurastay.service.ReservationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/reservation")
@RequiredArgsConstructor
public class ReservationController {
    private final ReservationService reservationService;

    @GetMapping("/stays")
    public String stays(Model model) {
        // 객실 수량 확인
//        int acmCount = reservationService.getCount(1); // 숙소 번호

        // 객실 수량 확인..
        // 0개이면 애초에 예약하기 버튼 활성화 안함. -> 근데 고민하다가 누를 수 있으니 누르면 다시 리다이렉트 -> 해당 숙소 정보로 가기
        // 숙소 수량 count
        model.addAttribute("acmCount", 2);

        // 숙소 정보 조회
        // 숙소 DTO 값 받아오기.


        List<SpecialRequestDTO> specialRequests = reservationService.getSpecialRequests();
        model.addAttribute("specialRequests", specialRequests);

        return "reservation/reservationForm";
    }
    
    @GetMapping("/mystays")
    public String myStays(Model model) {
        // 예약 조회
        List<SpecialRequestDTO> specialRequests = reservationService.getSpecialRequests();
        model.addAttribute("specialRequests", specialRequests);

        return "reservation/myReservation";
    }
    

//    @GetMapping("/album_ex")
//    public String album_ex(Model model) {
//        return "reservation/album_ex";
//    }

}
