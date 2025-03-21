package kr.co.aura.aurastay.security;

import kr.co.aura.aurastay.dto.BusinessDTO;
import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.repository.BusinessRepository;
import kr.co.aura.aurastay.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class CustomUserDetailsService implements UserDetailsService {
    private final MemberRepository memberRepository;
    private final BusinessRepository businessRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        // 일반 사용자 조회
        MemberDTO member = memberRepository.findByUsername(username);
        if (member != null) { // 가입된 사용자라면
            return new CustomUserDetail(member, List.of(new SimpleGrantedAuthority(member.getAuthority())));
        }

        // 사업자 조회
        BusinessDTO business = businessRepository.findByUsername(username);
        if (business != null) { // 가입된 사업자라면
            return new CustomUserDetail(business, List.of(new SimpleGrantedAuthority(business.getAuthority())));
        }

        // 둘 다 없으면 예외 발생
        throw new UsernameNotFoundException("해당 사용자를 찾을 수 없습니다: " + username);

    }
}
