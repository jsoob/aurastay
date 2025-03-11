package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.BusinessDTO;
import kr.co.aura.aurastay.repository.BusinessRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class BusinessServiceImpl implements BusinessService {
    private final BusinessRepository businessRepository;

    @Override
    public void save(BusinessDTO dto) {

    }
}
