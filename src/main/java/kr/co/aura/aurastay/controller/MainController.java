package kr.co.aura.aurastay.controller;

import jakarta.servlet.http.HttpSession;
import kr.co.aura.aurastay.dto.*;
import kr.co.aura.aurastay.repository.RoomImageRepository;
import kr.co.aura.aurastay.security.CustomUserDetail;
import kr.co.aura.aurastay.service.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@Controller
public class MainController {
    private final MemberService memberService;
    private final BusinessService businessService;
    private final LikesService likesService;
    private final MainService mainService;


    // 사용자 메인 페이지
    @GetMapping({"/", "/index", "/main"})
    public String index(@AuthenticationPrincipal Object principal
            , HttpSession session
            , Model model) {
        // 사용자 정보 session에 저장
        MemberDTO member = null;

        if (principal instanceof OAuth2User) { // 소셜로그인 사용자
            member = memberService.findByProviderId(((OAuth2User) principal).getName());
        } else if (principal instanceof UserDetails) { // 일반 사용자
            member = ((CustomUserDetail) principal).getMember();
        }

        session.setAttribute("dto", member);

        // 로그인한 사용자라면
        if (member != null) {
            // wish 정보 가져오기
            List<LikesDTO> wish = likesService.getWish(member.getMemberNo());
            model.addAttribute("wish", wish);
        }

        // 숙소리스트 가져오기
//        List<HashMap<String, Object>> list = mainService.getPagedAccommodations(0,12); // 처음엔 1페이지이고 12개만 보이게
//
//        Map<Integer, List<Map<String, Object>>> groupedAccommodations = list.stream()
//                .filter(accommodation -> accommodation.get("accommodationNo") != null) // null 방지
//                .collect(Collectors.groupingBy(accommodation -> (Integer) accommodation.get("accommodationNo")));
//
//        model.addAttribute("groupedAccommodations", groupedAccommodations);
//
        // 전체 숙소 수
        int totalCount = mainService.getTotalCount();

        /// //페이징
        // 첫 페이지
        model.addAttribute("currentPage", 1);
        // 총 페이지수 (전체 숙소 수/12)
        model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / 12));

        return "index";
    }

    @GetMapping("/loadAccommodationList")
    public ResponseEntity<?> loadAccommodationList(@RequestParam(defaultValue = "1") int page,
                                                   @RequestParam(defaultValue = "12") int size,
                                                   Model model,
                                                   HttpSession session) {
        //////// 숙소리스트 페이징처리 ///////////

        int offset = (page - 1) * size;
        // 12개의 숙소정보 가져오기
        List<HashMap<String, Object>> accommodations = mainService.getPagedAccommodations(offset, size);

        // accommodationNo기준으로 그룹핑
        Map<Integer, List<Map<String, Object>>> groupedAccommodations = accommodations.stream()
                .filter(accommodation -> accommodation.get("accommodationNo") != null) // null 방지
                .collect(Collectors.groupingBy(accommodation -> (Integer) accommodation.get("accommodationNo")));

        // (Integer,List) 형태로 model에 담음
        model.addAttribute("groupedAccommodations", groupedAccommodations);

        // 현재페이지
        model.addAttribute("currentPage", page);

        // 전체 숙소 수
        int totalCount = mainService.getTotalCount();

        // 총 페이지수 (전체 숙소 수/12)
        model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / 12));

        return ResponseEntity.ok(groupedAccommodations);
    }

    // 로그인
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    public String loginOk(@ModelAttribute MemberDTO dto) {
        return "redirect:/";
    }

    // 비밀번호 찾기 폼
    @GetMapping("/findPassword")
    public String findPassword() {
        return "findPassword";
    }

    // 비밀번호 재설정할 이메일 정보를 세션에 저장
    @PostMapping("/storeEmailSession")
    public ResponseEntity<?> storeEmailInSession(@RequestBody Map<String, String> request, HttpSession session) {
        String email = request.get("email");
        // 세션에 담기
        session.setAttribute("resetEmail", email);
        return ResponseEntity.ok().build();
    }

    // 비밀번호 재설정 폼으로 이동
    @GetMapping("/resetPassword")
    public String resetPasswordPage(HttpSession session, Model model) {
        // 접근 제한을 위해 세션값 확인
        String email = (String) session.getAttribute("resetEmail");

        if (email == null) {
            return "redirect:/findPassword";  // 세션이 없으면 접근 불가
        } else {
            // member에 있는지
            MemberDTO member = memberService.findByEmail(email);
            if (member != null) {
                model.addAttribute("member", member);
                model.addAttribute("user", 0);
            }

            // business에 있는지
            BusinessDTO business = businessService.findByEmail(email);
            if (business != null) {
                model.addAttribute("business", business);
                model.addAttribute("user", 1);
            }
        }

        return "resetPassword";
    }

    // 비밀번호 재설정 처리
    @PostMapping("/resetPassword")
    public String resetPasswordOk(@RequestParam("password") String password,
                                  @RequestParam("email") String email,
                                  @RequestParam("user") int user,
                                  HttpSession session) {

        if (user == 0) { // member
            MemberDTO memberDTO = MemberDTO.builder()
                    .memberPassword(password)
                    .memberEmail(email)
                    .build();
            memberService.resetPassword(memberDTO);
        } else if (user == 1) { // business
            BusinessDTO businessDTO = BusinessDTO.builder()
                    .businessPassword(password)
                    .businessEmail(email)
                    .build();
            businessService.resetPassword(businessDTO);
        }

        // 모든 세션 정보 삭제 (로그아웃 상태로 만듦)
        session.invalidate();
        return "redirect:/login";
    }

    // 이메일 중복 확인
    @PostMapping("/checkEmail")
    public ResponseEntity<Map<String, Boolean>> checkEmail(@RequestParam String email) {
        boolean exists = memberService.isMemberExist(email) || businessService.isBusinessExist(email); // member 또는 business에 존재하는 이메일
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);
        return ResponseEntity.ok(response);
    }

    // 비밀번호 찾기 이메일 확인
    @PostMapping("/findPassword/checkEmail")
    public ResponseEntity<Map<String, Boolean>> findPasswordCheckEmail(@RequestParam String email) {
        boolean exists = memberService.isAllMemberExist(email) || businessService.isAllBusinessExist(email); // member 또는 business에 존재하는 이메일인지 확인(탈퇴회원 포함)


        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists);
        return ResponseEntity.ok(response);
    }


}
