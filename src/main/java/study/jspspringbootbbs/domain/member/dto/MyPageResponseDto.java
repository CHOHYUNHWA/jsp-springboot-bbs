package study.jspspringbootbbs.domain.member.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import study.jspspringbootbbs.domain.member.entity.Gender;
import study.jspspringbootbbs.domain.member.entity.Member;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MyPageResponseDto {

    public String username;
    public String name;
    public String nickname;
    public Gender gender;
    public String email;


    public MyPageResponseDto(Member member) {
        this.username = member.getUsername();
        this.name = member.getName();
        this.nickname = member.getNickname();
        this.gender = member.getGender();
        this.email = member.getEmail();
    }
}
