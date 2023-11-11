package study.jspspringbootbbs.domain.member.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import net.bytebuddy.matcher.FilterableList;
import study.jspspringbootbbs.domain.post.entity.Post;
import study.jspspringbootbbs.global.audit.BaseTimeEntity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member extends BaseTimeEntity {

    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String username;

    private String password;

    private String name;

    private String nickname;

    private Gender gender;

    private String email;

    private String role;

    @OneToMany(mappedBy = "member")
    private List<Post> postList = new ArrayList<>();

    public void encodePassword(String encodedPassword){
        this.password = encodedPassword;
    }

    public void updateInfo(String nickname) {
        this.nickname = nickname;
    }
}
