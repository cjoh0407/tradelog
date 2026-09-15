# TradeLog ERD

```mermaid
erDiagram

    MEMBER ||--o{ TRADE : writes

    MEMBER {
        NUMBER member_id PK
        VARCHAR2 login_id UK
        VARCHAR2 password
        VARCHAR2 nickname
        DATE created_at
    }

    TRADE {
        NUMBER trade_id PK
        NUMBER member_id FK
        VARCHAR2 stock_name
        DATE buy_date
        DATE sell_date
        NUMBER buy_price
        NUMBER sell_price
        NUMBER quantity
        VARCHAR2 buy_reason
        VARCHAR2 review
        VARCHAR2 rule_followed
        DATE created_at
        DATE updated_at
    }
```

## 관계

MEMBER : TRADE = 1 : N

한 명의 회원은 여러 개의 매매일지를 작성할 수 있다.
하나의 매매일지는 하나의 회원에게 속한다.

## 주요 제약조건

| Table | Column | Constraint |
|---|---|---|
| MEMBER | MEMBER_ID | PK |
| MEMBER | LOGIN_ID | UNIQUE / NOT NULL |
| TRADE | TRADE_ID | PK |
| TRADE | MEMBER_ID | FK → MEMBER.MEMBER_ID |