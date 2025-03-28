package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.*;
import kr.co.aura.aurastay.repository.*;
import kr.co.aura.aurastay.util.ReservationUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLOutput;
import java.util.*;

@Service
@RequiredArgsConstructor
public class ReservationServiceImpl implements ReservationService {
    private final AcmRoomRepository acmRoomRepository;
    private final SpecialRequestRepository specialRequestRepository;
    private final ReservationRepository reservationRepository;
    private final ReservationRequestRepository reservationRequestRepository;
    private final PaymentRepository paymentRepository;
    private final ReservationCancelRepository reservationCancelRepository;
    // 예약자 조회
    private final MemberRepository memberRepository;

    @Override
    public List<SpecialRequestDTO> getSpecialRequests() {
        return specialRequestRepository.getSpecialRequests();
    }

    @Override
    public int getRemainingRooms(HashMap<String, Object> rsrvMap) {
        return reservationRepository.getRemainingRooms(rsrvMap);
    }

    @Override
    @Transactional
    public int addReservation(Map<String, Object> jsonData) {
        int result = 0;

        System.out.println("payment = ");
        System.out.println(jsonData.get("payment"));
//        System.out.println(jsonData.get("payment") instanceof Map);
        Map<String, Object> payment = (Map<String, Object>) jsonData.get("payment");
        Map<String, Integer> amount = (Map<String, Integer>) payment.get("amount");
        Map<String, String> method = (Map<String, String>) payment.get("method");

//        for (Object key : amount.keySet()) {
//            System.out.println(key + " = " + amount.get(key));
//            System.out.println(amount.get(key) instanceof Integer);
//        }

        System.out.println("specialRequests = ");
        System.out.println(jsonData.get("specialRequests") instanceof List);
        ArrayList<String> specialRequests = (ArrayList<String>) jsonData.get("specialRequests");
//        ArrayList<Integer> specialRequests = null;
//        for (String specialRequest : (ArrayList<String>) jsonData.get("specialRequests")) {
//            specialRequests.add(Integer.parseInt(specialRequest));
//        }

        // 결제 진행중에 이미 숙소가 나가서 현재 결제 상태에서 숙소가 나갈 수 있음. -> 다시 결제 취소 해주기
        String checkinDate = (String) jsonData.get("checkinDate");
        String checkoutDate = (String) jsonData.get("checkoutDate");

        int accommodationNo = (Integer) jsonData.get("accommodationNo");
        int roomNo = (Integer) jsonData.get("roomNo");

        int countDay = ReservationUtil.getCheckDay(checkinDate, checkoutDate);

        int roomCountMin = 0;

        // 객실 수량 확인
        for (int i=0; i<countDay; i++) {
            HashMap<String, Object> rsrvMap = ReservationUtil.getRoomCheck(checkinDate, accommodationNo, roomNo, i);

            int acmCount = getRemainingRooms(rsrvMap); // 숙소 번호, 룸 번호, 해당 일자
            if(i==0) roomCountMin = acmCount;
            roomCountMin = Math.min(roomCountMin, acmCount); // 제일 작은 수량
        }

        // 객실 수량이 없으면 다시 숙소 상세보기로 이동함.
        // 0개이면 애초에 숙소 상세보기에서 예약하기 버튼 활성화 안함. -> 근데 고민하다가 누를 수 있으니 누르면 다시 리다이렉트 -> 해당 숙소 정보로 가기
        if(roomCountMin > 0){
            result = 1; // 숙소 결제 가능

            ReservationDTO rsrvDTO = ReservationDTO.builder()
                    .memberNo(2)
                    .accommodationNo((int)jsonData.get("accommodationNo"))
                    .roomNo((int)jsonData.get("roomNo"))
                    .checkinDate(checkinDate)
                    .checkoutDate(checkoutDate)
                    .reservationStatus(1) // 예약 확정
                    .reservationDetailsRequest(jsonData.get("reservationDetailsRequest").toString())
                    .residenceCountry(jsonData.get("residenceCountry").toString())
                    .guestName(jsonData.get("guestName").toString())
                    .guestPhoneNumber(jsonData.get("guestPhoneNumber").toString())
                    .guestEmail(jsonData.get("guestEmail").toString())
                    .build();

            int reservationNo = reservationRepository.insertReservation(rsrvDTO);
            System.out.println("reservationNo : " + reservationNo);
            System.out.println("Generated Reservation No: " + rsrvDTO.getReservationNo());
            reservationNo = rsrvDTO.getReservationNo();

            HashMap<String, Object> rsrvRequestMap = new HashMap<String, Object>();
            rsrvRequestMap.put("reservationNo", reservationNo);
            rsrvRequestMap.put("specialRequests", specialRequests);
            reservationRequestRepository.insertReservationRequest(rsrvRequestMap);

            PaymentDTO paymentDTO = PaymentDTO.builder()
                    .roomPrice(Integer.parseInt(jsonData.get("roomPrice").toString()))
                    .discountPercentage(Integer.parseInt(jsonData.get("roomDiscount").toString()))
                    .pointPrice(0)
                    .paymentPrice(amount.get("total"))
                    .paymentStatus(1)
                    .paymentId(payment.get("id").toString())
                    .provider(method.get("provider"))
                    .reservationNo(reservationNo)
                    .build();
            paymentRepository.insertPayment(paymentDTO);
        }
        return result;
    }

