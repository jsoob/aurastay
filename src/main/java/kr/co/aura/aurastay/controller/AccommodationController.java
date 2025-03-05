package kr.co.aura.aurastay.controller;

// 숙소 정보와 관련되어 있는 컨트롤러

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@RequiredArgsConstructor
@Controller
public class AccommodationController {

//    private final AccommodationRepository accommodationRepository;

    // 숙소 정보를 입력하는 페이지로 연결
    @GetMapping("/acmAdd")
    public String accommodation() {
        return "accommodation/acmAdd";      // accommodation/acmAdd.jsp 로 이동
    }

    // 숙소 정보를 입력하고 난 뒤의 페이지를 연결
    @PostMapping("/acmAdd")
    public String accommodationForm(){
        return "accommodation/acmAdd";      // 돌아가기
    }




    // 숙소 정보 조회/변경
    @GetMapping("/acmInfo")
    public String accommodationInfo() {
        return "accommodation/acmInfo";     // accommodation/acmInfo.jsp 로 이동
    }


}
