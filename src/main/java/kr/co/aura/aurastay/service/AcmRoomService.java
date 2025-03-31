package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.*;
import kr.co.aura.aurastay.repository.*;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class AcmRoomService {
    // 숙소 정보
    private final AcmRoomRepository acmRoomRepository;
    // 예약 정보
    private final ReservationRepository reservationRepository;
    // 결제 정보
    private final PaymentRepository paymentRepository;
    // 예약 특별요청
    private final ReservationRequestRepository reservationRequestRepository;

    public AcmDTO selectRoomDetail(AcmDTO acmDTO) {
        acmDTO = acmRoomRepository.selectRoomDetail(acmDTO);

        RoomImageDTO roomImageOne = acmRoomRepository.getImageOne(acmDTO.getAcmNo());
        acmDTO.setFilename(roomImageOne.getFilename());

        return acmDTO;
    }

    public List<AccommodationDTO> getBnsAcmList(int businessNo, int currentPage, int pageSize, String search) {
        int offset = (currentPage - 1) * pageSize;      // offset 계산
        // 만약, 검색어가 없거나 공백인 경우에는 ?
        if (search == null || search.isEmpty()) {
            // 전체 숙소 목록을 보여준다
            return acmRoomRepository.getBnsAcmList(businessNo, offset, pageSize, null);   // null 로 검색어를 전달
        } else {
            // 그게 아니라면? 작성자가 입력한 검색 결과를 보여준다
            return acmRoomRepository.getBnsAcmList(businessNo, offset, pageSize, search);     // repository 메서드 호출 (해당 부분에서 offset과 pageSize 전달) : 데이터베이스에서 목록 가져오기
        }
    }
    public int countAcmAll(int businessNo, String search) {
        return acmRoomRepository.countAcmAll(businessNo, search);
    }

    public List<RoomDTO> getBnsRoomList(int acmNo, int currentPage, int pageSize, String search) {
        int offset = (currentPage - 1) * pageSize;      // offset 계산
        // 만약, 검색어가 없거나 공백인 경우에는 ?
        if (search == null || search.isEmpty()) {
            // 전체 객실 목록을 보여준다
            return acmRoomRepository.getBnsRoomList(acmNo, offset, pageSize, null);   // null 로 검색어를 전달
        } else {
            // 그게 아니라면? 작성자가 입력한 검색 결과를 보여준다
            return acmRoomRepository.getBnsRoomList(acmNo, offset, pageSize, search);     // repository 메서드 호출 (해당 부분에서 offset과 pageSize 전달) : 데이터베이스에서 목록 가져오기
        }
    }
    public int countRoomAll(int acmNo, String search) {
        return acmRoomRepository.countRoomAll(acmNo, search);
    }

}
