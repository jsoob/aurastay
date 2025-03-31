package kr.co.aura.aurastay.controller;

// 숙소 정보와 관련되어 있는 컨트롤러

import kr.co.aura.aurastay.dto.*;
import kr.co.aura.aurastay.service.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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

    @Value("${upload.directory}")
    private String uploadDirectory;     // 상대 경로 주입받기

    // 서비스 추가
    private final AccommodationService accommodationService;
    private final CategoryService categoryService;
    private final KeywordService keywordService;
    private final RoomService roomService;
    private final AmenitiesService amenitiesService;
    private final RoomImageService roomImageService;

    /// /////////////////////// 숙소 정보 저장하기 //////////////////////////
    // 숙소 정보를 입력하는 페이지 (숙소 등록 폼으로 연결)
    @GetMapping("/acmAdd")
    public String accommodation(@ModelAttribute("dto") AccommodationDTO dto,
//                                RedirectAttributes redirectAttributes,
                                Model model) {

        // 카테고리, 키워드, 편의시설 정보 (서비스에서) 가져오기
        List<CategoryDTO> categories = categoryService.getCategories();
        List<KeywordDTO> keywords = keywordService.getAllKeywords();    // KeywordDTO로 수정
        List<AmenitiesDTO> amenities = amenitiesService.getAmenities();    // 편의시설 목록 추가

//        System.out.println("조회된 카테고리 개수: " + categories.size());
//        System.out.println("조회된 키워드 개수: " + keywords.size());
//        for (CategoryDTO category : categories) {
//            System.out.println("카테고리 이름: " + category.getCategoryName());
//        }
//        for (KeywordDTO keyword : keywords) {
//            System.out.println("키워드 이름: " + keyword.getKeywordName());
//        }

        // 카테고리, 키워드, 편의시설 목록을 모델에 추가해서 jsp로 전달
        model.addAttribute("categories", categories);
//        System.out.println("카테고리 리스트 : " + dto.getAcmName());
        model.addAttribute("keywords", keywords);
        model.addAttribute("dto", dto);
        model.addAttribute("amenities", amenities);

        // DTO에 변환된 값 저장
        dto.setCategories(categories);
        dto.setKeywords(keywords);
//        dto.setAmenities(amenities);

        return "accommodation/acmAdd";
    }

    // 이미지 파일 관련 메서드
    @GetMapping("/views/{filename}")
    @ResponseBody       // 사용자의 요청을 다이렉트로 보낸다
    public byte[] viewImage(@PathVariable String filename, Model model) throws IOException {
        Path filePath = Paths.get(uploadDirectory, filename);
        System.out.println("이미지가 여기로 오고있니?>>>>>>>>>>>>>>>>>>>>>>>");
        // 모든 경로를 읽어서 반환한다
        // 예외처리는 throws 로 던진다
        return Files.readAllBytes(filePath);
    }


    // 숙소 정보를 입력하고 난 뒤의 페이지를 연결 (숙소 등록 처리)
    // 1. @RequestParam("체크인, 체크아웃") 메서드 추가
    @PostMapping("/acmAdd")
    public String accommodationForm(@ModelAttribute("dto") AccommodationDTO dto,
                                    @ModelAttribute("roomDto") RoomDTO roomDTO,
                                    @RequestParam("checkinTime") String checkinTime,
                                    @RequestParam("checkoutTime") String checkoutTime,
                                    @RequestParam(value = "keywordNo", required = false) Integer[] keywordNo,
                                    @RequestParam(value = "amenities", required = false) List<Integer> amenities,
                                    @RequestParam(value = "files", required = false) MultipartFile[] files,
                                    RedirectAttributes redirectAttributes,
                                    Model model) {

        // RedirectAttributes : 리다이렉트 할 때 데이터를 담아서 보내고자 할 때 사용한다
        //                      리다이렉트는 새롭게 Get요청을 보내는 것이기 때문에 요청객체와 응답객체가 새로 생겨 model에 값을 담아도 소멸!

        // 현재 작업 디렉토리를 로그로 출력
        log.info("현재 작업 디렉토리를 로그로 출력 >>>>>>>>>>>>> : {}", System.getProperty("user.dir"));
        log.info("accommodation >>>>>>>>>>>>>>>>>  :{} {}", roomDTO, roomDTO.getRoomName());

        // 날짜와 시간을 합쳐서 LocalDateTime으로 변환
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        LocalTime checkin = LocalTime.parse(checkinTime, formatter);
        LocalTime checkout = LocalTime.parse(checkoutTime, formatter);

        // DTO에 변환된 값 저장
        dto.setCheckinTime(checkinTime);
        dto.setCheckoutTime(checkoutTime);

        // 편의시설을 DTO에 설정
        if (amenities != null) {
            dto.setAmenities(amenities);
        }

        // 숙소 정보를 먼저 저장
        accommodationService.add(dto);

        // 파일이 null 이거나 빈 배열일 경우 처리
        if (files != null && files.length > 0) {
            // 파일 업로드 경로 설정
//            String uploadDirectory = "C:/upload/";  // 실제 경로 (절대경로)
//            String uploadDirectory = "/upload/"; // 상대 경로


            File uploadDirectoryFile = new File(uploadDirectory);
            if (!uploadDirectoryFile.exists()) {
                uploadDirectoryFile.mkdirs();  // 폴더가 없다면 생성
                log.info("uploadDirectory 가 생성이 된다면 >>>>>>>>>>>> : {}", uploadDirectory);
            } else {
                log.info("uploadDirectory가 이미 존재한다면 >>>>>>>>>>>>>> : {}", uploadDirectory);
            }

            // 파일 정보를 저장할 리스트
            List<String> filenames = new ArrayList<>();
            List<String> filepath = new ArrayList<>();

            // 이미지 파일 처리 (파일 업로드 처리)
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    // 파일 이름 중복 방지를 위한 처리
                    String saveFileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();  // 중복 방지
                    File saveFile = new File(uploadDirectory, saveFileName);  // 저장할 파일 경로
                    System.out.println("save 파일 값 있냐? " + saveFile.getAbsolutePath());
                    try {
                        file.transferTo(saveFile);                  // 파일을 실제 경로에 저장
                        filenames.add(saveFileName);                // 파일 이름 저장
                        filepath.add(saveFile.getAbsolutePath());   // 파일 경로 저장
                    } catch (IOException e) {
                        log.error("파일 업로드 중 오류 발생 >>>>>>>>> : {}", e.getMessage());
                        throw new RuntimeException("파일 업로드 중 오류가 발생하였습니다.", e);
                    }
                }
            }

            // 여러 파일의 경로와 이름을 DTO에 저장
            if (!filenames.isEmpty()) {
                dto.setFilenames(filenames);            // 파일명 리스트 저장
                dto.setFilepath(filepath);              // 실제 파일 경로 리스트 저장 (선택 사항)

                // 클라이언트 접근 URL 생성
                List<String> clientFilePaths = new ArrayList<>();
                for (String filename : filenames) {
                    clientFilePaths.add("/upload/" + filename); // 클라이언트가 접근할 수 있는 URL 추가
                }
                dto.setClientFilepath(clientFilePaths); // DTO에 클라이언트 접근 경로 설정
            }


            // 이미지 정보를 저장하는 로직 추가
            for (int i = 0; i < filenames.size(); i++) {
                RoomImageDTO roomImage = new RoomImageDTO();
                roomImage.setFilename(filenames.get(i));
                roomImage.setFilepath(filepath.get(i));
                roomImage.setAcmNo(dto.getAcmNo()); // 숙소 번호와 연결

                // RoomImageService를 통해 이미지 저장
                roomImageService.saveRoomImage(roomImage);

            }
        } else {
            System.out.println("파일이 존재하지 않습니다.");
        }


        // 숙소 번호를 roomDTO에 설정
        roomDTO.setAccommodationNo(dto.getAcmNo()); // 이 코드가 필요합니다.

        log.info("방의 상세정보 >>>>>>>>>>> {} ", roomDTO);
        // 객실 정보가 있으면 추가 (객실 등록)
        roomService.roomAdd(roomDTO);   // url의 파라미터로 값이 저장된다
        // 파일 업로드가 성공한 경우
        redirectAttributes.addAttribute("message", "파일 업로드 성공");


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
    public String accommodationList(@RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
                                    @RequestParam(name = "search", required = false) String search,
                                    Model model) {

        int pageSize = 10;      // 페이지당 항목 수
        List<AccommodationDTO> list = accommodationService.selectAll(currentPage, pageSize, search);

        // 총 숙소 개수를 가져오는 서비스 메서드 호출
        int totalItems = accommodationService.countAll(search);       // 총 숙소 개수
        // 총 페이지 수 계산
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        // 페이지 블록 계산
        int blockSize = 10;             // 블록당 페이지 수
        int currentBlock = (currentPage - 1) / blockSize;       // 현재 블록
        int startPage = currentBlock * blockSize + 1;           // 블록의 시작 페이지
        int endPage = Math.min(startPage + blockSize - 1, totalPages);  // 블록의 끝 페이지

//        // 페이지네이션 범위 계산
//        int startPage = Math.max(1, currentPage - 4);           // 현재 페이지 기준으로 5개 페이지 앞부터
//        int endPage = Math.min(currentPage, startPage + 9);     // 시작 페이지에서 10개까지

        // 만약 10개가 안된다면?
//        if (endPage - startPage < 9){
//            startPage = Math.max (1, endPage - 9);          // 뒤쪽으로 조정
//        }

        // 모델에 데이터 추가
        // 모델에 데이터 추가
        model.addAttribute("list", list);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);     // 시작 페이지
        model.addAttribute("endPage", endPage);         // 마지막 페이지
        model.addAttribute("search", search);           // 검색어

        // 다음 버튼 표시 여부 설정
        model.addAttribute("hasNext", endPage < totalPages);        // 다음 버튼이 보여질지 여부를 결정

        // jsp 페이지로 이동
        return "accommodation/acmList";
    }

    // 상세 정보 조회
    @GetMapping("/acmInfo")
    public String accommodationInfo(@RequestParam("acmNo") int acmNo, Model model) {

        // 숙소 정보 조회
        AccommodationDTO dto = accommodationService.selectOne(acmNo);   // 서비스 호출
        // 해당 숙소의 객실 정보 조회
        List<RoomDTO> roomList = roomService.findRoomByAccommodation(acmNo); // 객실 정보 조회 추가
        // 카테고리 정보 조회
        CategoryDTO categories = categoryService.getCategoryById(dto.getCategoryNo());          // 카테고리 목록을 가져오는 서비스 호출
        // 키워드 정보 조회
        KeywordDTO keyword = keywordService.getKeywordById(dto.getKeywordNo());               // 키워드 목록을 가져오는 서비스 호출

        model.addAttribute("dto", dto); // 모델에 추가
        model.addAttribute("category", categories);   // 카테고리 목록 추가
        model.addAttribute("keyword", keyword);     // 키워드 목록 추가
        model.addAttribute("roomList", roomList);  // 객실 정보를 모델에 추가
//        model.addAttribute("amenities", amenities);

        log.info("Accommodation DTO >>>>>>>>>>>>>>>>>> : {}", dto);
        log.info("Retrieved Category >>>>>>>>>>>>>>>>>>> : {}", categories);
        log.info("Retrieved Keyword >>>>>>>>>>>>>>>>>>> : {}", keyword);
        log.info("Retrieved Room >>>>>>>>>>>>>>>>>>> : {}", roomList);
//        log.info("편의시설 상세 정보 조회 불러와지고 있는가 >>>>>>>>>>>> : {}", amenities);

        return "accommodation/acmInfo";
    }


    // 숙소 정보 변경 : 숙소정보 화면을 불러오도록 @GetMapping 작성
    @GetMapping("/acmModify")
    public String acmModify(@RequestParam("acmNo") int acmNo, Model model) {
        // 숙소 정보를 조회하고 모델에 추가하는 로직

        // 숙소 정보를 데이터베이스에서 조회
        AccommodationDTO dto = accommodationService.selectOne(acmNo);

        // 객실 정보 조회
        List<RoomDTO> roomList = roomService.findRoomByAccommodation(acmNo);

        // 카테고리, 키워드, 편의시설 조회 (전체)
        List<CategoryDTO> categories = categoryService.getCategories();
        List<KeywordDTO> keywords = keywordService.getAllKeywords();
        List<AmenitiesDTO> amenities = amenitiesService.getAmenities();

        // 기존에 선택(등록)된 카테고리, 키워드, 편의시설 정보 가져오기
        List<Integer> selectedAmenities = accommodationService.getSelectedAmenities(acmNo);
        List<Integer> selectedKeywords = accommodationService.getSelectedKeywords(acmNo);


        // 모델에 숙소 정보를 추가
        model.addAttribute("dto", dto);
        model.addAttribute("roomList", roomList);
        model.addAttribute("categories", categories);
        model.addAttribute("keywords", keywords);
        model.addAttribute("amenities", amenities);
        model.addAttribute("selectedAmenities", selectedAmenities);
        model.addAttribute("selectedKeywords", selectedKeywords);

        return "accommodation/acmModify"; // 수정 페이지로 포워딩
    }

    // 숙소 정보 변경을 위한 객실 정보 불러오기 (모달에서 호출할 수 있는 API 작성 : AJAX를 통해 REST API 작성해야하기 때문)
    @GetMapping("/rooms/{acmNo}")
    @ResponseBody
    public List<RoomDTO> getRoomsByAccommodation(@PathVariable int acmNo) {
        return roomService.findRoomByAccommodation(acmNo); // 숙소 번호로 객실 정보 조회
    }

    // 숙소 등록
    // 숙소 수정
    // 객실 등록
    // 객실 수정


    @PostMapping("/acmModify")
    public String accommodationUpdate(
            @RequestParam(value = "acmNo") int acmNo, // 숙소 번호
            @RequestParam(value = "acmName", required = false) String acmName, // 숙소명
            @RequestParam(value = "acmAddress", required = false) String acmAddress, // 숙소 주소
            @RequestParam(value = "acmTel", required = false) String acmTel, // 숙소 연락처
            @RequestParam(value = "checkinTime", required = false) String checkinTime, // 체크인 시간
            @RequestParam(value = "checkoutTime", required = false) String checkoutTime, // 체크아웃 시간
            @RequestParam(value = "contents", required = false) String contents, // 숙소 설명
            @RequestParam(value = "categoryNo", required = false) int categoryNo, // 카테고리 번호
            @RequestParam(value = "amenities", required = false) List<Integer> amenities, // 편의시설 목록
            @RequestParam(value = "files", required = false) MultipartFile[] files, // 업로드된 이미지 파일
            @RequestParam(value = "keywordNo", required = false) Integer keywordNo, // 단일 키워드 번호

            Model model) {

        // 1. 기존 편의시설 삭제 (배열로 여러 개의 값을 받기 때문에 편의시설을 삭제 후 다시 update하는 방식으로 진행한다)
        accommodationService.deleteAmenities(acmNo);
        // 편의시설 삭제하는 것처럼 기존 이미지 삭제 로직 똑같이 진행하기
        accommodationService.deleteExistingImages(acmNo);

        // AccommodationDTO 객체 생성
        AccommodationDTO dto = AccommodationDTO.builder()
                .acmNo(acmNo)
                .acmName(acmName)
                .acmAddress(acmAddress)
                .acmTel(acmTel)
                .checkinTime(checkinTime)
                .checkoutTime(checkoutTime)
                .contents(contents)
                .categoryNo(categoryNo)
                .amenities(amenities) // 편의시설 설정
                .keywordNo(keywordNo) // 단일 키워드 번호 설정
                .build();

        // 3. 새로운 편의시설 추가
        if (amenities != null) {
            for (Integer amenityNo : amenities) {
                accommodationService.addAmenities(acmNo, amenityNo);
            }
        }

        // 새로운 이미지 처리 : 파일 처리 로직
        if (files != null && files.length > 0) {
            List<String> filenames = new ArrayList<>();
            List<String> filepath = new ArrayList<>();

            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    String saveFileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                    File saveFile = new File(uploadDirectory, saveFileName);
                    try {
                        file.transferTo(saveFile); // 파일을 실제 경로에 저장
                        filenames.add(saveFileName);
                        filepath.add(saveFile.getAbsolutePath());
                    } catch (IOException e) {
                        log.error("파일 업로드 중 오류 발생 >>>>>>>>> : {}", e.getMessage());
                        throw new RuntimeException("파일 업로드 중 오류가 발생하였습니다.", e);
                    }
                }
            }
            dto.setFilenames(filenames);
            dto.setFilepath(filepath);

            // 클라이언트 접근 URL 생성
            List<String> clientFilePaths = new ArrayList<>();
            for (String filename : filenames) {
                clientFilePaths.add("/upload/" + filename); // 클라이언트가 접근할 수 있는 URL 추가
            }
            dto.setClientFilepath(clientFilePaths); // DTO에 클라이언트 접근 경로 설정

            // 새로운 이미지 정보를 데이터 베이스에 추가
            accommodationService.addImages(acmNo, filenames, filepath);
        }

        log.info("acmNo : {}, amenities : {} 제대로 담기는가? >>>>>>>>>>>> ", acmNo, amenities);
        // 데이터베이스 업데이트
        accommodationService.updateAccommodation(dto); // 숙소 정보 업데이트

