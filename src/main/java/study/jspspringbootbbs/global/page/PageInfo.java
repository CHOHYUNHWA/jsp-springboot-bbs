package study.jspspringbootbbs.global.page;

import lombok.Data;

@Data
public class PageInfo {
    private int totalCount;
    private int totalPage;
    private int pageNum;
    private int pageSize;
}
