package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.ReservationDTO;
import kr.co.aura.aurastay.dto.SpecialRequestDTO;
import kr.co.aura.aurastay.repository.ReservationRepository;
import kr.co.aura.aurastay.util.ReservationUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ReservationServiceImpl implements ReservationService {
    private final ReservationRepository reservationRepository;
    @Override
    public List<SpecialRequestDTO> getSpecialRequests() {
        return reservationRepository.getSpecialRequests();
    }

    @Override
    public int getRemainingRooms(HashMap<String, Object> rsrvMap) {
        return reservationRepository.getRemainingRooms(rsrvMap);
    }

    @Override
    @Transactional
    public int addReservation(Map<String, Object> jsonData) {
        int result = 0;

        // 결제 진행중에 이미 숙소가 나가서 현재 결제 상태에서 숙소가 나갈 수 있음. -> 다시 결제 취소 해주기
        String checkin = (String) jsonData.get("checkin");
        String checkout = (String) jsonData.get("checkout");

        int accommodationNo = (Integer) jsonData.get("accommodationNo");
        int roomNo = (Integer) jsonData.get("roomNo");

        int countDay = ReservationUtil.getCheckDay(checkin, checkout);

        int roomCountMin = 0;

        // 객실 수량 확인
        for (int i=0; i<countDay; i++) {
            HashMap<String, Object> rsrvMap = ReservationUtil.getRoomCheck(checkin, accommodationNo, roomNo, i);

            int acmCount = getRemainingRooms(rsrvMap); // 숙소 번호, 룸 번호, 해당 일자
            if(i==0) roomCountMin = acmCount;
            roomCountMin = Math.min(roomCountMin, acmCount); // 제일 작은 수량
        }

        // 객실 수량이 없으면 다시 숙소 상세보기로 이동함.
        // 0개이면 애초에 숙소 상세보기에서 예약하기 버튼 활성화 안함. -> 근데 고민하다가 누를 수 있으니 누르면 다시 리다이렉트 -> 해당 숙소 정보로 가기
        if(roomCountMin > 0){
            result = 1; // 숙소 결제 가능
        } else {
            ReservationDTO dto = ReservationDTO.builder()
//                    .accommodation_no()
                    .build();
        }


        return result;
    }
}
