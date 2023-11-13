package study.jspspringbootbbs.global.dto;

import lombok.Data;
import study.jspspringbootbbs.global.page.PageInfo;

import java.util.List;

@Data
public class MultiResponseDto<T> {

    private List<T> data;
    private PageInfo pageInfo;

    public MultiResponseDto(List<T> data, PageInfo pageInfo) {
        this.data = data;
        this.pageInfo = pageInfo;
    }
}
