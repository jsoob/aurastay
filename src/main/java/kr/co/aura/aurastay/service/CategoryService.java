package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.CategoryDTO;
import kr.co.aura.aurastay.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;

    public List<CategoryDTO> getCategories() {
        return categoryRepository.getCategories();
    }

    // 카테고리 번호로 카테고리 조회
    public CategoryDTO getCategoryById(Integer categoryNo) {
        return categoryRepository.getCategoryById(categoryNo); // 단일 카테고리 반환
    }


//    public List<CategoryDTO> getCategories() {
//        // 카테고리 리스트 조회
//        List<CategoryDTO> categoryList = categoryRepository.getCategories();
//
//        List<CategoryDTO> categories = new ArrayList<>();
//        for (CategoryDTO category : categoryList) {
//            CategoryDTO categoryDTO = new CategoryDTO();
//            categoryDTO.setCategoryNo(category.getCategoryNo());
//            categoryDTO.setCategoryName(category.getCategoryName());
//
//            categories.add(categoryDTO);
//        }
//        return categoryList;
//    }
}
