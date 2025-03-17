package kr.co.aura.aurastay;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

//@MapperScan("kr.co.aura.aurastay.repository")
@SpringBootApplication
public class AurastayApplication {

    public static void main(String[] args) {
        SpringApplication.run(AurastayApplication.class, args);
    }

}
