package kr.co.aura.aurastay.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class MemberController {

    @GetMapping("/view")
    public String showReviewForm() {
        return "view"; // => /WEB-INF/views/view.jsp 로 매핑됨
    }

    @PostMapping("/submitReview")
    public String handleReview(@RequestParam("review") String review,
                               @RequestParam(value = "image", required = false) MultipartFile image) {
        // 리뷰 처리 로직 작성
        return "redirect:/thankyou"; // 예시: 등록 후 페이지
    }
}