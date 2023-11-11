package study.jspspringbootbbs.domain.post.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import study.jspspringbootbbs.domain.member.entity.Member;
import study.jspspringbootbbs.global.audit.BaseTimeEntity;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Post extends BaseTimeEntity {

    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String title;
    private String body;
    private int viewCount;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn
    private Member member;

    public void updatePost(String title, String body){
        this.title = title;
        this.body = body;
    }
}
