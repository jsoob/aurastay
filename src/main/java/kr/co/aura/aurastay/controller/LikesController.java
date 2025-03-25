package kr.co.aura.aurastay.controller;

import jakarta.servlet.http.HttpSession;
import kr.co.aura.aurastay.dto.LikesDTO;
import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.service.LikesService;
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


    // 위시리스트 조회
    @GetMapping("")
    public String wishList(HttpSession session, Model model) {

        Object dto = session.getAttribute("dto");
        int memberNo = ((MemberDTO) dto).getMemberNo();

        List<HashMap<String, Object>> list = likesService.wishList(memberNo);

        // accommodationNo를 기준으로 그룹화
        Map<Integer, List<HashMap<String, Object>>> groupedWishes = list.stream()
                .collect(Collectors.groupingBy(wish -> (Integer) wish.get("accommodationNo")));

        log.info(">>>>>>>>>>>>>>>>groupedWishes : {}", groupedWishes); // map형태 Integer, ArrayList
        log.info(">>>>>>>>>>>>>>>>>>>list : {}", list);

        model.addAttribute("groupedWishes", groupedWishes);


        model.addAttribute("list", list);
        return "member/wishlist";
    }

    // 추가
    @PostMapping("/add")
    public ResponseEntity<?> addWishList(@RequestBody LikesDTO likesDTO) {

        likesService.addWishList(likesDTO);

        return ResponseEntity.ok().build();
    }

    // 삭제
    @DeleteMapping("/remove")
    public ResponseEntity<?> removeWishList(@RequestBody LikesDTO likesDTO) {

        likesService.removeWishList(likesDTO);

        return ResponseEntity.ok().build();
    }

}
