package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.CategoryDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface CategoryRepository {
    List<CategoryDTO> getCategories();
}
