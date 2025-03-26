package kr.co.aura.aurastay.dto;

// 제공자Response에서 구현
// 제공자별로 맞춰주기위한..?
public interface OAuth2Response {
    // 제공자 naver, google, kakao
    String getProvider();
    // 제공자가 발급해주는 아이디
    String getProviderId();
    // 이메일
    String getEmail();
    // 이름
    String getName();
}
