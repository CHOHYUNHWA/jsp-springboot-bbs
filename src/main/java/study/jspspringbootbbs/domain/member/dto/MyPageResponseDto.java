package study.jspspringbootbbs.domain.member.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import study.jspspringbootbbs.domain.member.entity.Member;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MyPageResponseDto {

    public String username;
    public String name;
    public String nickname;
    public String gender;
    public String email;


    public MyPageResponseDto memberToMyPageResponseDto(Member member){
        return MyPageResponseDto.builder()
                .username(member.getUsername())
                .name(member.getName())
                .nickname(member.getNickname())
                .gender(member.getGender().toString())
                .email(member.getEmail())
                .build();
    }
}
