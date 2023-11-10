package study.jspspringbootbbs.domain.post.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import study.jspspringbootbbs.domain.member.entity.Member;
import study.jspspringbootbbs.domain.post.entity.Post;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PostCreateRequestDto {

    private String title;
    private String body;

    public Post toEntity(PostCreateRequestDto postCreateRequestDto){
        return Post.builder()
                .title(postCreateRequestDto.getTitle())
                .body(postCreateRequestDto.getBody())
                .build();
    }
}
