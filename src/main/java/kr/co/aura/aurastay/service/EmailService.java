package kr.co.aura.aurastay.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import kr.co.aura.aurastay.dto.EmailMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.SpringTemplateLoader;

import java.util.Random;

@Slf4j
@Service
@RequiredArgsConstructor
public class EmailService {
    private final JavaMailSender mailSender;

    public String sendEmail(EmailMessage emailMessage, String type) {
        String authNum = createCode(); // 인증코드 생성

        MimeMessage mimeMessage = mailSender.createMimeMessage();

            try {
                MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, false, "UTF-8");
                mimeMessageHelper.setTo(emailMessage.getTo());
                mimeMessageHelper.setSubject(emailMessage.getSubject());
                mimeMessageHelper.setText(authNum);

                mailSender.send(mimeMessage);
                return authNum;

            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }

    }


    // 인증번호 및 임시 비밀번호 생성 메서드
    private String createCode() {
        Random random = new Random();
        StringBuffer key = new StringBuffer();
        for (int i = 0; i < 13; i++) { // 8번 반복
            int index = random.nextInt(3); // 랜덤값 : 0, 1, 2
            switch (index) {
                case 0: key.append((char)(random.nextInt(26)+65)); break; // 대문자
                case 1: key.append((char)(random.nextInt(26)+97)); break; // 소문자
                case 2: key.append(random.nextInt(10)); break; // 숫자 0~9
            }
        }
        log.info("생성한 비밀번호 코드 : {}", key.toString());
        return key.toString();
    }
}
