package kr.or.tradelog.service;

import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NhTokenService {

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;

    @Value("${nh.appkey}")
    private String appKey;

    @Value("${nh.appsecretkey}")
    private String appSecretKey;

    private String accessToken;
    private long tokenExpireTime;

    private static final String TOKEN_URL =
            "https://api.nhplug.com:8443/oauth2/token";


    public synchronized String getAccessToken() {

        // 기존 토큰이 있고 아직 유효하면 그대로 사용
        if (accessToken != null
                && System.currentTimeMillis() < tokenExpireTime) {

            return accessToken;
        }

        // 없거나 만료됐으면 새로 발급
        return issueAccessToken();
    }


    private String issueAccessToken() {

        try {

            HttpHeaders headers = new HttpHeaders();

            headers.set(
                    HttpHeaders.CONTENT_TYPE,
                    "application/x-www-form-urlencoded"
            );

            String body =
                    "appkey=" + URLEncoder.encode(appKey, "UTF-8")
                    + "&appsecretkey=" + URLEncoder.encode(appSecretKey, "UTF-8")
                    + "&grant_type=client_credentials"
                    + "&scope=oob";


            HttpEntity<String> request =
                    new HttpEntity<>(body, headers);


            ResponseEntity<String> response =
                    restTemplate.postForEntity(
                            TOKEN_URL,
                            request,
                            String.class
                    );


            JsonNode root =
                    objectMapper.readTree(response.getBody());


            accessToken =
                    root.get("access_token").asText();

            long expiresIn =
                    root.get("expires_in").asLong();


            tokenExpireTime =
                    System.currentTimeMillis()
                    + (expiresIn * 1000)
                    - (60 * 1000);


            return accessToken;

        } catch (Exception e) {

            e.printStackTrace();

            return null;
        }
    }
}