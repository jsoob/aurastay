package kr.co.aura.aurastay;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableScheduling;

//@MapperScan("kr.co.aura.aurastay.repository")
@SpringBootApplication
@EnableScheduling // 스케줄러 활성화
public class AurastayApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(AurastayApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(AurastayApplication.class, args);
    }

}
