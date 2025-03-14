package kr.co.aura.aurastay.security;

import kr.co.aura.aurastay.dto.CommonUser;
import kr.co.aura.aurastay.dto.MemberDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@RequiredArgsConstructor
public class CustomUserDetail implements UserDetails {
    //    private final CommonUser commonUser;
    private final User user;
//    private final MemberDTO member;

//    public CustomUserDetail(MemberDTO member) {
//        this.member = member;
//    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
//        Collection<GrantedAuthority> collection = new ArrayList<GrantedAuthority>();
//        collection.add(new GrantedAuthority() {
//            @Override
//            public String getAuthority() {
//                System.out.println("getAuthority : " + user.getAuthorities());
//                return user.getAuthorities();
//            }
//        });
        return user.getAuthorities();
    }

    @Override
    public String getPassword() {
        return user.getPassword();
    }

    @Override
    public String getUsername() {
        return user.getUsername();
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
