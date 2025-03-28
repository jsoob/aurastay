package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.dto.*;
import kr.co.aura.aurastay.service.MemberAcmService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

// 사용자 페이지 제작
// 숙소 상세 정보 조회

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/accommodation")
@Controller
public class MemberAccommodationController {

    private final MemberAcmService memberAcmService;

    // 사용자 페이지 기준 : 사용자가 선택한 숙소에 대해 볼 수 있는 (사업자쪽에 등록된) 숙소 상세 페이지
    // 숙소 번호 기준
    @GetMapping("/memberAccommodation/{acmNo}")
    public String getAccommodation(@PathVariable("acmNo") int acmNo,
                                   Model model) {

        // 숙소 정보 조회
        AccommodationDTO dto = memberAcmService.getAccommodationById(acmNo);
        // 숙소 이미지 조회
        List<RoomImageDTO> images = memberAcmService.getAccommodationRoomImagesById(acmNo);
        // 객실 정보 조회
        List<RoomDTO> room = memberAcmService.getRoomInfoById(acmNo);
        // 카테고리 정보 조회
        List<CategoryDTO> categories = memberAcmService.getCategoriesById(acmNo);
        // 키워드 정보 조회
        List<KeywordDTO> keywords = memberAcmService.getKeywordsById(acmNo);

        // DTO 상태 확인
        if (dto == null) {
            System.out.println("숙소 정보를 찾을 수 없습니다: acmNo = " + acmNo);
            return "error/accommodationNotFound"; // 에러 페이지로 리다이렉트
        } else {
            System.out.println("숙소 이름: " + dto.getAcmName());
        }

        // 숙소 상세정보를 조회하고 모델에 추가
        model.addAttribute("dto", dto);
        // 이미지 정보 모델에 추가
        model.addAttribute("images", images);
        // 객실 정보 모델에 추가
        model.addAttribute("room", room);
        // 카테고리 정보 모델에 추가
        model.addAttribute("categories", categories);
        // 키워드 정보 모델에 추가
        model.addAttribute("keywords", keywords);

        // 기존에 등록되어있던 값들을 정상적으로 불러오고 있는지 로그로 확인
        log.info("dto (숙소 상세정보) >>>>>>>>>>>>>>> : {} ", dto);
        log.info("images (이미지 정보) >>>>>>>>>>>>>>> : {} ", images);
        log.info("room (객실 정보) >>>>>>>>>>>>>>> : {} ", room);
        log.info("categories (카테고리 : 숙소 정보) >>>>>>>>>>>>>>> : {} ", categories);
        log.info("keywords (키워드 : 지역명 정보) >>>>>>>>>>>>>>> : {} ", keywords);

        return "accommodation/memberAccommodation";
    }


}
