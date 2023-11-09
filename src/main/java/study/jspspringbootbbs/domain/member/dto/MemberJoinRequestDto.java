package study.jspspringbootbbs.domain.member.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import study.jspspringbootbbs.domain.member.entity.Member;
import study.jspspringbootbbs.domain.member.entity.Role;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberJoinRequestDto {

    private String username;
    private String password;
    private String name;
    private String nickname;
    private String email;

    public Member toEntity(MemberJoinRequestDto memberJoinRequestDto){
        return Member.builder()
                .username(memberJoinRequestDto.getUsername())
                .password(memberJoinRequestDto.getPassword())
                .name(memberJoinRequestDto.getName())
                .nickname(memberJoinRequestDto.getNickname())
                .email(memberJoinRequestDto.getEmail())
                .role(Role.USER.getKey())
                .build();
    }
}
