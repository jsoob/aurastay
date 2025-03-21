package kr.co.aura.aurastay.security;

import kr.co.aura.aurastay.dto.BusinessDTO;
import kr.co.aura.aurastay.dto.CommonUser;
import kr.co.aura.aurastay.dto.MemberDTO;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Getter
public class CustomUserDetail implements UserDetails {
    private final MemberDTO member;
    private final BusinessDTO business;
    private final Collection<? extends GrantedAuthority> authorities;

    public CustomUserDetail(MemberDTO member, Collection<? extends GrantedAuthority> authorities) {
        this.member = member;
        this.business = null;
        this.authorities = authorities;
    }
    public CustomUserDetail(BusinessDTO business, Collection<? extends GrantedAuthority> authorities) {
        this.member = null;
        this.business = business;
        this.authorities = authorities;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return (member!=null)? member.getMemberPassword() : business.getBusinessPassword();
    }

    @Override
    public String getUsername() {
        return (member!=null)? member.getMemberEmail() : business.getBusinessEmail();
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
