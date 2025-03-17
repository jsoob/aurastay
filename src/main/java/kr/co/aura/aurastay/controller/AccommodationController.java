package kr.co.aura.aurastay.controller;

// 숙소 정보와 관련되어 있는 컨트롤러

import kr.co.aura.aurastay.dto.AccommodationDTO;
import kr.co.aura.aurastay.dto.CategoryDTO;
import kr.co.aura.aurastay.dto.KeywordDTO;
import kr.co.aura.aurastay.dto.RoomDTO;
import kr.co.aura.aurastay.service.AccommodationService;
import kr.co.aura.aurastay.service.CategoryService;
import kr.co.aura.aurastay.service.KeywordService;
import kr.co.aura.aurastay.service.RoomService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

// controller -> service -> repository

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/accommodation")
@Controller
public class AccommodationController {

    // 서비스 추가
    private final AccommodationService accommodationService;
    private final CategoryService categoryService;
    private final KeywordService keywordService;
    private final RoomService roomService;

    ////////////////////////// 숙소 정보 저장하기 //////////////////////////
    // 숙소 정보를 입력하는 페이지 (숙소 등록 폼으로 연결)
    @GetMapping("/acmAdd")
    public String accommodation(@ModelAttribute("dto") AccommodationDTO dto,
                                Model model) {

        // 카테고리와 키워드 정보 (서비스에서) 가져오기
        List<CategoryDTO> categories = categoryService.getCategories();
        List<KeywordDTO> keywords = keywordService.getAllKeywords();  // KeywordDTO로 수정

//        System.out.println("조회된 카테고리 개수: " + categories.size());
//        System.out.println("조회된 키워드 개수: " + keywords.size());
//        for (CategoryDTO category : categories) {
//            System.out.println("카테고리 이름: " + category.getCategoryName());
//        }
//        for (KeywordDTO keyword : keywords) {
//            System.out.println("키워드 이름: " + keyword.getKeywordName());
//        }

        // 카테고리와 키워드 목록을 모델에 추가해서 jsp로 전달
        model.addAttribute("categories", categories);
//        System.out.println("카테고리 리스트 : " + dto.getAcmName());
        model.addAttribute("keywords", keywords);
        model.addAttribute("dto", dto);

        // DTO에 변환된 값 저장
        dto.setCategories(categories);
        dto.setKeywords(keywords);

        return "accommodation/acmAdd";
    }

    // 숙소 정보를 입력하고 난 뒤의 페이지를 연결 (숙소 등록 처리)
        // 1. @RequestParam("체크인, 체크아웃") 메서드 추가
    @PostMapping("/acmAdd")
    public String accommodationForm(@ModelAttribute("dto") AccommodationDTO dto,
                                     @ModelAttribute("roomDto") RoomDTO roomDTO,
                                     @RequestParam("checkinTime") String checkinTime,
                                    @RequestParam("checkoutTime") String checkoutTime,
                                    @RequestParam(value ="keywordNo", required = false ) Integer[] keywordNo,    // 키워드 선택
                                    @RequestParam(value = "files", required = false) MultipartFile[] files, // 파일 업로드 추가
                                    Model model) {
    log.info("accommodation >>>>>>>>>>>>>>>>>  :{} {}", roomDTO, roomDTO.getRoomName());

        // 파일이 null 이거나 빈 배열일 경우 처리
        if (files == null || files.length == 0) {
            System.out.println("파일이 존재하지 않습니다.");
            // 파일이 없을 경우 별도의 처리를 추가 or 바로 진행
        }

        // 날짜와 시간을 합쳐서 LocalDateTime으로 변환
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");

        // 날짜 문자열을 LocalTime 으로 변환
        LocalTime checkin = LocalTime.parse(checkinTime, formatter);
        LocalTime checkout = LocalTime.parse(checkoutTime, formatter);

        // DTO에 변환된 값 저장
        dto.setCheckinTime(checkinTime);
        dto.setCheckoutTime(checkoutTime);

        // // 숙소 이미지를 저장하는 파일 업로드 기능 추가 // //
        String uploadDirectory = "D:/upload/";  // 업로드 경로 설정 : 나중에 프로퍼티 파일로 변경 (확인해볼 것)
        File uploadDirectoryFile = new File(uploadDirectory);
        if (!uploadDirectoryFile.exists()) {
            uploadDirectoryFile.mkdirs();  // 폴더가 없다면 생성
        }

        // 파일 정보를 저장할 리스트
        List<String> filenames = new ArrayList<>();
        List<String> filepath = new ArrayList<>();

        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                String saveFileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();  // 중복 방지
                File saveFile = new File(uploadDirectory, saveFileName);  // 저장할 파일 경로

                try {
                    file.transferTo(saveFile);                  // 파일을 실제 경로에 저장
                    filenames.add(saveFileName);                // 파일 이름 저장
                    filepath.add(saveFile.getAbsolutePath());   // 파일 경로 저장
                } catch (IOException e) {
                    throw new RuntimeException("파일 업로드 중 오류가 발생하였습니다.", e);
                }
            }
        }

        // 여러 파일의 경로와 이름을 DTO에 저장
            // 만약 파일의 이름이 비어있는 공백이 아니라면?
        if (!filenames.isEmpty()) {
            dto.setFilenames(filenames);            // 파일명 리스트 저장
            dto.setFilepath(filepath);              // 파일 경로 리스트 저장
        }

