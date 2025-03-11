package kr.co.aura.aurastay.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Collection;
import java.util.Iterator;

@Controller
public class MainController {

    /* role과 id를 view단에서 사용하기 위한 */
    @GetMapping("/home")
    public String home(Model model) {

        /* 현재 인증된 사용자의 이름 */
        String id = SecurityContextHolder.getContext().getAuthentication().getName();


        Collection<? extends GrantedAuthority> authorities = SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getAuthorities(); // 권한을 여러개 줄 수 있기때문에 collection안에 들어있음

        GrantedAuthority authority = authorities.iterator().next();

        // 현재 인증된 사용자의 role
        String role = authority.getAuthority();

        model.addAttribute("role", role);
        model.addAttribute("id", id);

        return "home";
    }

}
