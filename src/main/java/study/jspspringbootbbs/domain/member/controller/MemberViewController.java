package study.jspspringbootbbs.domain.member.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import study.jspspringbootbbs.domain.member.dto.MyPageResponseDto;
import study.jspspringbootbbs.domain.member.entity.Member;
import study.jspspringbootbbs.domain.member.service.MemberService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberViewController {

    private final MemberService memberService;

    @GetMapping("/login")
    public String getLoginForm(){
        return "/member/loginForm";
    }

    @GetMapping("/join")
    public String getMemberJoinForm(){
        return "/member/joinForm";
    }

    @GetMapping("/info")
    public String getMemberInfoForm(){
        return "/member/infoForm";
    }

    @GetMapping("/list")
    public String getMemberListForm(){
        return "/member/listForm";
    }

    @GetMapping("/update")
    public String getMemberUpdateForm(){
        return "/member/updateForm";
    }

    @GetMapping("/my-page")
    public String getMyPageForm(@AuthenticationPrincipal Member member){
        return "/member/myPageForm";
    }
}
