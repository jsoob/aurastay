package kr.co.aura.aurastay.security;

import kr.co.aura.aurastay.dto.BusinessDTO;
import kr.co.aura.aurastay.dto.MUser;
import kr.co.aura.aurastay.dto.MemberDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

@RequiredArgsConstructor
// 로그인 검증 로직
public class CustomUserDetail implements UserDetails {
//    private BusinessDTO businessDTO;
//    private MemberDTO memberDTO;
    private final MUser mUser;



    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority("ROLE_USER"));
    }

    @Override
    public String getPassword() {
        return mUser.getPassword();
    }

    @Override
    public String getUsername() {
        return mUser.getEmail();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
