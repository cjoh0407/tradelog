# TradeLog

> 매매 기록과 복기를 통해 자신의 투자 습관을 확인할 수 있는 개인 매매일지 웹 애플리케이션

## 프로젝트 소개

TradeLog는 사용자가 자신의 매수·매도 기록과 매매 이유, 복기 내용을 기록하고
과거 거래를 다시 확인할 수 있도록 만든 웹 애플리케이션입니다.

단순히 수익과 손실을 저장하는 것뿐만 아니라,
매매 당시의 판단과 결과를 함께 기록하여 자신의 투자 습관을 돌아보는 것을 목표로 합니다.

### 프로젝트 목표

- 매매 기록을 체계적으로 관리한다.
- 거래별 매수/매도 정보와 복기 내용을 기록한다.
- 대시보드에서 거래 결과를 한눈에 확인한다.
- Spring MVC와 MyBatis 기반 웹 애플리케이션 구조를 학습한다.

## 주요 기능

| 기능 | 설명 |
|---|---|
| 회원가입 | 새로운 사용자를 등록합니다. |
| 로그인 / 로그아웃 | 사용자 인증 및 세션을 관리합니다. |
| 매매일지 등록 | 종목, 매수/매도 가격, 수량, 날짜, 매매 이유 등을 기록합니다. |
| 매매일지 목록 | 사용자의 매매 기록을 목록으로 조회합니다. |
| 매매일지 상세 | 특정 거래의 상세 내용을 조회합니다. |
| 매매일지 수정 | 기존 매매 기록을 수정합니다. |
| 매매일지 삭제 | 기존 매매 기록을 삭제합니다. |
| 대시보드 | 거래 횟수, 손익, 최근 거래 등의 요약 정보를 제공합니다. |

## 화면

### 대시보드

![Dashboard](docs/images/ui/dashboard.png)

### 매매일지 등록

![Trade Register](docs/images/ui/trade-register.png)

> 실제 화면 구현 후 이미지를 `docs/images/ui/`에 추가합니다.
> 이미지가 아직 없다면 위 두 줄은 화면 완성 후 추가해도 됩니다.

## 기술 스택

| 구분 | 기술 |
|---|---|
| Language | Java 11 |
| Framework | Spring Framework 5.3.x / Spring MVC |
| View | JSP / JSTL |
| Persistence | MyBatis |
| Database | Oracle Database |
| Connection Pool | HikariCP |
| Build | Maven |
| Logging | SLF4J / Logback |
| Test | JUnit 4 / Spring Test |
| Utility | Lombok |
| Version Control | Git / GitHub |

자세한 내용은 [기술 스택 문서](docs/TECH_STACK.md)를 참고합니다.

## 애플리케이션 구조

TradeLog는 다음과 같은 계층 구조를 사용합니다.

```text
JSP
 ↓
Controller
 ↓
Service
 ↓
Mapper
 ↓
Oracle Database
```

각 계층의 역할은 다음과 같습니다.

| 계층 | 역할 |
|---|---|
| Controller | HTTP 요청 처리 및 화면 연결 |
| Service | 비즈니스 로직 처리 |
| Mapper | MyBatis를 통한 DB 접근 |
| DTO | 계층 간 데이터 전달 |
| JSP | 사용자 화면 |

## 프로젝트 구조

```text
src/main/java
└─ kr.or.tradelog
   ├─ controller
   │  ├─ HomeController.java
   │  ├─ MemberController.java
   │  └─ TradeController.java
   │
   ├─ service
   │  ├─ MemberService.java
   │  └─ TradeService.java
   │
   ├─ mapper
   │  ├─ MemberMapper.java
   │  └─ TradeMapper.java
   │
   └─ dto
      ├─ MemberDTO.java
      └─ TradeDTO.java
```

```text
src/main/webapp/WEB-INF/views
├─ dashboard.jsp
│
├─ member
│  ├─ join.jsp
│  └─ login.jsp
│
└─ trade
   ├─ list.jsp
   ├─ detail.jsp
   ├─ register.jsp
   └─ modify.jsp
```

## 프로젝트 문서

상세 설계 및 기획 문서는 `docs/`에서 관리합니다.

| 문서 | 내용 |
|---|---|
| [요구사항 정의서](docs/REQUIREMENTS.md) | 기능/비기능 요구사항 |
| [MVP](docs/MVP.md) | 최소 구현 범위 |
| [유스케이스](docs/USE_CASES.md) | 사용자 기능 목록 |
| [기술 스택](docs/TECH_STACK.md) | 기술 및 선정 이유 |
| [클래스 다이어그램](docs/architecture/CLASS_DIAGRAM.md) | 주요 클래스 구조 |
| [시퀀스 다이어그램](docs/architecture/SEQUENCE_DIAGRAMS.md) | 주요 기능 처리 흐름 |
| [ERD](docs/database/ERD.md) | 데이터베이스 구조 |
| [UI 설계](docs/ui/UI_SPEC.md) | 화면 정의 |
| [개발 일정](docs/plan/SCHEDULE.md) | 일정 및 마일스톤 |
| [변경 이력](CHANGELOG.md) | 주요 버전 변경 사항 |

## 실행 방법

### 사전 준비

- Java 11
- Maven
- Oracle Database
- Servlet Container
- Git

### 프로젝트 Clone

```bash
git clone https://github.com/YOUR_GITHUB_ID/tradelog.git
cd tradelog
```

### 데이터베이스 준비

DB 스키마를 생성합니다.

```text
db/schema.sql
```

필요한 경우 테스트 데이터를 추가합니다.

```text
db/seed.sql
```

DB 접속 정보는 자신의 개발 환경에 맞게 설정합니다.

> DB 비밀번호와 같은 실제 Credential은 Git 저장소에 Commit하지 않습니다.

### 테스트

```bash
mvn test
```

### Build

```bash
mvn clean package
```

Build가 완료되면 다음 WAR 파일이 생성됩니다.

```text
target/tradelog.war
```

해당 WAR 파일을 사용하는 Servlet Container에 배포합니다.

## 현재 개발 상태

- [x] 프로젝트 기본 환경 구성
- [x] 데이터베이스 기본 설계
- [x] MemberDTO 작성
- [ ] Member Mapper 구현
- [ ] 회원가입 기능 구현
- [ ] 로그인 / 로그아웃 구현
- [ ] Trade DTO / Mapper 구현
- [ ] 매매일지 등록
- [ ] 매매일지 조회
- [ ] 매매일지 수정 / 삭제
- [ ] 대시보드 구현
- [ ] UI 정리
- [ ] 테스트
- [ ] 최종 문서 정리

## MVP

TradeLog의 첫 번째 목표는 다음 기능이 정상적으로 동작하는 것입니다.

```text
회원가입
    ↓
로그인
    ↓
매매일지 등록
    ↓
목록 / 상세 조회
    ↓
수정 / 삭제
    ↓
대시보드 확인
```

세부 범위는 [MVP 문서](docs/MVP.md)를 참고합니다.

## 변경 이력

프로젝트의 주요 변경 사항은 [CHANGELOG.md](CHANGELOG.md)에서 관리합니다.

## Maintainer

- GitHub: @YOUR_GITHUB_ID

## License

학습 및 포트폴리오 목적으로 개발 중인 프로젝트입니다.
라이선스 정책은 공개 배포 범위가 확정된 후 추가합니다.