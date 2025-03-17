package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.AmenitiesDTO;
import kr.co.aura.aurastay.repository.AmenitiesRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class AmenitiesService {

    private final AmenitiesRepository amenitiesRepository;


    public List<AmenitiesDTO> getAllAmenities() {
        return amenitiesRepository.getAllAmenities();
    }
}
