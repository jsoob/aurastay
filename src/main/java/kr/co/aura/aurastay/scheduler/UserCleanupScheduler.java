package kr.co.aura.aurastay.scheduler;

import kr.co.aura.aurastay.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@RequiredArgsConstructor
@Component
public class UserCleanupScheduler {
    private final MemberRepository memberRepository;

    // 매일 새벽 2시에 실행
    @Scheduled(cron = "0 0 0 * * ?")
    public void deleteExpiredMembers() {
        memberRepository.deleteOldWithdrawnMember();
    }
}
