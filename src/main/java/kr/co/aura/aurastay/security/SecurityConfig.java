package kr.co.aura.aurastay.security;

import com.nimbusds.oauth2.sdk.auth.ClientSecretPost;
import kr.co.aura.aurastay.service.CustomOAuth2UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientManager;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientProvider;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientProviderBuilder;
import org.springframework.security.oauth2.client.endpoint.DefaultAuthorizationCodeTokenResponseClient;
import org.springframework.security.oauth2.client.endpoint.OAuth2AccessTokenResponseClient;
import org.springframework.security.oauth2.client.endpoint.OAuth2AuthorizationCodeGrantRequest;
import org.springframework.security.oauth2.client.endpoint.OAuth2AuthorizationCodeGrantRequestEntityConverter;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.web.DefaultOAuth2AuthorizedClientManager;
import org.springframework.security.oauth2.client.web.OAuth2AuthorizedClientRepository;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@RequiredArgsConstructor
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final AuthenticationSuccessHandler authenticationSuccessHandler;
    private final CustomOAuth2UserService customOAuth2UserService;

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
                        .requestMatchers("/wishlist/**","/member/myPage","/member/withdrawal","/reservation/stays","/reservation/payment","/reservation/mystays","/reservation/mystay","/reservation/staycancel").hasRole("MEMBER") // MEMBER
                        .requestMatchers("/business/main","/accommodation/acmAdd","/accommodation/acmList","/accommodation/acmModify","/accommodation/acmInfo","/reservation/rsList","/reservation/cancelList","/total","/review","/notice","/qnaBoard","/reservation/rsList","/reservation/cancelList","/reservation/bAcmList","/reservation/bRoomList","/reservation/bRsList","/reservation/getRsCancel","/reservation/cancelRs","/reservation/cancelRsPay").hasRole("BUSINESS") // BUSINESS
                        /* 이외의 요청들은 인증 필요없음 */
                        .anyRequest().permitAll());


        /* 커스텀 로그인 화면으로 */
        http
                .formLogin(auth ->
                                auth.loginPage("/login")
                                        .loginProcessingUrl("/loginProcess")
                                        .successHandler(authenticationSuccessHandler)
//                                .defaultSuccessUrl("/")
                                        .permitAll()
                );

        /* csrf공격 방어 해제 */
        http
                .csrf(auth -> auth.disable());

        // 로그아웃 기능
        http
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/")
                        .invalidateHttpSession(true) // 세션무효화
                        .deleteCookies("JSESSIONID") // 쿠키가 남아있다면 제거
                        .permitAll()
                );

//                http
//                .oauth2Client(Customizer.withDefaults());

        http
                .oauth2Login(oauth2 ->
                        oauth2.loginPage("/login")
                                .defaultSuccessUrl("/", true)
                                .userInfoEndpoint(userInfoEndpointConfig ->
                                        userInfoEndpointConfig.userService(customOAuth2UserService)));

        // 소셜 로그인
//        http
//                .oauth2Login(oauth2 ->
//                        oauth2.loginPage("/login")
//                                .defaultSuccessUrl("/",true)
//                                .userInfoEndpoint(userInfoEndpointConfig ->
//                                        userInfoEndpointConfig.userService(customOAuth2UserService)) // oauth2Login 성공 이후의 설정을 시작
//                );

        return http.build();
    }

    // 카카오 OAuth2 클라이언트 인증 방식 변경
    @Bean
    public OAuth2AccessTokenResponseClient<OAuth2AuthorizationCodeGrantRequest> authorizationCodeTokenResponseClient() {
        DefaultAuthorizationCodeTokenResponseClient tokenResponseClient = new DefaultAuthorizationCodeTokenResponseClient();
        tokenResponseClient.setRequestEntityConverter(new OAuth2AuthorizationCodeGrantRequestEntityConverter());
        return tokenResponseClient;
    }

}
