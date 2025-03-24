package kr.co.aura.aurastay.controller;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/member")
public class MemberController {
    private final MemberService memberService;
    private final PasswordEncoder passwordEncoder;

    // 이메일로 회원가입
    @GetMapping("/emailSignUp")
    public String emailSignUp(Model model) {
        model.addAttribute("memberDTO", new MemberDTO());
        return "member/emailSignUp";
    }

    @PostMapping("/emailSignUp")
    public String emailSignUpOk(@Valid @ModelAttribute MemberDTO memberDTO,
                                BindingResult bindingResult,
                                @RequestParam("phone1") String phone1,
                                @RequestParam("phone2") String phone2,
                                @RequestParam("phone3") String phone3,
                                Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("errors", bindingResult.getAllErrors());
            return "member/emailSignUp";
        }

        memberDTO.setMemberPhoneNumber(phone1 + phone2 + phone3);
        memberService.save(memberDTO);

        return "redirect:/login";
    }

    // 로그인
    @GetMapping("/login")
    public String login() {
        return "emailLogin";
    }

    @PostMapping("/login")
    public String loginOk(@ModelAttribute MemberDTO dto) {
        return "redirect:/";
    }

    // 마이페이지
    @GetMapping("/myPage")
    public String myPage(Model model) {
        return "member/mypage";
    }

    // 개인정보수정
    @PostMapping("/myPage")
    public ResponseEntity<?> myPageOk(@RequestBody MemberDTO dto, HttpSession session) {

        MemberDTO member = memberService.findByMemberNo(dto.getMemberNo());
        member.setMemberName(dto.getMemberName());
        member.setMemberEmail(dto.getMemberEmail());
        member.setMemberNickname(dto.getMemberNickname());
        member.setMemberPhoneNumber(dto.getMemberPhoneNumber());

        memberService.modifyMemberInfo(member);

        // 세션도 수정

        session.setAttribute("dto", member);
        return ResponseEntity.ok().build();
    }

    // 회원탈퇴
    @PostMapping("/withdrawal")
    public String withdrawal(@RequestParam("memberNo") int memberNo, HttpSession session) {
        // 회원 탈퇴일자 update
        memberService.withdrawalMember(memberNo);
        // 세션 무효화 및 SecurityContext 제거
        session.invalidate();

        // Spring Security의 인증 정보도 제거
        SecurityContextHolder.clearContext();

        return "redirect:/";
    }


    // 비밀번호 확인
    @PostMapping("/checkPassword")
    public ResponseEntity<Map<String, Boolean>> checkPassword(@RequestParam("memberNo") int memberNo
            ,@RequestParam("password") String password, HttpSession session) {

        MemberDTO member = memberService.findByMemberNo(memberNo);
        Map<String, Boolean> response = new HashMap<>();
        
        boolean matches = passwordEncoder.matches(password, member.getMemberPassword());
        response.put("response", matches);
        if (matches) {
            session.setAttribute("resetEmail", member.getMemberEmail());
        }

        return ResponseEntity.ok(response);

    }

}
