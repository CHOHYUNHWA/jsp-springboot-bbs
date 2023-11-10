package study.jspspringbootbbs.domain.post.service;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import study.jspspringbootbbs.domain.member.entity.Member;
import study.jspspringbootbbs.domain.post.dto.GetPostResponseDto;
import study.jspspringbootbbs.domain.post.dto.PostCreateRequestDto;
import study.jspspringbootbbs.domain.post.repository.PostMapper;

import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
@RequiredArgsConstructor
public class PostService {

    private final PostMapper postMapper;


    public void createPost(Member member, PostCreateRequestDto postCreateRequestDto) {
        postMapper.insertPost(postCreateRequestDto,member);
    }

    public GetPostResponseDto getPost(Member member, Long postId) {
        postMapper.updateViewCount(postId);
        GetPostResponseDto getPostResponseDto = postMapper.selectById(postId, member);
        return getPostResponseDto;
    }
}
