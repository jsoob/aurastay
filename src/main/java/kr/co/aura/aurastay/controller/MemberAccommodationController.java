package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.service.MemberAcmService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

// 사용자 페이지 제작
// 숙소 상세 정보 조회

@RequiredArgsConstructor
@RequestMapping("/user")
@Controller
public class MemberAccommodationController {

    private final MemberAcmService memberAcmService;

    // 사용자 페이지 : 숙소 전체 조회
    @GetMapping("/accommodation/memberAccommodation")
    public String MemberAccommodation() {
        return "memberAccommodation";
    }


}
