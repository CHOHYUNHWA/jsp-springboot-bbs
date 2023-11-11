package study.jspspringbootbbs.domain.post.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import study.jspspringbootbbs.domain.member.entity.Member;
import study.jspspringbootbbs.domain.post.dto.GetPostResponseDto;
import study.jspspringbootbbs.domain.post.dto.PostCreateRequestDto;
import study.jspspringbootbbs.domain.post.dto.PostUpdateRequestDto;
import study.jspspringbootbbs.domain.post.entity.Post;
import study.jspspringbootbbs.domain.post.service.PostService;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/post")
@Slf4j
public class PostController {

    private final PostService postService;

    @PostMapping
    public boolean createPost(@AuthenticationPrincipal Member member,
                              @RequestBody PostCreateRequestDto postCreateRequestDto){
        Post post = postCreateRequestDto.toEntity(postCreateRequestDto);
        postService.createPost(member,postCreateRequestDto);
        return true;
    }

    @GetMapping("/{postId}")
    public ResponseEntity<GetPostResponseDto> getPost(@PathVariable("postId") Long postId,
                                        @AuthenticationPrincipal Member member){
        GetPostResponseDto getPostResponseDto = postService.getPost(member, postId);
        return new ResponseEntity<>(getPostResponseDto, HttpStatus.OK);
    }

    @PatchMapping("/{postId}")
    public boolean updatePost(@PathVariable("postId") Long postId,
                              @AuthenticationPrincipal Member member,
                              @RequestBody PostUpdateRequestDto postUpdateRequestDto){
        postService.updatePost(member,postId, postUpdateRequestDto);
        return true;
    }

    @DeleteMapping("/{postId}")
    public boolean deletePost(@PathVariable("postId") Long postId,
                              @AuthenticationPrincipal Member member){
        postService.deletePost(postId, member.getId());
        return true;
    }
}
