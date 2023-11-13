package study.jspspringbootbbs.domain.post.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import study.jspspringbootbbs.domain.member.entity.Member;
import study.jspspringbootbbs.domain.post.dto.GetPostResponseDto;
import study.jspspringbootbbs.domain.post.dto.PostCreateRequestDto;
import study.jspspringbootbbs.domain.post.dto.PostUpdateRequestDto;
import study.jspspringbootbbs.domain.post.entity.Post;

import java.util.List;
import java.util.Optional;

@Mapper
public interface PostMapper {

    public Optional<Post> selectPostById(Long postId);

    public Optional<GetPostResponseDto> selectById(Long postId, @Param("member") Member member);

    public int insertPost(@Param("post") PostCreateRequestDto postCreateRequestDto, @Param("member") Member member);

    public int updatePost(@Param("post") PostUpdateRequestDto postUpdateRequestDto, Long postId);

    public int updateViewCount(Long postId);

    public int deletePost(Long postId, Long memberId);

    public List<GetPostResponseDto> selectPostList(int offset, int limit);

    public int selectPostTotalCount();

    Optional<Post> selectPostByPostIdAndMemberId(Long postId, Long memberId);
}
