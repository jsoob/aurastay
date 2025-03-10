package kr.co.aura.aurastay.controller;

import ch.qos.logback.core.model.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
    /* main */
    @GetMapping({"/main","","/"})
    public String main(Model model) {
        return "index";
    }
}
