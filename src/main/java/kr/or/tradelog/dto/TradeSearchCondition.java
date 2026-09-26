package kr.or.tradelog.dto;

import lombok.Data;

@Data
public class TradeSearchCondition {

    private String keyword;
    private String startDate;
    private String endDate;
    private String sort;

    public void normalize() {
        if (keyword != null) {
            keyword = keyword.trim();
        }

        startDate = trimToNull(startDate);
        endDate = trimToNull(endDate);

        if (!"oldest".equals(sort)
                && !"returnDesc".equals(sort)
                && !"returnAsc".equals(sort)) {
            sort = null;
        }
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }

        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}
