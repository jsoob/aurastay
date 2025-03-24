package kr.co.aura.aurastay.controller;

import jakarta.servlet.http.HttpSession;
import kr.co.aura.aurastay.dto.BusinessDTO;
import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.security.CustomUserDetail;
import kr.co.aura.aurastay.service.BusinessService;
import kr.co.aura.aurastay.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Controller
public class MainController {
    private final MemberService memberService;
    private final BusinessService businessService;

    // 사용자 메인 페이지
    @GetMapping({"/", "/index", "/main"})
    public String index(@AuthenticationPrincipal Object principal, HttpSession session) {

        MemberDTO member = null;

        if (principal instanceof OAuth2User) { // 소셜로그인 사용자
            member = memberService.findByProviderId(((OAuth2User) principal).getName());
        } else if (principal instanceof UserDetails) { // 일반 사용자
            member = ((CustomUserDetail) principal).getMember();
        }

        System.out.println(member);
        session.setAttribute("dto", member);
        return "index";
    }

    // 로그인
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    public String loginOk(@ModelAttribute MemberDTO dto) {
        return "redirect:/";
    }

    // 비밀번호 찾기 폼
    @GetMapping("/findPassword")
    public String findPassword() {
        return "findPassword";
    }

    // 비밀번호 재설정할 이메일 정보를 세션에 저장
    @PostMapping("/storeEmailSession")
    public ResponseEntity<?> storeEmailInSession(@RequestBody Map<String, String> request, HttpSession session) {
        String email = request.get("email");
        // 세션에 담기
        session.setAttribute("resetEmail", email);
        return ResponseEntity.ok().build();
    }

    // 비밀번호 재설정 폼으로 이동
    @GetMapping("/resetPassword")
    public String resetPasswordPage(HttpSession session, Model model) {
        // 접근 제한을 위해 세션값 확인
        String email = (String) session.getAttribute("resetEmail");

        if (email == null) {
            return "redirect:/findPassword";  // 세션이 없으면 접근 불가
        } else {
            // member에 있는지
            MemberDTO member = memberService.findByEmail(email);
            if (member != null) {
                model.addAttribute("member", member);
                model.addAttribute("user", 0);
            }

            // business에 있는지
            BusinessDTO business = businessService.findByEmail(email);
            if (business != null) {
                model.addAttribute("business", business);
                model.addAttribute("user", 1);
            }
        }

        return "resetPassword";
    }

    // 비밀번호 재설정 처리
    @PostMapping("/resetPassword")
    public String resetPasswordOk(@RequestParam("password") String password,
                                  @RequestParam("email") String email,
                                  @RequestParam("user") int user,
                                  HttpSession session) {
        // 이부분 if(isExistMember){memberDTO에 담아 memberService.resetPassword(dto)} 이렇게 수정할지..
        if (user == 0) { // member
            MemberDTO memberDTO = MemberDTO.builder()
                    .memberPassword(password)
                    .memberEmail(email)
                    .build();
            memberService.resetPassword(memberDTO);
        } else if (user == 1) { // business
            BusinessDTO businessDTO = BusinessDTO.builder()
                    .businessPassword(password)
                    .businessEmail(email)
                    .build();
            businessService.resetPassword(businessDTO);
        }

        // 모든 세션 정보 삭제 (로그아웃 상태로 만듦)
        session.invalidate();
        return "redirect:/login";
    }

    // 이메일 중복 확인
    @PostMapping("/checkEmail")
    public ResponseEntity<Map<String, Boolean>> checkEmail(@RequestParam String email) {
        boolean exists = memberService.isMemberExist(email) || businessService.isBusinessExist(email); // member 또는 business에 존재하는 이메일
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);
        return ResponseEntity.ok(response);
    }


}
