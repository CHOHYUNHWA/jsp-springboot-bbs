# jsp-springboot-bbs

### Stack
JSP, SpringBoot, Spring Data JPA, Mybatis, SpringSecurity, Jwt, MySql

### Introduce
JSP와 SpringBoot를 이용한 간단한 미니 게시판 입니다.
DB 접근 기술로는 회원 도메인에는 Spring Data JPA, 게시판 도메인에는 Mybatis를 이용하여 구현되었습니다.

### Detail
회원
1. 회원가입 (아이디 중복체크, 회원가입 유효성 검증)
2. 로그인 (SpringSecurity, JWT)
3. 로그아웃
4. 회원수정
5. 마이페이지

게시판 (현재 구현중) 
1. 게시글 작성
2. 게시글 수정
3. 게시글 조회
4. 게시글 리스트 조회
5. 게시글 삭제
