package kr.co.aura.aurastay.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@RequiredArgsConstructor
@Controller
public class MainController {

//    private final MainService mainService;

    @GetMapping("/main")
    public String mainPage() {
        return "main";
    }



}