    @Override
    public List<ReservationDTO> getReservations(ReservationDTO reservationDTO) {
        List<ReservationDTO> reservationList = reservationRepository.getReservations(reservationDTO);

        reservationList.stream().forEach(forRsrv -> {
            //            int accommodationNo, int roomNo
            AcmDTO getDTO = AcmDTO.builder()
                    .acmNo(forRsrv.getAccommodationNo())
                    .roomNo(forRsrv.getRoomNo())
                    .build();
            getDTO = acmRoomRepository.selectRoomDetail(getDTO);
            forRsrv.setAcmDTO(getDTO);
        });
        //        Payment p = xxxRepository.getPayment(reservationDTO.getReservationNo());

        return reservationList;
    }

    @Override
    public ReservationDTO getReservationDetail(ReservationDTO reservationDTO) {
        ReservationDTO rsDTO = reservationRepository.getReservation(reservationDTO);

        // 숙소 정보
        AcmDTO getAcmDTO = AcmDTO.builder()
                .acmNo(rsDTO.getAccommodationNo())
                .roomNo(rsDTO.getRoomNo())
                .build();

        getAcmDTO = acmRoomRepository.selectRoomDetail(getAcmDTO);
        rsDTO.setAcmDTO(getAcmDTO);

        // 예약 요청 정보
        ReservationRequestDTO getRRDTO = ReservationRequestDTO.builder().reservationNo(rsDTO.getReservationNo()).build();
        List<ReservationRequestDTO> rrdList = reservationRepository.getReservationRequests(getRRDTO);
        rsDTO.setReservationRequests(rrdList);

        // 결제
        PaymentDTO paymentDTO = paymentRepository.getPayment(rsDTO.getReservationNo());
        rsDTO.setPayment(paymentDTO);

        return rsDTO;
    }

    @Override
    public List<ReservationRequestDTO> getReservationRequests(ReservationRequestDTO reservationRequestDTO) {
        return reservationRepository.getReservationRequests(reservationRequestDTO);
    }

    @Override
    public void cancelReservationReq(int memberNo, int rsNo, String cancelReasons) {
        ReservationDTO rsDTO = ReservationDTO.builder().memberNo(memberNo).reservationNo(rsNo).build();
        rsDTO = reservationRepository.getReservation(rsDTO);

        ReservationCancelDTO cancelDTO = ReservationCancelDTO.builder()
                .reservationNo(rsDTO.getReservationNo())
                .cancelReasons(cancelReasons)
                .cancelStatus(2) // 취소대기
                .build();

        reservationCancelRepository.cancelReservationReq(cancelDTO);

        rsDTO.setReservationStatus(2); // 취소 대기
        reservationRepository.cancelReservationReq(rsDTO);

    }

    // 사업자 기준 예약 조회
    @Override
    public List<ReservationDTO> getBnsRsList(int businessNo, int acmNo, int roomNo, int currentPage, int pageSize, String search) {
        int offset = (currentPage - 1) * pageSize;

        List<ReservationDTO> list = reservationRepository.getBnsRsList(businessNo, acmNo, roomNo, offset, pageSize, search);

        list.stream().forEach(forRsrv -> {
            AcmDTO getDTO = AcmDTO.builder()
                    .acmNo(forRsrv.getAccommodationNo())
                    .roomNo(forRsrv.getRoomNo())
                    .build();
            getDTO = acmRoomRepository.selectRoomDetail(getDTO);
            forRsrv.setAcmDTO(getDTO);

            // 예약자 조회
            MemberDTO memberDTO = memberRepository.findById(forRsrv.getMemberNo());
            forRsrv.setMemberDTO(memberDTO);

            // 예약 요청 정보
            ReservationRequestDTO getRRDTO = ReservationRequestDTO.builder().reservationNo(forRsrv.getReservationNo()).build();
            List<ReservationRequestDTO> rrdList = reservationRepository.getReservationRequests(getRRDTO);
            forRsrv.setReservationRequests(rrdList);

            // 결제
            PaymentDTO paymentDTO = paymentRepository.getPayment(forRsrv.getReservationNo());
            forRsrv.setPayment(paymentDTO);
        });

        return list;
    }
    @Override
    public int countRsAll(int businessNo, int acmNo, int roomNo, String search) {
        return reservationRepository.countRsAll(businessNo, acmNo, roomNo, search);
    }

    @Override
    public ReservationDTO getRsCancl(ReservationDTO getRsDTO) {
        ReservationDTO rsDTO = reservationRepository.getReservation(getRsDTO);

        // 숙소 정보
        AcmDTO getAcmDTO = AcmDTO.builder()
                .acmNo(rsDTO.getAccommodationNo())
                .roomNo(rsDTO.getRoomNo())
                .build();

        getAcmDTO = acmRoomRepository.selectRoomDetail(getAcmDTO);
        rsDTO.setAcmDTO(getAcmDTO);

        // 예약 요청 정보
        ReservationRequestDTO getRRDTO = ReservationRequestDTO.builder().reservationNo(rsDTO.getReservationNo()).build();
        List<ReservationRequestDTO> rrdList = reservationRepository.getReservationRequests(getRRDTO);
        rsDTO.setReservationRequests(rrdList);

        // 결제
        PaymentDTO paymentDTO = paymentRepository.getPayment(rsDTO.getReservationNo());
        rsDTO.setPayment(paymentDTO);

        ReservationCancelDTO cancelDTO = reservationCancelRepository.getRsCancl(rsDTO.getReservationNo());
        rsDTO.setRsCancel(cancelDTO);

        return rsDTO;
    }
}
