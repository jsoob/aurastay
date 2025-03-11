package kr.co.aura.aurastay.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.javassist.compiler.ast.Keyword;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface KeywordRepository {
    List<Keyword> getAllKeywords();
}
