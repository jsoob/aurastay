package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.repository.MainRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@RequiredArgsConstructor
@Service
public class MainServiceImpl implements MainService{
    private final MainRepository mainRepository;
    
    // 전체 숙소수
    @Override
    public int getTotalCount() {
        return mainRepository.getTotalCount();
    }
    
    // 숙소 쪽으로 옮기거나 삭제하거나
    @Override
    public List<HashMap<String, Object>> getAllAccommodation() {
        return mainRepository.getAllAccommodation();
    }

    // 페이징처리
    @Override
    public List<HashMap<String, Object>> getPagedAccommodations(int offset, int size) {
        return List.of();
    }

}
