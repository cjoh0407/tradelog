package kr.or.tradelog.dto;

import java.util.List;

import lombok.Getter;

@Getter
public class PageResponseDTO<T> {

    private final List<T> list;
    private final int page;
    private final int totalCount;
    private final int totalPages;
    private final int startPage;
    private final int endPage;

    public PageResponseDTO(
            List<T> list,
            int totalCount,
            PageRequestDTO pageRequest,
            int pageBlockSize) {

        if (pageBlockSize < 1) {
            throw new IllegalArgumentException("페이지 번호 묶음 크기는 1 이상이어야 합니다.");
        }

        this.list = list;
        this.page = pageRequest.getPage();
        this.totalCount = totalCount;
        this.totalPages = totalCount / pageRequest.getPageSize()
                + (totalCount % pageRequest.getPageSize() == 0 ? 0 : 1);
        this.startPage = ((page - 1) / pageBlockSize) * pageBlockSize + 1;
        this.endPage = Math.min(startPage + pageBlockSize - 1, totalPages);
    }
}
