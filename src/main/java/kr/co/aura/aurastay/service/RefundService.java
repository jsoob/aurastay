package kr.co.aura.aurastay.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.co.aura.aurastay.dto.RefundRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class RefundService {

//    @Value("${portone.api.key}")
    @Value("imp75421638") // 고객사 식별코드
    private String apiKey;

    @Value("${payment.PORTONE_API_SECRET}")
    private String apiSecret;

    private final RestTemplate restTemplate; // 의존성 주입 안되서 에러뜸.
    // -> config에 추가해서 의존성 완료
    private final ObjectMapper objectMapper;

    /**
     * PortOne 환불 처리
     */
    public boolean processRefund(RefundRequest refundRequest) {
        try {
            // 1. PortOne 인증 토큰 발급
            String accessToken = getAccessToken();
            if (accessToken == null) {
                log.error("PortOne 인증 토큰 발급 실패");
                return false;
            }

            // 2. 환불 요청
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setBearerAuth(accessToken);

            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("imp_uid", refundRequest.getImpUid());  // 결제 고유번호
            requestBody.put("merchant_uid", refundRequest.getMerchantUid()); // 주문 번호 (옵션)
            requestBody.put("amount", refundRequest.getAmount());  // 환불 금액
            requestBody.put("reason", refundRequest.getReason());  // 환불 사유

            HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(requestBody, headers);
            ResponseEntity<String> response = restTemplate.postForEntity("https://api.iamport.kr/payments/cancel", requestEntity, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                JsonNode jsonResponse = objectMapper.readTree(response.getBody());
                if (jsonResponse.get("code").asInt() == 0) {
                    log.info("환불 성공: {}", jsonResponse.get("response"));
                    return true;
                } else {
                    log.error("환불 실패: {}", jsonResponse.get("message").asText());
                }
            }
        } catch (Exception e) {
            log.error("환불 처리 중 예외 발생", e);
        }
        return false;
    }

    /**
     * PortOne 인증 토큰 요청
     */
    private String getAccessToken() {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            Map<String, String> requestBody = new HashMap<>();
            requestBody.put("imp_key", apiKey);
            requestBody.put("imp_secret", apiSecret);


            HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(requestBody, headers);
            ResponseEntity<String> response = restTemplate.postForEntity("https://api.iamport.kr/users/getToken", requestEntity, String.class);

            System.out.println("response = " + response);
            if (response.getStatusCode() == HttpStatus.OK) {
                JsonNode jsonResponse = objectMapper.readTree(response.getBody());
                if (jsonResponse.get("code").asInt() == 0) {
                    return jsonResponse.get("response").get("access_token").asText();
                } else {
                    log.error("토큰 발급 실패: {}", jsonResponse.get("message").asText());
                }
            }
        } catch (Exception e) {
            log.error("PortOne 인증 토큰 요청 중 예외 발생", e);
        }
        return null;
    }
}