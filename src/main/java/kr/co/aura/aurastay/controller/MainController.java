package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.dto.BusinessDTO;
import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.service.BusinessService;
import kr.co.aura.aurastay.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Collection;
import java.util.Iterator;

@Slf4j
@RequiredArgsConstructor
@Controller
public class MainController {
    private final MemberService memberService;
    private final BusinessService businessService;

    // 사용자 메인 페이지
    @GetMapping({"/", "/index", "/main"})
    public String index(Model model) {
        return "index";
    }

    // 이메일로 로그인
    @GetMapping("/emailLogin")
    public String emailLogin() {
        return "emailLogin2";
    }

    @PostMapping("/emailLogin")
    public String emailLoginOk(@ModelAttribute MemberDTO dto) {
        return "redirect:/";
    }

    // 비밀번호 찾기 폼
    @GetMapping("/findPassword")
    public String findPassword() {
        return "findPassword";
    }

    // 비밀번호 재설정 페이지
    @GetMapping("/resetPassword")
    public String resetPassword(@RequestParam String email, Model model) {

        MemberDTO member = memberService.findByEmail(email);
        if (member != null) {
            model.addAttribute("member", member);
            model.addAttribute("user",0);
        }
        BusinessDTO business = businessService.findByEmail(email);

        if (business != null) {
            model.addAttribute("business", business);
            model.addAttribute("user",1);
        }

        return "resetPassword";
    }

    // 비밀번호 재설정
    @PostMapping("/resetPassword")
    public String resetPasswordOk(@RequestParam("password") String password,
                                  @RequestParam("email") String email,
                                  @RequestParam("user") int user) {
        if(user == 0) { // member
            MemberDTO memberDTO = MemberDTO.builder()
                    .memberPassword(password)
                    .memberEmail(email)
                    .build();
            memberService.resetPassword(memberDTO);
        } else if(user == 1){ // business
            BusinessDTO businessDTO = BusinessDTO.builder()
                    .businessPassword(password)
                    .businessEmail(email)
                    .build();
            businessService.resetPassword(businessDTO);
        }
        return "redirect:/emailLogin";
    }
}
