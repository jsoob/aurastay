package kr.co.aura.aurastay.controller;

import kr.co.aura.aurastay.dto.EmailMessage;
import kr.co.aura.aurastay.dto.EmailPostDTO;
import kr.co.aura.aurastay.dto.EmailResponseDTO;
import kr.co.aura.aurastay.service.EmailService;
import lombok.RequiredArgsConstructor;
import org.apache.coyote.Response;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@Controller
@RequestMapping("/sendEmail")
public class EmailController {
    private final EmailService emailService;

    // 비밀번호 찾기
    @PostMapping("/findPassword")
    public ResponseEntity sendPassword(@RequestBody EmailPostDTO emailPostDTO) {
        EmailMessage emailMessage = EmailMessage.builder()
                .to(emailPostDTO.getEmail())
                .subject("[AURASTAY] 비밀번호 찾기 인증코드 안내해드립니다.")
                .build();
        String authNum = emailService.sendEmail(emailMessage, "password");
        EmailResponseDTO emailResponseDTO = new EmailResponseDTO();
        emailResponseDTO.setCode(authNum);
        return ResponseEntity.ok().body(emailResponseDTO);
    }

    // 회원가입 이메일 인증
    @PostMapping("/emailCode")
    public ResponseEntity sendEmail(@RequestBody EmailPostDTO emailPostDTO) {
        EmailMessage emailMessage = EmailMessage.builder()
                .to(emailPostDTO.getEmail())
                .subject("[AURASTAY] 회원가입 인증코드 안내해드립니다.")
                .build();
        String authNum = emailService.sendEmail(emailMessage, "email");
        EmailResponseDTO emailResponseDTO = new EmailResponseDTO();
        emailResponseDTO.setCode(authNum);
        return ResponseEntity.ok().body(emailResponseDTO);
    }

}
