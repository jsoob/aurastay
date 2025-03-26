package kr.co.aura.aurastay.handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Collection;

@Component
public class CustomAuthenticationHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        // 사용자의 권한(Role) 가져오기
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

        // 기본 url
        String redirectUrl = "/";

        // 권한에 따라 시작페이지 다르게 설정
        for (GrantedAuthority authority : authorities) {
            String role = authority.getAuthority();

            if ("ROLE_MEMBER".equals(role)) {
                redirectUrl = "/";
                break;
            } else if ("ROLE_BUSINESS".equals(role)) {
                redirectUrl = "/business/dashboard";
                break;
            }
        }

        // 로그인 후 해당 URL로 리다이렉트
        response.sendRedirect(redirectUrl);
    }
}
