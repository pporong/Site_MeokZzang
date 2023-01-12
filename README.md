
# [웹서비스] 레시피 공유 사이트 MEOK ZZANG 먹짱
---
# 💁담당자 정보 
- 페이지 담당자 : 간보름
- [👧💻 먹짱 작업위키](https://to2.kr/ecQ)
- [👧💻 개발자 위키 : 코드펜 ](https://to2.kr/ecC)
- [👧💻 개발자 수업공부 위키](https://cdpn.io/pporong/fullpage/XWEjJNK)

#  📑 프로젝트 정보 : 2022  11. 24 ~  12. 25 (약 30일)
- [📌  대표 페이지](https://to2.kr/ecD)
	- https://to2.kr/ecD
- [🔗 Git 리포지터리](https://github.com/pporong/Site_MeokZzang)
	- https://github.com/pporong/Site_MeokZzang.git

# 📌 <span style="color: #ff0000"> 여기를 확인해보세요!!!  </span>
<span style="color: #ff0000"> 전체적인 작업 과정입니다 !! </span>
- [📑 먹짱 작업위키](https://wiken.io/ken/11572)
	- https://to2.kr/ecQ
    - [먹짱 작업위키 pdf 파일](https://drive.google.com/file/d/1cz0CNd22xFhwW1_H7RQakz81bvSAdY5Q/view?usp=sharing)
	    - 먹짱 작업위키를 pdf 파일로 볼 수 있습니다.

# 💻 관련링크
<span style="color: #ff0000"> 포트폴리오에 대한 설명은 기획서와 기술서를 확인해주세요 </span>

- [먹짱 기획서](https://drive.google.com/file/d/1Z5_diBWEA_AiX-VOIwsLU2hA0H-CQmQD/view?usp=sharing)
	-  프로젝트 관련 개요와 페이지 설명(PPT)
    - [ppt로 보기](https://www.canva.com/design/DAFVd4pV6j8/LbfbjZo-KhFi3fKRh_6XSw/view?utm_content=DAFVd4pV6j8&utm_campaign=share_your_design&utm_medium=link&utm_source=shareyourdesignpanel)
    	- 기획서 ppt로 보기
- [먹짱 기술서](https://drive.google.com/file/d/1AQWctAY5csgyfyD4jTLBGeGz91dZWY7l/view?usp=sharing)
	- 기능의 동작과정을 소스코드와 함께 <span style="color: #ff0000"> 상세설명 </span>
- [작업 목록](https://wiken.io/ken/11572)
	- 웹서비스에 대한 개요 및 과정을 볼 수 있습니다.
- [페이지 정보 pdf 파일](https://drive.google.com/file/d/1vo1CJQ6wdfkoCYWfQufmHK9SjgeeCrCO/view?usp=sharing)
	- 현재 페이지 정보를 pdf 파일로 볼 수 있습니다.

# 🔥 개요 및 목적
- 개요 : 	일상에서 가장 중요하다고 생각하는 식 생활의 퀄리티 상승을 위한 레시피 공유 사이트 개설
- 목적 
	- 나만의 요리 레시피를 등록하고 소개
	- 등록 된 레시피를 검색 및 활용
	- 자유 게시판을 통한 커뮤니티 활동
- 기대 효과
	- 배달쓰레기 감소
    - 음식물 쓰레기 감소
    - 건강한 식생활 
    - 커뮤니티 활동

# 🔥 설계의 주안점
- 주 재료 또는 메뉴 이름에 부분적으로 매칭이 되는 것 까지 검색 될 수 있도록 검색 기능 구현
- 레시피 등록 시 블로그 형식으로 이미지와 글이 순차적으로 보여질 수 있도록 구현
- 레시피 게시판 뿐만 아니라 자유 게시판을 통한 커뮤니티 활동
- 관리자 / 사용자 페이지를 나누어 관리와 서비스 영역을 분리
- OPEN API를 활용한 맛집 검색 및 주소 노출
---
## 📑 동작과정 이미지 및 설명
![원본이미지](https://i.imgur.com/p2ZSiel.png)
1. Client 에게 받은 요청을 Controller 에게 보내기 전에 Interceptor 에서 로그인 여부를
확인합니다.
2. Interceptor 에서 통과된 데이터는 Controller 에게 전달 한 후 Controller 에서 Request 를
통해 액션이 실행되며 비즈니스 로직에 관련된 부분은 Service 에게 위임합니다. (Model 
박스)
3. Service 에서는 Controller 에게 받은 데이터를 분석 / 처리 해주고 데이터 보관, 수정,
삭제를 위해 Repository 에게 위임합니다.
4. 계층 간 데이터 교환에 VO 가 사용됩니다. (Lombok 을 사용하여 클래스에 getter, setter, 
생성자 등을 자동으로 생성 해줌)
5. DB 로의 접근을 위해 Repository 인터페이스에서 Mybatis 를 id 로 호출합니다.
6. Mapper 로 xml 파일에서 호출 된 쿼리를 JDBC 가 DB 와 통신합니다. (application.yml 
파일에서 관련 설정에 따라 mysql 과 통신함)
7. Service 는 요청했던 데이터를 Repository 에게 받고 로직에 따라 처리된 리턴 데이터를
Controller 에게 전달합니다.
8. Controller 는 JSP 로 응답데이터를 전달, JSP 는 해당 데이터를 포함 한 페이지를 구성하게
됩니다.
9. 사용자는 요청에 따라 구성된 페이지를 볼 수 있게 됩니다
---
## 📚사용된 기술
- 형상 관리툴
```
  🛠️ - GitHub
```
## 📚 기술 스택
```
 🛠️ - Tomcat
 🛠️ - JDK 
 🛠️ - JSP
 🛠️ - JDBC
 🛠️ - Maria DB
 🛠️ - jQuery 1.11
 🛠️ - Spring / Spring Boot 
 🛠️ - Mybatis
 🛠️ - HTML , CSS , JS
 🛠️ - lodash
 🛠️ - AJAX
 🛠️ - TailWindcss
 🛠️ - DaisyUI
```
## 📚 개발 환경
```
  🛠️ - SpringBoot
  🛠️ - SQLYog Commnunity Edition
  🛠️ - Maven Repository
  🛠️ - MariaDB
  🛠️ - Tomcat
  🛠️ - Windows 10
  🛠️ - Chrome
```
# 📚 서비스 환경
```
  🛠️ - MariaDB
```

## 📁 주요 폴더 및 파일
- UsrHomeController : 루트 경로
- UsrArticleController : 게시물 기능 전반
- UsrRecipeController : 레시피 기능 전반
- UsrMemberController : 회원 기능 전반
- UsrReacionPointController : 게시물 좋아요 / 싫어요 기능
- UsrScrpaPointController :  레시피 스크랩 기능
- UserReplyController : 댓글 기능
- APIController : API 기능
- CommonGenFileController.java  :  이미지 기능 전반
- head.jspf : 모든 의존성 적용, 상단바
- Ut.java : 메세지
- Vo.java : 객체 모델링
- ResultData.java : 데이터 메세지(success, fail)
- Rq.java : HttpServletRequest, HttpServletResponse, Ajax
- NeedLoginInterceptor.java : 로그인 체크
- NeedLogoutInterceptor.java : 로그아웃 체크
- NeedAdminInterceptor.java : 관리자 체크
- BeforeActionInterceptor.java : 핸들러

## 📋️ 기능현황 표
| 구분 | 기능 | 구현 | 테스트 | 배포
| -- | -- | -- | -- | -- |
|  <span style="color: #ff0000">회원(member)</span> | 로그인 | ✔️ | ✔️ | - | 
| 회원(member) | 로그아웃 | ✔️ | ✔️ | - | 
| 회원(member) | 회원가입 | ✔️ | ✔️ | - | 
| 회원(member) | 로그인/로그아웃/회원가입 후 이전 페이지로 리다이렉트 | ✔️ | ✔️ | - | 
| 회원(member) | 회원가입시 아이디 중복체크 | ✔️ | ✔️ | - | 
| 회원(member) | 회원가입시 닉네임 중복체크 | ✔️ | ✔️ | - | 
| 회원(member) | 비밀번호가 입력되는 페이지에서 암호화처리 | ✔️ | ✔️ | - | 
| 회원(member) | 회원정보 확인 / 수정 | ✔️ | ✔️ | - | 
| 회원(member) | 아이디 찾기 | ✔️ | ✔️ | - | 
| 회원(member) | 비밀번호 찾기 | ✔️ | ✔️ | - | 
| 회원(member) | 이메일로 임시 비밀번호 발송 | ✔️ | ✔️ | - | 
| 회원(member) | 비밀번호 변경 / 수정 | ✔️ | ✔️ | - | 
| 회원(member) | 임시 비밀번호로 로그인 시 비밀번호 변경 권유 | ✔️ | ✔️ | - | 
| 회원(member) | 프로필 이미지 등록 / 변경 / 삭제 | ✔️ | ✔️ | - | 
| 회원(member) | 회원 탈퇴 | ✔️ | ✔️ | - | 
|  <span style="color: #ff0000">관리자(admin)</span> | 회원 목록 조회 | ✔️ | ✔️ | - | 
| 관리자(admin) | 회원 검색 | ✔️ | ✔️ | - | 
| 관리자(admin) | 회원이 작성한 게시물 조회 | ✔️ | ✔️ | - | 
| 관리자(admin) | 회원 선택 삭제 | ✔️ | ✔️ | - | 
| 관리자(admin) | 공지사항 게시판 사용가능 | ✔️ | ✔️ | - | 
|  <span style="color: #ff0000">게시물(article)</span> | 게시물 작성 |✔️ | ✔️ | - | 
| 게시물(article) | 게시물 수정 |✔️ | ✔️ | - | 
| 게시물(article) | 게시물 삭제 |✔️ | ✔️ | - | 
| 게시물(article) | 게시물 조회 |✔️ | ✔️ | - | 
| 게시물(article) | 게시물 검색 |✔️ | ✔️ | - | 
| 게시물(article) | 게시물 좋아요 / 싫어요 |✔️ | ✔️ | - | 
| 게시물(article) | 게시물 조회수 증가 |✔️ | ✔️ | - | 
| 게시물(article) | 게시물 페이징 |✔️ | ✔️ | - | 
|  <span style="color: #ff0000">레시피(recipe)</span> | 레시피 작성 |✔️ | ✔️ | - | 
| 레시피(recipe) | 레시피 수정 |✔️ | ✔️ | - | 
| 레시피(recipe) | 레시피 삭제 |✔️ | ✔️ | - | 
| 레시피(recipe) | 레시피 조회 |✔️ | ✔️ | - | 
| 레시피(recipe) | 레시피 스크랩 |✔️ | ✔️ | - | 
| 레시피(recipe) | 레시피 스크랩 취소 |✔️ | ✔️ | - | 
| 레시피(recipe) | 레시피 조회수 증가 |✔️ | ✔️ | - | 
| 레시피(recipe) | 레시피 작성 시 재료 양념칸 추가 및 삭제 |✔️ | ✔️ | - | 
| 레시피(recipe) | 레시피 수정 시 재료 양념칸 추가 및 삭제 |✔️ | ✔️ | - |
| 레시피(recipe) | 레시피 작성 시 조리 과정 이미지 / 설명칸 추가 및 삭제 |✔️ | ✔️ | - |  
| 레시피(recipe) | 레시피 완성 이미지 등록 / 수정 |✔️ | ✔️ | - |  
| 레시피(recipe) | 검색(재료, 레시피 이름)  |✔️ | ✔️ | - |  
| <span style="color: #ff0000">리액션(reaction)</span> | 게시물 좋아요 / 싫어요 |✔️ | ✔️ | - | 
| 리액션(reaction)| 댓글 추천 |✔️ | ✔️ | - | 
| 리액션(reaction)| 레시피 스크랩 |✔️ | ✔️ | - | 
| <span style="color: #ff0000">API DATA</span> | 대전광역시 맛집 검색  |✔️ | ✔️ | - | 
| API DATA | 카카오맵 로드   |✔️ | ✔️ | - | 
| API DATA | 카카오맵 좌표 표시   |✔️ | ✔️ | - | 
| <span style="color: #ff0000">댓글(reply)</span> | 작성  |✔️ | ✔️ | - | 
| 댓글(reply) |  수정  |✔️ | ✔️ | - | 
| 댓글(reply) |  삭제  |✔️ | ✔️ | - | 
| 댓글(reply) |  추천  |✔️ | ✔️ | - | 
| <span style="color: #ff0000">메인 페이지</span> |  최근 공지사항 5건 노출  |✔️ | ✔️ | - | 
| 메인 페이지 |  인기 레시피 랭킹(조회수+스크랩 높은 순) top 3  |✔️ | ✔️ | - | 
| 메인 페이지 |  최신 레시피 랭킹 top 3  |✔️ | ✔️ | - |
---

