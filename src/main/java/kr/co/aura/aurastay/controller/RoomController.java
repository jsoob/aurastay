package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.dto.AccommodationDTO;
import kr.co.aura.aurastay.dto.RoomDTO;
import kr.co.aura.aurastay.service.AccommodationService;
import kr.co.aura.aurastay.service.RoomService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RequestMapping("/room")
@Controller
public class RoomController {

    private final RoomService roomService;
    private final AccommodationService accommodationService;

    // 숙소 상세 페이지에서 해당 숙소에 속한 객실 리스트를 가져와서 뷰로 전달하기
    // 숙소안에 있는 객실의 정보도 함께 불러오고 싶다면 숙소 컨트롤러에서 작성한다
//    @GetMapping("/acmInfo/{acmNo}")
//    public String getAccommodationInfo(@PathVariable("acmNo") int acmNo, Model model) {
//
//        // 숙소 정보 조회
//        AccommodationDTO accommodation = accommodationService.findById(acmNo);
//
//        // 해당 숙소에 속한 객실 리스트 조회
//        List<RoomDTO> roomList = roomService.findRoomByAccommodation(acmNo);
//
//        model.addAttribute("acmNo", acmNo);
//        model.addAttribute("accommodation", accommodation);
//        model.addAttribute("roomList", roomList);
//
//        // 숙소 상세 페이지로 이동
//        return "accommodation/acmInfo";
//    }

    // 객실 등록 폼 페이지로 이동
    @GetMapping("/roomAdd")
    public String roomAdd(Model model) {
        RoomDTO dto = new RoomDTO();  // 빈 DTO 객체 생성
        model.addAttribute("dto", dto);  // 모델에 추가
        return "accommodation/acmAdd";  // 객실 등록 폼으로 이동
    }


    // 객실 정보 입력 후 등록하는 메서드
    @PostMapping("/roomAdd")
    @ResponseBody // AJAX 요청에 대한 응답을 JSON으로 반환하기 위해 추가
    public ResponseEntity<String> roomForm(@RequestBody RoomDTO roomDTO){
//                           @RequestParam("acmNo") int acmNo) {
        // roomDTO에 담긴 정보를 통해 객실 등록 처리
        roomService.roomAdd(roomDTO);   // 객실만 등록하기

        // 객실이 추가된 후, 해당 숙소정보를 가져와서 객실 리스트에 roomDTO 추가
//        AccommodationDTO accommodation = accommodationService.findById(acmNo);      // 숙소 조회
//        accommodation.addRoom(roomDTO);         // 숙소 정보에 추가된 객실 반영
//
//        // 숙소 정보 업데이트
//        accommodationService.save(accommodation);

//        return "redirect:/accommodation/acmList";       // 등록 후 숙소 목록으로 리다이렉트
        return ResponseEntity.ok("객실 정보가 저장되었습니다."); // 성공 메시지 반환
    }

    // 객실 정보 수정하기
    @PostMapping("/roomUpdate")
    public String roomUpdate(@ModelAttribute("dto") RoomDTO roomDTO) {

        // 수정할 객실 정보를 업데이트
        roomService.roomUpdate(roomDTO);

        // 수정 후 숙소 목록을 (필요한 경우) 갱신할 수도 있음
        // ex. 숙소 정보를 가져와서 업데이트된 객실 정보를 반영한다던가..
//        AccommodationDTO accommodation = accommodationService.findByRoomId(roomDTO.getRoomNo());        // 해당 객실이 포함된 숙소 조회
//        accommodation.updateRoom(roomDTO);      // 수정된 객실 정보 업데이트
//
//        // 숙소 정보 저장
//        accommodationService.save(accommodation);

        return "redirect:/accommodation/acmList";  // 수정 후 숙소 목록으로 리다이렉트
    }

    // 등록된 객실 삭제하기
    @PostMapping("/roomDelete")
    public String roomDelete(@RequestParam("roomNo") int roomNo) {

        // 객실 번호로 객실 삭제 처리
        roomService.roomDelete(roomNo);

        // 해당 객실이 포함된 숙소 정보 가져오기
//        AccommodationDTO accommodation = accommodationService.findByRoomId(roomNo);
//        accommodation.removeRoom(roomNo);
//
//        // 숙소 정보 업데이트
//        accommodationService.save(accommodation);

        return "redirect:/accommodation/acmList";  // 삭제 후 숙소 목록으로 리다이렉트
    }
}
