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
import study.jspspringbootbbs.domain.post.dto.PostListSearchDto;
import study.jspspringbootbbs.domain.post.dto.PostUpdateRequestDto;
import study.jspspringbootbbs.domain.post.entity.Post;
import study.jspspringbootbbs.domain.post.service.PostService;
import study.jspspringbootbbs.global.dto.MultiResponseDto;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/post")
@Slf4j
public class PostController {

    private final PostService postService;

    @PostMapping
    public ResponseEntity<Void> createPost(@AuthenticationPrincipal Member member,
                              @RequestBody PostCreateRequestDto postCreateRequestDto){
        Post post = postCreateRequestDto.toEntity(postCreateRequestDto);
        postService.createPost(member,postCreateRequestDto);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/{postId}")
    public ResponseEntity<GetPostResponseDto> getPost(@PathVariable("postId") Long postId,
                                        @AuthenticationPrincipal Member member){
        GetPostResponseDto getPostResponseDto = postService.getPost(member, postId);
        return new ResponseEntity<>(getPostResponseDto, HttpStatus.OK);
    }

    @PatchMapping("/{postId}")
    public ResponseEntity<Void> updatePost(@PathVariable("postId") Long postId,
                              @AuthenticationPrincipal Member member,
                              @RequestBody PostUpdateRequestDto postUpdateRequestDto){
        postService.updatePost(member,postId, postUpdateRequestDto);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{postId}")
    public ResponseEntity<Void> deletePost(@PathVariable("postId") Long postId,
                              @AuthenticationPrincipal Member member){
        log.info("postId ={}", postId);
        log.info("memberId = {}", member.getId());
        postService.deletePost(postId, member.getId());
        return ResponseEntity.ok().build();
    }

    @GetMapping("/list")
    public ResponseEntity<MultiResponseDto<List<GetPostResponseDto>>> postList(PostListSearchDto postListSearchDto){
        if(postListSearchDto.getPageNum() <= 0 || postListSearchDto.getPageSize() <= 0){
            return ResponseEntity.badRequest().build();
        }
        MultiResponseDto<List<GetPostResponseDto>> postListResponse = postService.getPostList(postListSearchDto);
        return ResponseEntity.ok(postListResponse);
    }
}
