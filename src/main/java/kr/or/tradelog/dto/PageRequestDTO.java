package kr.or.tradelog.dto;

import lombok.Getter;

@Getter
public class PageRequestDTO {

    private final int page;
    private final int pageSize;

    public PageRequestDTO(int page, int pageSize) {
        if (pageSize < 1) {
            throw new IllegalArgumentException("페이지 크기는 1 이상이어야 합니다.");
        }

        this.page = Math.max(page, 1);
        this.pageSize = pageSize;
    }

    public PageRequestDTO resolve(int totalCount) {
        int totalPages = totalCount / pageSize;
        if (totalCount % pageSize != 0) {
            totalPages++;
        }

        int lastPage = Math.max(totalPages, 1);
        return new PageRequestDTO(Math.min(page, lastPage), pageSize);
    }

    public int getOffset() {
        return (page - 1) * pageSize;
    }
}
