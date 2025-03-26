package kr.co.aura.aurastay.config;

import org.jasypt.encryption.StringEncryptor;
import org.jasypt.encryption.pbe.PooledPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.SimpleStringPBEConfig;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration // 설정 정보가 있는 클래스
public class JayptConfig {
    // 의존성 주입 완료
    @Value("${encryptor.password}")
    String password;

    // 암호화해주는 Bean
    @Bean (name = "jasyptStringEncryptor")
    public StringEncryptor stringEncryptor() {
        PooledPBEStringEncryptor encryptor = new PooledPBEStringEncryptor();

        SimpleStringPBEConfig config = new SimpleStringPBEConfig();
        config.setPassword(password);
        System.out.println("Encryptor password: " + password);

        // encryptor에서 제공하는 암호화 알고리즘 사용할 것이다.
        config.setAlgorithm("PBEWithMD5AndDES");
        config.setKeyObtentionIterations("1000"); // 반복할 해싱 횟수
        config.setPoolSize("1"); // 인스턴스 pool
        config.setProviderName("SunJCE");
        config.setSaltGeneratorClassName("org.jasypt.salt.RandomSaltGenerator"); // 어떤 암호화 방식
        config.setStringOutputType("base64"); // key 인코딩 방식

        encryptor.setConfig(config);

        return encryptor;
    }
}
