package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.dto.MemberDTO;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Collection;
import java.util.Iterator;

@Controller
public class MainController {
    // 사용자 메인 페이지
    @GetMapping({"/","/index","/main"})
    public String index(Model model) {
        return "index";
    }

    // 이메일로 로그인
    @GetMapping("/emailLogin")
    public String emailLogin() {
        return "emailLogin";
    }

    @PostMapping("/emailLogin")
    public String emailLoginOk(@ModelAttribute MemberDTO dto){
        return "redirect:/";
    }

}