//        // 키워드가 선택된 경우 DTO에 저장
//        if (keywordNo != null && keywordNo.length > 0) {
//            // Integer[] 배열을 List<Integer>로 변환
//            List<Integer> keywordList = new ArrayList<>();
//            for (Integer key : keywordNo) {
//                keywordList.add(key);   // Integer[] 를 List<Integer>로 변환
//            }
//
//            // 변환된 List를 DTO에 저장
//            dto.setKeywordNo(keywordList);      // List<Integer>로 설정
//
//        }


        // keyword_no 가 올바르게 설정되었으면, 숙소 정보 추가 처리
        // 숙소 정보를 저장하는 서비스 호출
        accommodationService.add(dto);      // add 메서드 호출해서 추가하기
        roomService.roomAdd(roomDTO);
        return "redirect:/accommodation/acmList";
    }

//    @PostMapping("/upload")
//    public String uploadFile(@RequestParam("files") MultipartFile[] files, AccommodationDTO dto) {
//        String uploadDirectory = "E:/upload/";  // 업로드 경로 설정
//
//        File uploadDirectoryFile = new File(uploadDirectory);
//        if (!uploadDirectoryFile.exists()) {
//            uploadDirectoryFile.mkdirs();  // 폴더가 없다면 생성
//        }
//
//        // 파일 정보를 저장할 리스트
//        List<String> filenames = new ArrayList<>();
//        List<String> filepaths = new ArrayList<>();
//
//        for (MultipartFile file : files) {
//            if (!file.isEmpty()) {
//                String saveFileName = file.getOriginalFilename();  // 파일 이름
//                File saveFile = new File(uploadDirectory, saveFileName);  // 저장할 파일 경로
//
//                try {
//                    file.transferTo(saveFile);  // 파일을 실제 경로에 저장
//                    filenames.add(saveFileName);  // 파일 이름 저장
//                    filepaths.add(saveFile.getAbsolutePath());  // 파일 경로 저장
//                } catch (IOException e) {
//                    throw new RuntimeException(e);
//                }
//            }
//
//        }
//
//        // 여러 파일의 경로와 이름을 DTO에 저장
//            // 만약 파일의 이름이 비어있는 공백이 아니라면?
//        if (!filenames.isEmpty()) {
//            dto.setFilenames(filenames);  // 파일명 리스트 저장
//            dto.setFilepaths(filepaths);  // 파일 경로 리스트 저장
//        }
//
//        return "redirect:/acmList";  // 숙소 목록 페이지로 리다이렉트
//    }

    // 숙소 정보 : 목록 전체 조회
    @GetMapping("/acmList")
    public String accommodationList(Model model) {
        List<AccommodationDTO> list = accommodationService.selectAll();
        model.addAttribute("list", list);
        return "/accommodation/acmList";
    }

    // 상세 정보 조회
    @GetMapping("/acmInfo")
    public String accommodationInfo(@RequestParam("acmNo") int acmNo, Model model){
        AccommodationDTO dto = accommodationService.selectOne(acmNo);
        model.addAttribute("dto", dto);

        return "/accommodation/acmInfo";
    }


    // 숙소 정보 변경
    @PostMapping("/acmUpdate")
    public String accommodationUpdate(@RequestParam("acmNo") int acmNo, Model model) {
        accommodationService.acmUpdate(acmNo);
        return "redirect:/accommodation/acmList";
    }

    // 숙소 정보 삭제
    @PostMapping("/acmDelete")
    public String accommodationDelete(@RequestParam("acmNo") int acmNo, Model model) {
        accommodationService.acmDelete(acmNo);
        return "redirect:/accommodation/acmList";
    }

}
