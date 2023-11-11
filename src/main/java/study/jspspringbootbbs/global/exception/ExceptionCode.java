package study.jspspringbootbbs.global.exception;

import lombok.Getter;

public enum ExceptionCode {

    USERNAME_EXISTS(400, "Username already exists"),
    POST_NOT_FOUND(404, "Post not Found" );


    @Getter
    private final int status;
    @Getter
    private final String message;

    ExceptionCode(int status, String message){
        this.status = status;
        this.message = message;
    }
}
