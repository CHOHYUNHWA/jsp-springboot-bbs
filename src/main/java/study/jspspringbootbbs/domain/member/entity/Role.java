package study.jspspringbootbbs.domain.member.entity;

import lombok.Getter;

@Getter
public enum Role {

    USER("ROLE_USER", "일반사용자"),
    ADMIN("ROLE_ADMIN", "일반관리자");

    private final String key;
    private final String title;

    Role(String key, String title) {
        this.key = key;
        this.title = title;
    }
}
