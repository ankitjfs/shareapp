# ShareApp

**ShareApp** is a platform which encourages Employees to share available Resources in their **Company**. 

****

## Entities:

### Resource
**Resource** can be a physical book, ebook, cricket bat, guitar etc

### User
**User** will be always part of one **Company**

### Company
**Company** refer to a **controlled authorized** section of users having standard work email (****@company.com), therefore enabling trust factor to share.

### Allotment
**Allotment** refers to allocation relationship between Resource and User

***
# Functional Use cases : 
1) User able to sign up with his/her company
2) User should be able to search resources in it's company
3) User should be able to raise allocate request to a company's resource not owned by him/her
4) User should be able to manage allocation resuest for it's resource
5) handle soft delete


****
# Non Functional use cases :
1) searching resources should be scable and fast
2) Inconsistency in reads for search should be mitigated within 1 min.


***
# hld :                                                            (sync resource table)
                                        search engine (elastic)     <--    job scheduler (sidekiq)
                                            |                               |
                                            |  (read)                       |
INTERNET  ->   WEBSERVER (NGINX)  -> SHAREAPP (unicorn app server)  <-> cache (redis)
                                            |
                                            |
                                            mysql(main database)



***
# Instructions to run :
1) docker compose up --build 
2) docker compose run shareapp rails db:migrate
3) docker compose run shareapp rails searchkick:reindex:all CLASS=Resource (create es related mappings, analyzer)
4) http://localhost:8020/
5) please mount voliume for redis, es and mysql if required, currently data gets lost on container restart