package kr.co.aura.aurastay.dto;

import java.util.Map;

public class NaverResponse implements OAuth2Response{

    private final Map<String, Object> attributes;

    // 네이버는 받아오는 값 안에 response={} 이런식으로 되어있어서 생성자에 이렇게 다시 주입
    public NaverResponse(Map<String, Object> attributes) {
        this.attributes = (Map<String, Object>) attributes.get("response");
    }

    @Override
    public String getProvider() {
        return "naver";
    }

    @Override
    public String getProviderId() {
        return attributes.get("id").toString();
    }

    @Override
    public String getEmail() {
        return attributes.get("email").toString();
    }

    @Override
    public String getName() {
        return attributes.get("name").toString();
    }
}
