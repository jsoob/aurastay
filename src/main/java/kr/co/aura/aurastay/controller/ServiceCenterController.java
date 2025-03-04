package kr.co.aura.aurastay.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@RequiredArgsConstructor
@Controller
public class ServiceCenterController {

//    private final ServiceCenter serviceCenter;

    // 공지사항
    @GetMapping("/notice")
    public String notice() {
        return "notice";
    }

    // 문의게시판
    @GetMapping("/qnaBoard")
    public String qnaBoard() {
        return "qnaBoard";
    }

}
