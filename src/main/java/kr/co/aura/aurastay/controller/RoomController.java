package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.dto.RoomDTO;
import kr.co.aura.aurastay.service.RoomService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RequestMapping("/accommodation")
@Controller
public class RoomController {

    private final RoomService roomService;

    // 객실 등록 폼 페이지로 이동
    @GetMapping("/roomAdd")
    public String roomAdd(Model model) {
        RoomDTO dto = new RoomDTO();  // 빈 DTO 객체 생성
        model.addAttribute("dto", dto);  // 모델에 추가
        return "accommodation/acmAdd";  // 객실 등록 폼으로 이동
    }

    // 객실 정보 입력 후 등록하는 메서드
    @PostMapping("/roomAdd")
    public String roomForm(@ModelAttribute("dto") RoomDTO roomDTO) {
        // roomDTO에 담긴 정보를 통해 객실 등록 처리
        roomService.roomAdd(roomDTO);
        return "redirect:/accommodation/acmList";  // 등록 후 숙소 목록으로 리다이렉트
    }

    // 객실 정보 수정하기
    @PostMapping("/roomUpdate")
    public String roomUpdate(@ModelAttribute("dto") RoomDTO roomDTO) {
        // 수정할 객실 정보를 업데이트
        roomService.roomUpdate(roomDTO);
        return "redirect:/accommodation/acmList";  // 수정 후 숙소 목록으로 리다이렉트
    }

    // 등록된 객실 삭제하기
    @PostMapping("/roomDelete")
    public String roomDelete(@RequestParam("roomNo") int roomNo) {
        // 객실 번호로 객실 삭제 처리
        roomService.roomDelete(roomNo);
        return "redirect:/accommodation/acmList";  // 삭제 후 숙소 목록으로 리다이렉트
    }
}