//        // 객실 정보 업데이트
//        for (int i = 0; i < roomNames.length(); i++) {
//            RoomDTO roomDTO = new RoomDTO();
//            roomDTO.setAcmNo(acmNo);
////            roomDTO.setRoomNo(roomNo[i]); // 객실 번호 설정 확인
//            roomDTO.setRoomName(roomNames);
//            roomDTO.setRoomQty(roomQtys);
//            roomDTO.setRoomCapacity(roomCapacities);
//            roomDTO.setRoomPrice(Integer.parseInt(roomPrices)); // 가격 변환
//            roomDTO.setRoomDiscount(Integer.parseInt(roomDiscounts)); // 할인율 변환
//            roomDTO.setRoomContents(roomContents);
//            roomDTO.setRoomViewType(roomViewTypes);
//            roomDTO.setAccommodationNo(acmNo); // 숙소 번호 설정
//
//            roomService.roomUpdate(roomDTO); // 객실 정보 업데이트
//
//            // 로그 추가 (디버깅용)
//            log.info("Updated room (객실 정보가 정상적으로 업로드가 되고 있는가? >>>>>>>>>>> ) : {} >>>>>>>>> ", roomDTO);
//        }

        // 수정 완료 후 목록 페이지로 리다이렉트
        return "redirect:/accommodation/acmList"; // 숙소 목록 페이지로 이동
    }



    // 숙소 정보 삭제 (단, 예약내역이 있을 경우 삭제가 되지 않음)
    @DeleteMapping("/{acmNo}")
    public ResponseEntity<String> deleteAccommodation(@PathVariable int acmNo) {
        // 예약 내역이 존재하는지 체크
        boolean hasReservations = accommodationService.checkReservations(acmNo);

        if (hasReservations) {
            return ResponseEntity.status(403).body("예약 내역이 존재하여 삭제할 수 없습니다."); // 403 Forbidden
        }

        // 숙소 및 관련 객실 삭제
        accommodationService.acmDelete(acmNo);

        return ResponseEntity.ok("숙소와 관련된 모든 정보가 삭제되었습니다."); // 200 OK
    }
}