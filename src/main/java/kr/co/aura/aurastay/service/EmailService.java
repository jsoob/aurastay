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

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
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

                // JSP 파일을 읽어서 HTML로 변환

                String htmlContent = null;
                if(type.equals("email")){
                htmlContent = new String(Files.readAllBytes(
                        Paths.get("src/main/webapp/WEB-INF/views/email/email-template.jsp")),
                        StandardCharsets.UTF_8
                );
                } else if(type.equals("password")){
                    htmlContent = new String(Files.readAllBytes(
                            Paths.get("src/main/webapp/WEB-INF/views/email/email-template2.jsp")),
                            StandardCharsets.UTF_8);
                }

                // ${name} 값을 실제 데이터로 치환
                htmlContent = htmlContent.replace("${authNum}", authNum);

//                mimeMessageHelper.setText(authNum);
                mimeMessageHelper.setText(htmlContent, true); // HTML로 전송

                mailSender.send(mimeMessage);
                return authNum;

            } catch (MessagingException e) {
                throw new RuntimeException(e);
            } catch (IOException e) {
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
