package kr.co.aura.aurastay.controller;

import jakarta.servlet.http.HttpSession;
import kr.co.aura.aurastay.dto.BusinessDTO;
import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.service.BusinessService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.context.SecurityContextHolder;
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

    // 사업자관리페이지
    @GetMapping("/dashboard")
    public String businessDashboardPage() { //HttpSession session
        // 로그인해서 들어가기 전에 security context?를 통해
        // businessDTO 객체로 가져와 session에 담기?
        // BusinessService쪽에서 로직 짜야할듯

//        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        // businessService.findByUsername(email) 로 BusinessDTO 받기
        // session.setAttribute("businessDTO",businessDTO); 이렇게 해도되는지 확인필

        return "business/dashboard";
    }

//    // 로그인 // 시큐리티 사용으로 필요없어짐
//    @GetMapping("/login")
//    public String businessLoginPage() {
//        return "business/businessLogin";
//    }
//    @PostMapping("/login")
//    public String businessLogin(Model model, String username, String password) {
//        return "redirect:/business";
//    }

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
        businessService.save(dto);
        return "redirect:/business/intro";
    }

}
