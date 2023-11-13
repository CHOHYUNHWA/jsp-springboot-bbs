package study.jspspringbootbbs.domain.post.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import study.jspspringbootbbs.domain.member.entity.Member;
import study.jspspringbootbbs.domain.post.dto.GetPostResponseDto;
import study.jspspringbootbbs.domain.post.dto.PostCreateRequestDto;
import study.jspspringbootbbs.domain.post.dto.PostListSearchDto;
import study.jspspringbootbbs.domain.post.dto.PostUpdateRequestDto;
import study.jspspringbootbbs.domain.post.entity.Post;
import study.jspspringbootbbs.domain.post.repository.PostMapper;
import study.jspspringbootbbs.global.dto.MultiResponseDto;
import study.jspspringbootbbs.global.exception.BusinessLogicException;
import study.jspspringbootbbs.global.exception.ExceptionCode;
import study.jspspringbootbbs.global.page.PageInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class PostService {

    private final PostMapper postMapper;


    public void createPost(Member member, PostCreateRequestDto postCreateRequestDto) {
        postMapper.insertPost(postCreateRequestDto,member);
    }

    public GetPostResponseDto getPost(Member member, Long postId) {
        postMapper.updateViewCount(postId);

        return postMapper.selectById(postId, member).orElseThrow(()-> new BusinessLogicException(ExceptionCode.POST_NOT_FOUND));
    }

    public void updatePost(Member member, Long postId, PostUpdateRequestDto postUpdateRequestDto) {
        Post post = checkPostAuth(postId,member);
        postMapper.updatePost(postUpdateRequestDto, postId);


    }


    public Post verifiedPost(Long postId){
        Optional<Post> optionalPost = postMapper.selectPostById(postId);
        Post post = optionalPost.orElseThrow(() -> new BusinessLogicException(ExceptionCode.POST_NOT_FOUND));
        return post;
    }

    public Post checkPostAuth(Long postId, Member member){
        Optional<Post> optionalPost = postMapper.selectPostByPostIdAndMemberId(postId, member.getId());
        Post post = optionalPost.orElseThrow(() -> new BusinessLogicException(ExceptionCode.POST_NOT_FOUND));
        return post;
    }

    public void deletePost(Long postId, Long memberId) {
        int result = postMapper.deletePost(postId, memberId);
        log.info("result = {}" , result);
    }

    public MultiResponseDto getPostList(PostListSearchDto postListSearchDto) {
        int pageNum = postListSearchDto.getPageNum() -1 ;
        int pageSize = postListSearchDto.getPageSize();
        int offset = pageNum * pageSize;
        int limit = pageSize;
        int totalCount = postMapper.selectPostTotalCount();
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);


        log.info("totalCount = {}, pageSize= {}", totalCount, pageSize);
        log.info("totalPage={}", totalPage);


        PageInfo pageInfo = new PageInfo();
        pageInfo.setPageNum(pageNum+1);
        pageInfo.setPageSize(limit);
        pageInfo.setTotalCount(totalCount);
        pageInfo.setTotalPage(totalPage);


        List<GetPostResponseDto> getPostResponseDtoList = postMapper.selectPostList(offset, limit);
        MultiResponseDto<List<GetPostResponseDto>> postLiseResponse = new MultiResponseDto(getPostResponseDtoList, pageInfo);
        return postLiseResponse;
    }
}
