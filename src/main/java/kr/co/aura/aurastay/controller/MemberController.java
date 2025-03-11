package kr.co.aura.aurastay.controller;

import ch.qos.logback.core.model.Model;
import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/member")
public class MemberController {
    private final MemberService memberService;

    // 이메일로 회원가입
    @GetMapping("/emailSignUp")
    public String emailSignUp() {
        return "member/emailSignUp";
    }
    @PostMapping("/emailSignUp")
    public String emailSignUpOk(@ModelAttribute MemberDTO dto,
                         @RequestParam("phone1") String phone1,
                         @RequestParam("phone2") String phone2,
                         @RequestParam("phone3") String phone3) {
        dto.setMemberPhoneNumber(phone1+phone2+phone3);
        dto.setAuthority("ROLE_MEMBER");
        memberService.save(dto);

        return "index";
    }

    // 로그인
    @GetMapping("/login")
    public String login() {
        return "member/login";
    }
    @PostMapping("/login")
    public String loginOk(@ModelAttribute MemberDTO dto){
        return "redirect:/";
    }

    // 이메일로 로그인
    @GetMapping("/emailLogin")
    public String emailLogin() {
        return "member/emailLogin";
    }


    @PostMapping("/emailLogin")
    public String emailLoginOk(@ModelAttribute MemberDTO dto){
        log.info("  dto : >>>>>>>>>>>>>>>>> "+ dto);
        return "redirect:/";
    }

    @GetMapping("/findPassword")
    public String findPassword() {
        return "member/findPassword";
    }


}
