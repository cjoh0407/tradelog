# TradeLog Tech Stack

| 영역 | 기술 | 버전 | 선정 이유 |
|---|---|---|---|
| Language | Java | 11 | 서버 애플리케이션 구현 |
| Web Framework | Spring Framework | 5.3.x | MVC 구조 학습 |
| View | JSP / JSTL | - | Server Side Rendering |
| ORM / Persistence | MyBatis | 3.5.x | SQL 직접 관리 |
| Database | Oracle | - | 관계형 데이터 저장 |
| Connection Pool | HikariCP | 5.x | DB Connection 관리 |
| Build | Maven | - | Dependency 및 Build 관리 |
| Logging | SLF4J / Logback | - | 로그 관리 |
| Testing | JUnit | 4.x | 단위/통합 테스트 |
| Utility | Lombok | - | 반복 코드 감소 |

## Architecture

```text
Browser
   ↓
JSP
   ↓
Controller
   ↓
Service
   ↓
Mapper
   ↓
MyBatis
   ↓
Oracle