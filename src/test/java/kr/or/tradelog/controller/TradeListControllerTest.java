package kr.or.tradelog.controller;

import static org.junit.Assert.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.lang.reflect.Proxy;
import java.util.Collections;
import java.util.concurrent.atomic.AtomicReference;

import org.junit.Test;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import kr.or.tradelog.dto.MemberDTO;
import kr.or.tradelog.dto.PageRequestDTO;
import kr.or.tradelog.dto.PageResponseDTO;
import kr.or.tradelog.dto.TradeDTO;
import kr.or.tradelog.dto.TradeSearchCondition;
import kr.or.tradelog.service.TradeService;

public class TradeListControllerTest {

    @Test
    public void listBindsSearchRequestAndKeepsJspModelNames() throws Exception {
        AtomicReference<TradeSearchCondition> receivedCondition = new AtomicReference<>();

        TradeService service = (TradeService) Proxy.newProxyInstance(
                TradeService.class.getClassLoader(),
                new Class<?>[] { TradeService.class },
                (proxy, method, args) -> {
                    if (!"searchPage".equals(method.getName())) {
                        throw new AssertionError("Unexpected service method: " + method.getName());
                    }

                    assertEquals(7, args[0]);
                    receivedCondition.set((TradeSearchCondition) args[1]);
                    PageRequestDTO pageRequest = ((PageRequestDTO) args[2]).resolve(23);
                    return new PageResponseDTO<TradeDTO>(
                            Collections.emptyList(), 23, pageRequest, 10);
                }
        );

        MockMvc mvc = MockMvcBuilders.standaloneSetup(
                new TradeController(service, null, null, null)).build();

        mvc.perform(get("/trade/list")
                .param("keyword", " 삼성 ")
                .param("startDate", " 2026-09-01 ")
                .param("endDate", " ")
                .param("sort", "returnDesc")
                .param("page", "99")
                .sessionAttr("loginMember", MemberDTO.builder().memberId(7).build()))
                .andExpect(status().isOk())
                .andExpect(view().name("trade/list"))
                .andExpect(model().attribute("keyword", "삼성"))
                .andExpect(model().attribute("startDate", "2026-09-01"))
                .andExpect(model().attribute("sort", "returnDesc"))
                .andExpect(model().attribute("page", 3))
                .andExpect(model().attribute("totalPages", 3))
                .andExpect(model().attribute("totalCount", 23))
                .andExpect(model().attribute("startPage", 1))
                .andExpect(model().attribute("endPage", 3));

        assertEquals(null, receivedCondition.get().getEndDate());
    }

    @Test
    public void listRejectsUnexpectedSortBeforePassingItToServiceAndView() throws Exception {
        AtomicReference<TradeSearchCondition> receivedCondition = new AtomicReference<>();

        TradeService service = (TradeService) Proxy.newProxyInstance(
                TradeService.class.getClassLoader(),
                new Class<?>[] { TradeService.class },
                (proxy, method, args) -> {
                    if (!"searchPage".equals(method.getName())) {
                        throw new AssertionError("Unexpected service method: " + method.getName());
                    }

                    receivedCondition.set((TradeSearchCondition) args[1]);
                    PageRequestDTO pageRequest = ((PageRequestDTO) args[2]).resolve(0);
                    return new PageResponseDTO<TradeDTO>(
                            Collections.emptyList(), 0, pageRequest, 10);
                }
        );

        MockMvc mvc = MockMvcBuilders.standaloneSetup(
                new TradeController(service, null, null, null)).build();

        mvc.perform(get("/trade/list")
                .param("sort", "\" onmouseover=\"alert(1)")
                .sessionAttr("loginMember", MemberDTO.builder().memberId(7).build()))
                .andExpect(status().isOk())
                .andExpect(model().attribute("sort", (Object) null));

        assertEquals(null, receivedCondition.get().getSort());
    }
}
