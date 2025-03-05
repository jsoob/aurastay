package kr.co.aura.aurastay.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

    @GetMapping("/stays")
    public String stays(Model model) {
        return "reservation/reservationForm";
    }
    @GetMapping("/album_ex")
    public String album_ex(Model model) {
        return "reservation/album_ex";
    }

}
