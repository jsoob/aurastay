package kr.co.aura.aurastay.dto;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
public class CustomOAuth2User implements OAuth2User {
    private final OAuth2Response oAuth2Response;
    private final String authority;

    @Override
    public Map<String, Object> getAttributes() {
        return null;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority(authority));
        return authorities;
    }

    // 이름
    @Override
    public String getName() {
        return oAuth2Response.getName();
    }
    // provider_id
    public  String getUsername() {return oAuth2Response.getProvider()+"_"+oAuth2Response.getProviderId();
    }
    // 이메일
    public String getEmail() {return oAuth2Response.getEmail();}
}
