package kr.co.aura.aurastay.controller;

// 숙소 정보와 관련되어 있는 컨트롤러

import kr.co.aura.aurastay.dto.AccommodationDTO;
import kr.co.aura.aurastay.dto.CategoryDTO;
import kr.co.aura.aurastay.dto.KeywordDTO;
import kr.co.aura.aurastay.service.AccommodationService;
import kr.co.aura.aurastay.service.CategoryService;
import kr.co.aura.aurastay.service.KeywordService;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.javassist.compiler.ast.Keyword;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

// controller -> service -> repository

@RequiredArgsConstructor
@Controller
public class AccommodationController {

    // 서비스 추가
    private final AccommodationService accommodationService;
    private final CategoryService categoryService;
    private final KeywordService keywordService;

    ////////////////////////// 숙소 정보 저장하기 //////////////////////////
    // 숙소 정보를 입력하는 페이지로 연결
    @GetMapping("/acmAdd")
    public String accommodation(Model model) {
        AccommodationDTO dto = new AccommodationDTO();
        model.addAttribute("dto", dto);
        return "accommodation/acmAdd";
    }

    // 숙소 정보를 입력하고 난 뒤의 페이지를 연결
        // 1. @RequestParam("체크인, 체크아웃") 메서드 추가
// 숙소 정보를 입력하고 난 뒤의 페이지를 연결
    @PostMapping("/acmAdd")
    public String accommodationForm(@ModelAttribute("dto") AccommodationDTO dto,
                                    @RequestParam("checkinTime") String checkin,
                                    @RequestParam("checkoutTime") String checkout,
                                    Model model) {

        // 카테고리와 키워드 목록을 서비스에서 조회하기
        List<CategoryDTO> categories = categoryService.getAllCategories();
        List<KeywordDTO> keywords = keywordService.getAllKeywords();  // KeywordDTO로 수정

        // 날짜와 시간을 합쳐서 LocalDateTime으로 변환
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

        // 날짜 문자열을 LocalTime 으로 변환
        LocalDateTime checkinTime = LocalDateTime.parse(checkin, formatter);
        LocalDateTime checkoutTime = LocalDateTime.parse(checkout, formatter);

        // DTO에 변환된 값 저장
        dto.setCheckinTime(checkinTime);
        dto.setCheckoutTime(checkoutTime);

        // 숙소 정보를 저장하는 서비스 호출
        accommodationService.add(dto);      // add 메서드 호출해서 추가하기

        // 카테고리와 키워드 목록을 모델에 추가해서 jsp로 전달
        model.addAttribute("categories", categories);
        model.addAttribute("keywords", keywords);
        model.addAttribute("dto", dto);

        return "redirect:/acmList";      // 숙소 목록 페이지로 리다이렉트
    }

    @PostMapping("/upload")
    public String uploadFile(@RequestParam("files") MultipartFile[] files, AccommodationDTO dto) {
        String uploadDirectory = "E:/upload/";  // 업로드 경로 설정

        File uploadDirectoryFile = new File(uploadDirectory);
        if (!uploadDirectoryFile.exists()) {
            uploadDirectoryFile.mkdirs();  // 폴더가 없다면 생성
        }

        // 파일 정보를 저장할 리스트
        List<String> filenames = new ArrayList<>();
        List<String> filepaths = new ArrayList<>();

        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                String saveFileName = file.getOriginalFilename();  // 파일 이름
                File saveFile = new File(uploadDirectory, saveFileName);  // 저장할 파일 경로

                try {
                    file.transferTo(saveFile);  // 파일을 실제 경로에 저장
                    filenames.add(saveFileName);  // 파일 이름 저장
                    filepaths.add(saveFile.getAbsolutePath());  // 파일 경로 저장
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        }

        // 여러 파일의 경로와 이름을 DTO에 저장
        if (!filenames.isEmpty()) {
            dto.setFilenames(filenames);  // 파일명 리스트 저장
            dto.setFilepaths(filepaths);  // 파일 경로 리스트 저장
        }

        return "redirect:/acmList";  // 숙소 목록 페이지로 리다이렉트
    }



    // 숙소 정보 : 목록 전체 조회
    @GetMapping("/acmList")
    public String accommodationList(Model model) {
        List<AccommodationDTO> list = accommodationService.selectAll();
        model.addAttribute("list", list);
        return "accommodation/acmList";
    }

    // 상세 정보 조회
    @GetMapping("/acmInfo")
    public String accommodationInfo(){
        return "accommodation/acmInfo";
    }


}
