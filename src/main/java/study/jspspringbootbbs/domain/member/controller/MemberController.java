package study.jspspringbootbbs.domain.member.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.coyote.Response;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import study.jspspringbootbbs.domain.member.dto.*;
import study.jspspringbootbbs.domain.member.entity.Member;
import study.jspspringbootbbs.domain.member.service.MemberService;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/api/member")
public class MemberController {

    private final MemberService memberService;


    @PostMapping
    public boolean memberJoin(@RequestBody MemberJoinRequestDto memberJoinRequestDto){
        log.info("username ={}" , memberJoinRequestDto.getUsername());
        Member member = memberJoinRequestDto.toEntity(memberJoinRequestDto);
        memberService.join(member);
        return true;
    }

    @PostMapping("/check-username-duplicate")
    public boolean checkUsernameDuplicate(@RequestBody UsernameJoinDuplicateCheckDto usernameJoinDuplicateCheckDto){
        boolean result = memberService.checkUsernameDuplicate(usernameJoinDuplicateCheckDto.getUsername());
        return result;
    }

    @GetMapping
    public ResponseEntity<MyPageResponseDto> getMyPage(@AuthenticationPrincipal Member member){
        String username = member.getUsername();
        Member findMember = memberService.getMyPage(username);
        MyPageResponseDto myPageResponseDto = new MyPageResponseDto(findMember);
        log.info(myPageResponseDto.getUsername());
        return new ResponseEntity<>(myPageResponseDto, HttpStatus.OK);
    }

    @DeleteMapping
    public boolean deleteMember(@AuthenticationPrincipal Member member){
        memberService.deleteMember(member.getUsername());
        return true;
    }

    @PostMapping("/verifyPassword")
    public boolean verifyPassword(@AuthenticationPrincipal Member member,
                                  @RequestBody VerifyPasswordRequestDto verifyPasswordRequestDto){

        return memberService.verifyPassword(member, verifyPasswordRequestDto);
    }

    @PatchMapping
    public boolean updateMember(@AuthenticationPrincipal Member member,
                                @RequestBody MemberUpdateRequestDto memberUpdateRequestDto){
        memberService.updateMember(member,memberUpdateRequestDto);
        return true;
    }
}
