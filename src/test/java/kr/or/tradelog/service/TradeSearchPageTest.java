package kr.or.tradelog.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.lang.reflect.Proxy;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.concurrent.atomic.AtomicReference;

import org.junit.Test;

import kr.or.tradelog.dto.PageRequestDTO;
import kr.or.tradelog.dto.PageResponseDTO;
import kr.or.tradelog.dto.TradeDTO;
import kr.or.tradelog.dto.TradeSearchCondition;
import kr.or.tradelog.mapper.TradeMapper;

public class TradeSearchPageTest {

    @Test
    public void searchPageUsesSameFiltersAndClampsLastPage() {
        AtomicReference<Object[]> countArguments = new AtomicReference<>();
        AtomicReference<Object[]> searchArguments = new AtomicReference<>();

        TradeDTO trade = TradeDTO.builder()
                .buyPrice(new BigDecimal("100"))
                .sellPrice(new BigDecimal("110"))
                .quantity(new BigDecimal("2"))
                .build();

        TradeMapper mapper = (TradeMapper) Proxy.newProxyInstance(
                TradeMapper.class.getClassLoader(),
                new Class<?>[] { TradeMapper.class },
                (proxy, method, args) -> {
                    if ("countTrades".equals(method.getName())) {
                        countArguments.set(args);
                        return 23;
                    }
                    if ("searchTrades".equals(method.getName())) {
                        searchArguments.set(args);
                        return Collections.singletonList(trade);
                    }
                    throw new AssertionError("Unexpected mapper method: " + method.getName());
                }
        );

        TradeSearchCondition condition = new TradeSearchCondition();
        condition.setKeyword(" 삼성 ");
        condition.setStartDate(" 2026-09-01 ");
        condition.setEndDate(" ");
        condition.setSort("returnDesc");
        condition.normalize();

        TradeService service = new TradeServiceImpl(mapper, null, null);
        PageResponseDTO<TradeDTO> result = service.searchPage(
                7, condition, new PageRequestDTO(99, 10));

        assertEquals(3, result.getPage());
        assertEquals(3, result.getTotalPages());
        assertEquals(23, result.getTotalCount());
        assertEquals(1, result.getStartPage());
        assertEquals(3, result.getEndPage());
        assertEquals(1, result.getList().size());
        assertEquals(new BigDecimal("20"), trade.getRealizedProfit());
        assertEquals(new BigDecimal("10.0000"), trade.getReturnRate());

        Object[] count = countArguments.get();
        Object[] search = searchArguments.get();
        assertEquals(7, count[0]);
        assertEquals("삼성", count[1]);
        assertEquals("2026-09-01", count[2]);
        assertEquals(null, count[3]);
        assertEquals(count[0], search[0]);
        assertEquals(count[1], search[1]);
        assertEquals(count[2], search[2]);
        assertEquals(count[3], search[3]);
        assertEquals("returnDesc", search[4]);
        assertEquals(20, search[5]);
        assertEquals(10, search[6]);
    }

    @Test
    public void emptyResultKeepsFirstPageWithoutNavigation() {
        PageRequestDTO request = new PageRequestDTO(99, 10).resolve(0);
        PageResponseDTO<TradeDTO> result = new PageResponseDTO<>(
                Collections.emptyList(), 0, request, 10);

        assertEquals(1, request.getPage());
        assertEquals(0, request.getOffset());
        assertEquals(0, result.getTotalPages());
        assertEquals(1, result.getStartPage());
        assertEquals(0, result.getEndPage());
        assertTrue(result.getList().isEmpty());
    }

    @Test
    public void pageBlockStartsAtTwentyOneForPageTwentyThree() {
        PageRequestDTO request = new PageRequestDTO(23, 10).resolve(240);
        PageResponseDTO<TradeDTO> result = new PageResponseDTO<>(
                Collections.emptyList(), 240, request, 10);

        assertEquals(220, request.getOffset());
        assertEquals(24, result.getTotalPages());
        assertEquals(21, result.getStartPage());
        assertEquals(24, result.getEndPage());
    }
}
