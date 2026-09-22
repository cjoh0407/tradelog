package kr.or.tradelog.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.tradelog.dto.StockDTO;
import kr.or.tradelog.service.StockApiService;
import kr.or.tradelog.service.StockMasterService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/stock")
public class StockController {

    private final StockApiService stockApiService;
    private final StockMasterService stockMasterService;
    
    @GetMapping("/test")
    @ResponseBody
    public StockDTO test(@RequestParam("stockCode") String stockCode) {
    	StockDTO stock = stockApiService.getCurrentPrice(stockCode);
    	
    	return stock;
    }
    
    @GetMapping("/search")
    @ResponseBody
    public List<StockDTO> search(
            @RequestParam("keyword") String keyword) {

        return stockMasterService.searchStocks(keyword);
    }
}
