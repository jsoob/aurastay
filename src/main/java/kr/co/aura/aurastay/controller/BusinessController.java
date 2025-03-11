package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.dto.BusinessDTO;
import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.service.BusinessService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/business")
public class BusinessController {
    private final BusinessService businessService;

    // 인트로
    @GetMapping("/intro")
    public String businessIntroPage() {
        return "business/businessIntro";
    }

    // 로그인
    @GetMapping("/login")
    public String businessLoginPage() {
        return "business/businessLogin";
    }
    @PostMapping("/login")
    public String businessLogin(Model model, String username, String password) {
        return "redirect:/business";
    }

    // 회원가입
    @GetMapping("/signUp")
    public String businessSignUpPage() {
        return "business/businessSignUp";
    }
    @PostMapping("/signUp")
    public String businesSignUpOk(@ModelAttribute BusinessDTO dto,
                                  @RequestParam("phone1") String phone1,
                                  @RequestParam("phone2") String phone2,
                                  @RequestParam("phone3") String phone3) {

        dto.setBusinessPhoneNumber(phone1+phone2+phone3);
        dto.setAuthority("ROLE_BUSINESS");
        businessService.save(dto);
        return "redirect:/business/intro";
    }

}
