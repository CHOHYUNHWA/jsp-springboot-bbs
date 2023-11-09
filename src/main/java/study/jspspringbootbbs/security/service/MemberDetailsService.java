package study.jspspringbootbbs.security.service;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import study.jspspringbootbbs.domain.member.entity.Member;
import study.jspspringbootbbs.domain.member.repository.MemberRepository;
import study.jspspringbootbbs.security.auth.MemberDetails;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MemberDetailsService implements UserDetailsService {

    private final MemberRepository memberRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<Member> optionalMember = memberRepository.findByUsername(username);
        Member findMember = optionalMember.orElseThrow(() -> new UsernameNotFoundException("없는 아이디 입니다."));
        MemberDetails memberDetails = new MemberDetails(findMember);
        return memberDetails;
    }
}
