package kr.or.tradelog.service;

import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.tradelog.dto.StockDTO;

@Service
public class StockMasterService {

    // 종목 마스터 파일에서 검색어가 포함된 종목을 찾아 반환
    public List<StockDTO> searchStocks(String keyword) {

        try {

            // resources/stock-data 경로의 종목 마스터 파일을 읽기 위한 InputStream 생성
            InputStream is =
                    getClass()
                        .getClassLoader()
                        .getResourceAsStream("stock-data/m_new_stock.mst");

            // 파일을 찾지 못한 경우 빈 검색 결과 반환
            if (is == null) {
                System.out.println("종목 마스터 파일을 찾을 수 없습니다.");
                return new ArrayList<>();
            }

            // 종목 마스터 파일은 종목 하나당 237byte의 고정 길이 데이터
            byte[] record = new byte[237];
            int bytesRead;

            // 마스터 파일에서 읽은 전체 종목을 저장할 리스트
            List<StockDTO> stockList = new ArrayList<>();

            // 파일의 끝(-1)에 도달할 때까지 237byte 단위로 읽기
            while ((bytesRead = is.read(record)) != -1) {

                // 0번째 byte부터 6byte → 종목코드
                String stockCode = new String(
                        record,
                        0,
                        6,
                        Charset.forName("CP949")
                );

                // 7번째 byte부터 41byte → 한글 종목명
                // 고정 길이 데이터 뒤에 붙은 공백은 stripTrailing()으로 제거
                String stockName = new String(
                        record,
                        7,
                        41,
                        Charset.forName("CP949")
                ).stripTrailing();

                // 종목명 앞에 붙을 수 있는 공백, *, # 제거
                if (stockName.startsWith(" ")
                        || stockName.startsWith("*")
                        || stockName.startsWith("#")) {

                    stockName = stockName.substring(1);
                }

                // 읽은 종목코드와 종목명을 StockDTO로 변환
                StockDTO stock = StockDTO.builder()
                        .stockCode(stockCode)
                        .stockName(stockName)
                        .build();

                // 전체 종목 리스트에 추가
                stockList.add(stock);
            }

            // 검색 결과를 저장할 리스트
            List<StockDTO> searchResult = new ArrayList<>();

            // 전체 종목을 하나씩 확인
            for (StockDTO stock : stockList) {

                // 종목명에 사용자가 입력한 검색어가 포함되어 있으면
                if (stock.getStockName().contains(keyword)) {

                    // 검색 결과 리스트에 추가
                    searchResult.add(stock);
                }
            }

            // 검색된 종목 목록을 Controller에 반환
            return searchResult;

        } catch (Exception e) {
            e.printStackTrace();

            // 파일 처리 중 문제가 발생하면 빈 리스트 반환
            return new ArrayList<>();
        }
    }
}