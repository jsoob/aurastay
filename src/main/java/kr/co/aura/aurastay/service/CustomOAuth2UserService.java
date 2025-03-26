package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.*;
import kr.co.aura.aurastay.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {
    // 멤버 테이블에 접근
    private final MemberRepository memberRepository;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        OAuth2User oAuth2User = super.loadUser(userRequest);

        // 어떤 정보가 넘어오는지 확인
        log.info("loadUser >>>>>>>>>>>>>> {}",oAuth2User);

        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        log.info("registrationId >>>>>>>>>>>>>> {}",registrationId);

        OAuth2Response oAuth2Response = null;


        if(registrationId.equals("naver")){
            oAuth2Response = new NaverResponse(oAuth2User.getAttributes());
        } else if(registrationId.equals("google")){
            oAuth2Response = new GoogleResponse(oAuth2User.getAttributes());
        } else if(registrationId.equals("kakao")){
            oAuth2Response = new KakaoResponse(oAuth2User.getAttributes());
        }

        String providerId = oAuth2Response.getProvider()+"_"+oAuth2Response.getProviderId();

        MemberDTO member = memberRepository.findByProviderId(providerId); // providerId값으로 정보 찾아옴
        // 소셜로그인은 member만 가능하기때문에
        String authority = "ROLE_MEMBER";

        // 처음 소셜로그인하는 사용자라면
        if(member == null){
            MemberDTO member1 = new MemberDTO();
            member1.setProviderId(providerId);
            member1.setMemberEmail(oAuth2Response.getEmail());
            member1.setMemberNickname(oAuth2Response.getName());
            member1.setMemberName(oAuth2Response.getName());
//            member1.setProvider(oAuth2Response.getProvider()); //이걸로 이메일사용자, 소셜로그인사용자 구분지어야함
            member1.setAuthority(authority);
            // 소셜 로그인은 패스워드 null
            member1.setMemberPassword(null);
            // 저장
            memberRepository.insertMember(member1);

        }

        return new CustomOAuth2User(oAuth2Response,authority);
    }
}
