package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.LikesDTO;
import kr.co.aura.aurastay.repository.LikesRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@RequiredArgsConstructor
@Service
public class LikesServiceImpl implements LikesService{
    private final LikesRepository likesRepository;

    @Override
    public void addWishList(LikesDTO likesDTO) {
        likesRepository.addWishList(likesDTO);
    }

    @Override
    public List<HashMap<String, Object>> wishList(int memberNo) {
        return likesRepository.getWishList(memberNo);
    }

    @Override
    public void removeWishList(LikesDTO likesDTO) {
        likesRepository.deleteWishList(likesDTO);
    }
}
