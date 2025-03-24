package kr.co.aura.aurastay.controller;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import kr.co.aura.aurastay.dto.BusinessDTO;
import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.security.CustomUserDetail;
import kr.co.aura.aurastay.service.BusinessService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
    public String businessDashboardPage(@AuthenticationPrincipal Object principal, HttpSession session) {

        if (principal instanceof UserDetails) {
            // 로그인한 사용자 dto 세션에 담기
            session.setAttribute("dto", ((CustomUserDetail) principal).getBusiness());
        }

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
    public String businessSignUpPage(Model model) {
        model.addAttribute("businessDTO", new BusinessDTO());
        return "business/businessSignUp";
    }

    @PostMapping("/signUp")
    public String businesSignUpOk(@Valid @ModelAttribute BusinessDTO businessDTO,
                                  BindingResult bindingResult,
                                  @RequestParam("phone1") String phone1,
                                  @RequestParam("phone2") String phone2,
                                  @RequestParam("phone3") String phone3,
                                  Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("errors", bindingResult.getFieldErrors()); // 오류 목록 전달
            return "business/businessSignUp";
        }

        businessDTO.setBusinessPhoneNumber(phone1 + phone2 + phone3);
        businessService.save(businessDTO);
        return "redirect:/business/intro";
    }

}
