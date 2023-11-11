package study.jspspringbootbbs.domain.member.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import study.jspspringbootbbs.domain.member.dto.MemberUpdateRequestDto;
import study.jspspringbootbbs.domain.member.dto.VerifyPasswordRequestDto;
import study.jspspringbootbbs.domain.member.entity.Member;
import study.jspspringbootbbs.domain.member.repository.MemberRepository;
import study.jspspringbootbbs.global.exception.BusinessLogicException;
import study.jspspringbootbbs.global.exception.ExceptionCode;

import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class MemberService {

    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;
    public void join(Member member) {
        Optional<Member> optionalMember = memberRepository.findByUsername(member.getUsername());
        if(optionalMember.isPresent()){
            throw new BusinessLogicException(ExceptionCode.USERNAME_EXISTS);
        }
        member.encodePassword(passwordEncoder.encode(member.getPassword()));
        memberRepository.save(member);
    }

    public boolean checkUsernameDuplicate(String username) {
        boolean result = memberRepository.findByUsername(username).isEmpty();
        return result;
    }

    public Member getMyPage(String username) {
        return verifiedMember(username);
    }

    private Member verifiedMember(String username){
        return memberRepository.findByUsername(username).orElseThrow(
                () -> new BusinessLogicException(ExceptionCode.USERNAME_EXISTS));
    }

    public void deleteMember(String username) {
        Member member = verifiedMember(username);
        memberRepository.delete(member);
    }

    public boolean verifyPassword(Member member, VerifyPasswordRequestDto rawPassword) {
        Member findMember = verifiedMember(member.getUsername());
        String encPassword = findMember.getPassword();
        return passwordEncoder.matches(rawPassword.getPassword(), encPassword);
    }

    public void updateMember(Member member, MemberUpdateRequestDto memberUpdateRequestDto) {
        Member findMember = verifiedMember(member.getUsername());
        log.info("기존 닉네임 ={} , 변경 닉네임={}",findMember.getNickname(), memberUpdateRequestDto.getNickname());
        findMember.updateInfo(memberUpdateRequestDto.getNickname());
        log.info("닉네임 ={}", findMember.getNickname());
    }
}
