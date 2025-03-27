package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.dto.AccommodationDTO;
import kr.co.aura.aurastay.service.MemberAcmService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

// 사용자 페이지 제작
// 숙소 상세 정보 조회

@RequiredArgsConstructor
@RequestMapping("/accommodation")
@Controller
public class MemberAccommodationController {

    private final MemberAcmService memberAcmService;

    // 사용자 페이지 기준 : 사용자가 선택한 숙소에 대해 볼 수 있는 (사업자쪽에 등록된) 숙소 상세 페이지
    // 숙소 번호 기준
    @GetMapping("/memberAccommodation/{acmNo}")
    public String getAccommodation(@PathVariable("acmNo") int acmNo, Model model) {

        AccommodationDTO dto = memberAcmService.getAccommodationById(acmNo);

        // DTO 상태 확인
        if (dto == null) {
            System.out.println("숙소 정보를 찾을 수 없습니다: acmNo = " + acmNo);
            return "error/accommodationNotFound"; // 에러 페이지로 리다이렉트
        } else {
            System.out.println("숙소 이름: " + dto.getAcmName());
        }


        // 숙소 상세정보를 조회하고 모델에 추가
        model.addAttribute("dto", dto);

        return "accommodation/memberAccommodation";
    }


}
