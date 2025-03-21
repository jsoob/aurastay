package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.AccommodationDTO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class AccommodationRepositoryTest {

    @Autowired
    private AccommodationRepository accommodationRepository;

    // @BeforeEach : 해당 테스트 클래스를 초기화할 때 딱 한 번 수행되는 메서드
    @BeforeEach
    @DisplayName("샘플용 숙소 목록 조회 테스트 데이터 300건 추가")
    @Test
    public void setUp() {
        // 더미 데이터 생성
        for (int i = 1; i <= 300; i++) {
            AccommodationDTO dto = new AccommodationDTO();
            dto.setAcmName("숙소 이름 test  " + i);
            dto.setAcmAddress("주소 test " + i);
            dto.setAcmTel("010 - " + String.format("%02d", i * 1111));
            dto.setCheckinTime("14:00");
            dto.setCheckoutTime("11:00");
            dto.setContents("숙소 내용" + i);     // 숙소내용은 없어도 되긴 하지만 일단 임시로 넣기
            dto.setCategoryNo(1);       // 임시로 고정된 값 설정
            dto.setKeywordNo(1);        // 임시로 고정된 값 설정
            dto.setBusinessNo(1121457574);      // 임시로 거정된 사업자번호 설정

            accommodationRepository.add(dto);           // 더미 데이터 DB에 추가

        }

//        @Test
//        public void testDummyData() {
//            // 데이터 수가 300개인지 확인하는 테스트
//            assertEquals(300, accommodationRepository.countAll());
//        }

    }

}