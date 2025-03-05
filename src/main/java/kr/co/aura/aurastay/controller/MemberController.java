package kr.co.aura.aurastay.controller;

import ch.qos.logback.core.model.Model;
import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
    @PostMapping("/emailSignUpOk")
    public String emailSignUpOk(@ModelAttribute MemberDTO dto,
                         @RequestParam("phone1") String phone1,
                         @RequestParam("phone2") String phone2,
                         @RequestParam("phone3") String phone3) {
        dto.setMemberPhoneNumber(phone1+phone2+phone3);
        memberService.save(dto);

        return "index";
    }

    // 로그인 처음 화면
    @GetMapping("/login")
    public String login() {
        return "member/login";
    }
    @GetMapping("/emailLogin")
    public String emailLogin() {
        return "member/emailLogin";
    }

}
