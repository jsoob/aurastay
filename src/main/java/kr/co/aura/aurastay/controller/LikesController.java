package kr.co.aura.aurastay.controller;

import jakarta.servlet.http.HttpSession;
import kr.co.aura.aurastay.dto.LikesDTO;
import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.service.LikesService;
import kr.co.aura.aurastay.service.MainService;
import kr.co.aura.aurastay.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@RequestMapping("/wishlist")
@RequiredArgsConstructor
@Controller
public class LikesController {

    private final LikesService likesService;
    private final MemberService memberService;
    private final MainService mainService;


    // 위시리스트 조회
    @GetMapping("")
    public String wishList(HttpSession session, Model model) {

        Object dto = session.getAttribute("dto");

        int memberNo = ((MemberDTO) dto).getMemberNo();

        List<HashMap<String, Object>> list = likesService.wishList(memberNo);

        // accommodationNo를 기준으로 그룹화
        Map<Integer, List<HashMap<String, Object>>> groupedWishes = list.stream()
                .collect(Collectors.groupingBy(wish -> (Integer) wish.get("accommodationNo")));

        model.addAttribute("groupedWishes", groupedWishes);

        List<HashMap<String, Object>> reviewList = mainService.getReview();
        model.addAttribute("reviewList", reviewList);

        return "member/wishList";
    }

    // 추가
    @PostMapping("/add")
    public ResponseEntity<?> addWishList(@RequestBody LikesDTO likesDTO) {

        // 위시리스트에 없다면
        if (!likesService.existsWish(likesDTO)) {
            likesService.addWishList(likesDTO);
        }

        return ResponseEntity.ok().build();
    }

    // 삭제
    @DeleteMapping("/remove")
    public ResponseEntity<?> removeWishList(@RequestBody LikesDTO likesDTO) {

        likesService.removeWishList(likesDTO);

        return ResponseEntity.ok().build();
    }

}
