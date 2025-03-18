package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.dto.MemberDTO;
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

    // 사용자 메인 페이지
    @GetMapping({"/","/index","/main"})
    public String index(Model model) {
        return "index";
    }

    // 이메일로 로그인
    @GetMapping("/emailLogin")
    public String emailLogin() {
        return "emailLogin2";
    }

    @PostMapping("/emailLogin")
    public String emailLoginOk(@ModelAttribute MemberDTO dto){
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
        log.info(">>>>>>>>>>>>>>> email: {}", email);

        MemberDTO member = memberService.findByEmail(email);

        log.info(">>>>>>>>>>>>>>> member: {}", member);

        model.addAttribute("member", member);
        return "resetPassword";
    }

    // 비밀번호 재설정
    @PostMapping("/resetPassword")
    public String resetPasswordOk(@RequestParam("memberPassword") String password,
                                  @RequestParam("memberEmail") String memberEmail,
                                  @RequestParam("memberNo") int memberNo) {
        MemberDTO memberDTO = MemberDTO.builder()
                .memberPassword(password)
                .memberEmail(memberEmail)
                .build();
        memberService.resetPassword(memberDTO);
        return "redirect:/emailLogin";
    }
}
