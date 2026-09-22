package kr.or.tradelog.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.tradelog.dto.StockDTO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StockApiService {

    // 외부 HTTP API 요청
    private final RestTemplate restTemplate;

    // JSON 응답 처리
    private final ObjectMapper objectMapper;

    // NH Access Token 관리
    private final NhTokenService nhTokenService;

    // NH 현재가 조회 API
    private static final String CURRENT_PRICE_URL =
            "https://api.nhplug.com:8443/krstock/quote/v1/currentPrice";


    // 종목코드를 이용하여 NH API에서 현재가 조회
    public StockDTO getCurrentPrice(String stockCode) {

        try {

            // 1. 유효한 Access Token 가져오기
            // 토큰이 없거나 만료되었다면 NhTokenService에서 자동 발급
            String accessToken =
                    nhTokenService.getAccessToken();

            // 토큰 발급 실패
            if (accessToken == null) {
                return null;
            }


            // 2. HTTP Header 생성
            HttpHeaders headers = new HttpHeaders();

            headers.setContentType(MediaType.APPLICATION_JSON);

            // Authorization: Bearer {accessToken}
            headers.setBearerAuth(accessToken);


            // 3. NH API Input_0 데이터 생성
            Map<String, String> input = new HashMap<>();

            input.put("market_cd", "KRX");
            input.put("iem_cd", stockCode);


            // 4. 최종 요청 Body 생성
            Map<String, Object> body = new HashMap<>();

            body.put("Input_0", input);


            // 5. Header + Body
            HttpEntity<Map<String, Object>> request =
                    new HttpEntity<>(body, headers);


            // 6. NH 현재가 API 호출
            ResponseEntity<String> response =
                    restTemplate.postForEntity(
                            CURRENT_PRICE_URL,
                            request,
                            String.class
                    );


            // 7. JSON 응답 처리
            String responseBody = response.getBody();

            JsonNode root =
                    objectMapper.readTree(responseBody);

            JsonNode output =
                    root.get("Output_0");


            // 8. 필요한 데이터 추출
            String stockName =
                    output.get("iem_nm").asText();

            int currentPrice =
                    output.get("stck_prpr").asInt();


            // 9. StockDTO 생성
            return StockDTO.builder()
                    .stockCode(stockCode)
                    .stockName(stockName)
                    .currentPrice(currentPrice)
                    .build();


        } catch (Exception e) {

            e.printStackTrace();

            return null;
        }
    }
}