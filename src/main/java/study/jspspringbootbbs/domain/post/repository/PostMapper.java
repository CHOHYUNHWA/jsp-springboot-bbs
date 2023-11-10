package study.jspspringbootbbs.domain.post.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import study.jspspringbootbbs.domain.member.entity.Member;
import study.jspspringbootbbs.domain.post.dto.GetPostResponseDto;
import study.jspspringbootbbs.domain.post.dto.PostCreateRequestDto;
import study.jspspringbootbbs.domain.post.dto.PostUpdateRequestDto;

import java.util.List;

@Mapper
public interface PostMapper {

    public GetPostResponseDto selectById(Long postId, @Param("member") Member member);

    public int insertPost(@Param("post") PostCreateRequestDto postCreateRequestDto, @Param("member") Member member);

    public int updatePost(PostUpdateRequestDto postUpdateRequestDto);

    public int updateViewCount(Long postId);

    public int deletePost(Long postId);

    public List<GetPostResponseDto> selectPostList();

    public int selectPostTotalCount();
}
