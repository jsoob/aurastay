package kr.co.aura.aurastay.security;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@RequiredArgsConstructor
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final AuthenticationSuccessHandler authenticationSuccessHandler;

    /* 패스워드 암호화 */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /* 필터체인 */
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        /* 임시 테스트 나중에 권한별로 접근 경로 바꿔야함 */
                        .requestMatchers("/business/business").hasRole("BUSINESS")
                        /* 이외의 요청들은 인증 필요없음 */
                        .anyRequest().permitAll());


        /* 커스텀 로그인 화면으로 */
        http
                .formLogin(auth ->
                        auth.loginPage("/member/emailLogin")
                                .loginProcessingUrl("/loginProcess")
                                .successHandler(authenticationSuccessHandler)
                                .defaultSuccessUrl("/")
                                .permitAll()
                );

        /* csrf공격 방어 해제 */
        http
                .csrf(auth -> auth.disable());


        // 로그아웃 기능
        http
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout=true")
                        .invalidateHttpSession(true) // 세션무효화
                        .deleteCookies("JSESSIONID") // 쿠키가 남아있다면 제거
                        .permitAll()
                );

        return http.build();
    }
}
