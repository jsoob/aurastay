package kr.co.aura.aurastay.controller;

// 숙소 정보와 관련되어 있는 컨트롤러

import kr.co.aura.aurastay.dto.AccommodationDTO;
import kr.co.aura.aurastay.service.AccommodationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

// controller -> service -> repository

@RequiredArgsConstructor
@Controller
public class AccommodationController {

    // 서비스 추가
    private final AccommodationService accommodationService;

    ////////////////////////// 숙소 정보 저장하기 //////////////////////////
    // 숙소 정보를 입력하는 페이지로 연결
    @GetMapping("/acmAdd")
    public String accommodation(Model model) {
        AccommodationDTO dto = new AccommodationDTO();
        model.addAttribute("dto", dto);
        return "accommodation/acmAdd";
    }

    // 숙소 정보를 입력하고 난 뒤의 페이지를 연결
    @PostMapping("/acmAdd")
    public String accommodationForm(@ModelAttribute("dto") AccommodationDTO dto, Model model) {
        // 숙소 정보를 저장하는 서비스 호출
        accommodationService.add(dto);      // add 메서드 호출해서 추가하기

        model.addAttribute("dto", dto);
        return "redirect:/acmList";      // 숙소 목록 페이지로 리다이렉트
    }


    // 첨부 파일 정보 입력 후 보내기 (요청을 보내는 getmapping 사용하기)
    @PostMapping("/upload")
    public String uploadFile(@RequestParam("files") MultipartFile[] files, AccommodationDTO dto) {

        // 1. 저장할 폴더의 파일 경로 설정
        String uploadDirectory = "E:/upload/";      // 파일의 경로는 현재 내pc 기준으로 파일 업로드 경로 설정 처리

        // 1-1. 폴더가 없다면 자동으로 생성
        File uploadDirectoryFile = new File(uploadDirectory);
            // 만약, 업로드할 파일의 디렉토리가 존재하지 않는다면?
        if(!uploadDirectoryFile.exists()) {
            uploadDirectoryFile.mkdirs();       // 디렉토리를 만든다
        }

        // 1-2. 여러 개의 파일을 저장할 리스트 생성하기 (이름, 경로) : 일단 체크해볼 것
        List<MultipartFile> filenames = new ArrayList<>();
        List<MultipartFile> filepaths = new ArrayList<>();

        // 향상된 for문 사용
        for(MultipartFile file : files){
            if(!file.isEmpty()){
                String saveFileName = file.getOriginalFilename();   // 2. 업로드할 파일의 저장할 원래 이름
                
                // 3. 파일 저장할 경로 설정
                File saveFile = new File(uploadDirectory, saveFileName);

                // 4. 파일을 실제 폴더에 저장하기
                try {
                    file.transferTo(saveFile);
                // 5. DTO에 저장된 파일 정보 추가
                dto.setFilename(saveFileName);
                dto.setFilepath(saveFile.getAbsolutePath());

                    System.out.println("성공했다면 파일의 이름을 출력 >>>>> " + saveFileName);

                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        }

        // 6. (파일이 여러 개인 경우를 대비해서) DTO 에 저장
//        if (!filenames.isEmpty()) {
//            dto.setFilename(String.join(", ", filenames));  // 파일명 리스트 → 문자열 변환
//            dto.setFilepath(String.join(", ", filepaths));  // 파일 경로 리스트 → 문자열 변환
//        }


        // 숙소를 등록할 때 파일의 이미지 정보 또한 같이 등록되는 것을 목표로 한다
        return "redirect:/acmList";
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
