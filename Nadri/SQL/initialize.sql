CREATE DATABASE NADRI_DEMO;
========================

CREATE TABLE USER(
user_id VARCHAR(15) NOT NULL,
user_name VARCHAR(10) NOT NULL,
password VARCHAR(20) NOT NULL,
email VARCHAR(50) NOT NULL,
profile_img VARCHAR(50),
sex VARCHAR(3),
phone VARCHAR(15),
age INT,
introduce VARCHAR(100),
reg_date DATE,
role VARCHAR(3) NOT NULL DEFAULT '0',
last_login DATETIME,
status VARCHAR(3) NOT NULL DEFAULT '0',
ip VARCHAR(20),
info_option BOOLEAN NOT NULL,
quit_date DATE,
quit_reason VARCHAR(100),
user_status_code VARCHAR(3),
email_code VARCHAR(10),
PRIMARY KEY(user_id));

CREATE TABLE FRIEND(
friend_no INT NOT NULL AUTO_INCREMENT,
user_id VARCHAR(15) NOT NULL,
friend_id VARCHAR(15) NOT NULL,
friend_code VARCHAR(3) NOT NULL DEFAULT '0',
profile_img VARCHAR(50),
PRIMARY KEY(friend_no),
FOREIGN KEY(user_id) REFERENCES USER(user_id),
FOREIGN KEY(friend_id) REFERENCES USER(user_id));

CREATE TABLE SEARCH(
search_no INT NOT NULL AUTO_INCREMENT,
user_id VARCHAR(15) NOT NULL,
search_keyword VARCHAR(30) NOT NULL,
search_condition VARCHAR(3) NOT NULL,
search_time DATETIME NOT NULL,
PRIMARY KEY(search_no),
FOREIGN KEY(user_id) REFERENCES USER(user_id));

CREATE TABLE SPOT(
spot_no INT NOT NULL AUTO_INCREMENT,
spot_code VARCHAR(10) NOT NULL,
spot_title VARCHAR(100) NOT NULL,
spot_phone VARCHAR(30),
spot_address VARCHAR(150),
spot_detail VARCHAR(1500),
spot_x DECIMAL(18,15) NOT NULL,
spot_y DECIMAL(18,15) NOT NULL,
spot_img VARCHAR(200),
spot_createtime DATETIME NOT NULL,
spot_modifytime DATETIME NOT NULL,
spot_province VARCHAR(10) NOT NULL,
spot_detailurl VARCHAR(200),
spot_readcnt INT NOT NULL DEFAULT '0',
PRIMARY KEY(spot_no));

CREATE TABLE SCHEDULE(
schedule_no INT NOT NULL AUTO_INCREMENT,
user_id VARCHAR(15) NOT NULL,
schedule_date DATE NOT NULL,
schedule_img VARCHAR(50),
schedule_title VARCHAR(100) NOT NULL,
transportation_code VARCHAR(10) NOT NULL,
schedule_review TEXT,
hashtag VARCHAR(200),
schedule_createtime DATETIME NOT NULL,
schedule_modifytime DATETIME NOT NULL,
open_range VARCHAR(3) NOT NULL,
PRIMARY KEY(schedule_no),
FOREIGN KEY(user_id) REFERENCES USER(user_id));

CREATE TABLE WAYPOINT(
waypoint_no INT NOT NULL,
schedule_no INT NOT NULL,
waypoint_title VARCHAR(100) NOT NULL,
waypoint_img VARCHAR(50),
waypoint_x DECIMAL(18,15) NOT NULL,
waypoint_y DECIMAL(18,15) NOT NULL,
waypoint_address VARCHAR(150) NOT NULL,
waypoint_detail VARCHAR(200),
staytime TIME NOT NULL,
movetime TIME NOT NULL,
starthour TIME NOT NULL,
endhour TIME NOT NULL,
PRIMARY KEY(waypoint_no, schedule_no),
FOREIGN KEY(schedule_no) REFERENCES schedule(schedule_no) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE CART(
cart_no INT NOT NULL AUTO_INCREMENT,
schedule_no INT,
spot_no INT,
user_id VARCHAR(15) NOT NULL,
cart_code VARCHAR(3) NOT NULL,
cart_detail VARCHAR(100),
cart_title VARCHAR(100),
cart_address VARCHAR(150),
cart_x DECIMAL(18,15),
cart_Y DECIMAL(18,15),
cart_time DATETIME NOT NULL,
stamp_code BOOLEAN DEFAULT '1',
PRIMARY KEY(cart_no),
FOREIGN KEY(schedule_no) REFERENCES SCHEDULE(schedule_no) ON UPDATE CASCADE,
FOREIGN KEY(spot_no) REFERENCES SPOT(spot_no) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(user_id) REFERENCES USER(user_id));
 

CREATE TABLE REWARD(
reward_no INT NOT NULL AUTO_INCREMENT,
user_id VARCHAR(15) NOT NULL,
reward_name VARCHAR(20) NOT NULL,
reward_img VARCHAR(30) NOT NULL,
reward_get_time DATETIME NOT NULL,
reward_level VARCHAR(3) NOT NULL,
PRIMARY KEY(reward_no),
FOREIGN KEY(user_id) REFERENCES USER(user_id));

CREATE TABLE INQUIRE(
inquire_no INT NOT NULL AUTO_INCREMENT,
user_id VARCHAR(15) NOT NULL,
reported_user_id VARCHAR(15),
inquire_code VARCHAR(3) NOT NULL,
inquire_chk_code VARCHAR(3) NOT NULL DEFAULT '0',
inquire_detail VARCHAR(50) NOT NULL,
inquire_title VARCHAR(30) NOT NULL,
inquire_link VARCHAR(50),
inquire_time DATETIME NOT NULL,
inquire_file1 VARCHAR(50),
inquire_file2 VARCHAR(50),
inquire_file3 VARCHAR(50),
PRIMARY KEY(inquire_no),
FOREIGN KEY(reported_user_id) REFERENCES USER(user_id),
FOREIGN KEY(user_id) REFERENCES USER(user_id));

CREATE TABLE CHATROOM(
chatroom_no INT NOT NULL AUTO_INCREMENT,
user_id VARCHAR(255),
user_name VARCHAR(255),
PRIMARY KEY(chatroom_no));

CREATE TABLE NOTICE(
notice_no INT NOT NULL AUTO_INCREMENT,
receiver_id VARCHAR(15),
sender_id VARCHAR(15) NOT NULL,
notice_code VARCHAR(3) NOT NULL,
notice_flag BOOLEAN NOT NULL DEFAULT '1',
master_no INT NOT NULL,
PRIMARY KEY(notice_no),
FOREIGN KEY(receiver_id) REFERENCES USER(user_id),
FOREIGN KEY(sender_id) REFERENCES USER(user_id));

===================================

INSERT 
INTO USER ( user_id, user_name, password, email, sex, age, role, reg_date, last_login, status, ip, info_option, user_status_code)
VALUES ('user01', '바둑이', '1111', 'a@gmail.com', '0', '15', '0', '2018-01-01', '2018-02-06 09:30:00', '0', '111.111.1.111', '0', '1');

INSERT 
INTO USER ( user_id, user_name, password, email, sex, age, role, reg_date, last_login, status, info_option, user_status_code) 
VALUES ('user02', '야옹이', '2222', 'b@gmail.com', '1', '31', '0', '2017-07-08', '2018-04-06 12:30:00', '0', '0', '1');

INSERT 
INTO USER ( user_id, user_name, password, email, sex, phone, age, role, reg_date, last_login, status, info_option, user_status_code) 
VALUES ('user03', '꿀꿀이', '3333', 'c@gmail.com', '0', '010-333-3333', '20', '0', '2014-03-09', '2016-01-09 10:00:00', '2', '1', '1'); 

INSERT 
INTO USER ( user_id, user_name, password, email, sex, age, role, reg_date, last_login, status, ip, info_option, user_status_code) 
VALUES ('user04', '비실이', '4444', 'c@gmail.com', '0', '11', '0', '2016-03-01', '2016-03-07 00:00:00', '1', ' ', '0', '1'); 

INSERT 
INTO USER ( user_id, user_name, password, email, sex, age, introduce, role, reg_date, last_login, status, info_option, user_status_code) 
VALUES ('user05', '퉁퉁이', '5555', 'd@gmail.com', '0', '44', '나는 퉁퉁이야 죽고싶지 않으면 잘 부탁해', '0', '2013-03-01', '2017-05-01 09:00:00', '0', '0', '1'); 

INSERT 
INTO USER ( user_id, user_name, password, email, profile_img, sex, age, role, reg_date, last_login, status, info_option, user_status_code) 
VALUES ('user06', '제니', '6666', 'e@gmail.com', 'jennie.jpg', '1', '23', '0', '2015-04-07', '2018-04-06 02:30:00', '0', '0', '1'); 

INSERT 
INTO USER ( user_id, user_name, password, email, sex, age, role, reg_date, last_login, status, info_option) 
VALUES ('admin', '왕', '1234', 'admin@gmail.com', '1', '55', '1', '2011-01-01', '2017-05-01 09:00:00', '0', '1'); 

INSERT 
INTO friend ( user_id, friend_id, friend_code) 
VALUES ('user01', 'user02', '1');

INSERT 
INTO friend ( user_id, friend_id, friend_code) 
VALUES ('user02', 'user01', '1'); 

INSERT 
INTO friend ( user_id, friend_id, friend_code) 
VALUES ('user03', 'user01', '0'); 

INSERT 
INTO friend ( user_id, friend_id, friend_code) 
VALUES ('user04', 'user02', '2'); 

INSERT 
INTO friend ( user_id, friend_id, friend_code) 
VALUES ('user05', 'user03', '0'); 

INSERT 
INTO friend ( user_id, friend_id, friend_code, profile_img) 
VALUES ('user06', 'user01', '2', 'jeny.jpg'); 

INSERT 
INTO NOTICE ( receiver_id ,sender_id , notice_code , master_no)  
VALUES ( 'user01' , 'user02' , '0' , '1' ) ; 

INSERT 
INTO NOTICE ( receiver_id ,sender_id , notice_code , master_no)  
VALUES ( 'user02' , 'user03' , '0' , '1' ) ; 

INSERT 
INTO NOTICE ( receiver_id ,sender_id , notice_code , master_no  )  
VALUES ( 'user03' , 'user04' , '0' , '1' ) ; 

INSERT 
INTO NOTICE ( receiver_id ,sender_id , notice_code , master_no  )  
VALUES ( 'user05' , 'user01' , '0' , '1' ) ; 

INSERT 
INTO NOTICE ( receiver_id ,sender_id , notice_code , master_no  )  
VALUES ( 'user01' , 'user02' , '0' , '1' ) ; 

INSERT 
INTO CHATROOM ( user_id , user_name )  
VALUES ( ',user01,user02' , '바둑이,야옹이'  ) ; 

INSERT 
INTO CHATROOM ( user_id , user_name )  
VALUES ( ',user02,user03' , '야옹이,꿀꿀이' ) ; 

INSERT 
INTO CHATROOM ( user_id , user_name )  
VALUES ( ',user03,user04,user05' , '꿀꿀이,비실이,퉁퉁이'  ) ; 

INSERT
INTO SPOT (spot_code, spot_title, spot_phone, spot_address, spot_detail, spot_x, spot_y, spot_img, spot_createtime, spot_modifytime, spot_province, spot_detailurl)
VALUES ('4109', '난지캠핑장','02-333-3333', '마포구 상암동 495-81','난지캠핑장', '126.8683003', '37.572048', '19.jpg', '2018/07/06 10:46', '2018/07/06 10:46', '13', 'www.naver.com'); 

INSERT
INTO SPOT (spot_code, spot_title, spot_phone, spot_address, spot_detail, spot_x, spot_y, spot_img, spot_createtime, spot_modifytime, spot_province, spot_detailurl)
VALUES ('4109', '광나루한강공원','02-444-4444', '강동구 선사로83-66 (암사동 637-6)','광나루한강공원', '127.121622699999', '37.5499839', '3.jpg', '2018/06/06 10:46', '2018/06/06 10:46', '2', 'www.naver.com');

INSERT
INTO SPOT (spot_code, spot_title, spot_phone, spot_address, spot_detail, spot_x, spot_y, spot_img, spot_createtime, spot_modifytime, spot_province, spot_detailurl)
VALUES ('4109', '한강드론공원','02-555-5555', '강동구 선사로 83-66 (암사동) 광나루한강공원','한강드론공원', '126.8683003', '37.572048', '4.jpg', '2018/04/10 10:46', '2018/06/10 20:20', '2', 'www.naver.com');

INSERT
INTO SPOT (spot_code, spot_title, spot_phone, spot_address, spot_detail, spot_x, spot_y, spot_img, spot_createtime, spot_modifytime, spot_province, spot_detailurl)
VALUES ('4109', '양화한강공원','02-666-6666', '영등포구 노들로 221(당산동 96-1)','양화한강공원', '126.8683003', '37.572048', '5.jpg', '2018/01/06 10:46', '2018/01/06 10:46', '20', 'www.naver.com');

INSERT
INTO SPOT (spot_code, spot_title, spot_phone, spot_address, spot_detail, spot_x, spot_y, spot_img, spot_createtime, spot_modifytime, spot_province, spot_detailurl)
VALUES ('11', '필동면옥','02-333-3333', '중구 필동3가 1-5','필동면옥', '126.99689', '37.56035', '123.jpg', '2018/01/02 10:12', '2018/01/02 10:12', '24', 'http://blog.naver.com/newestj35/220725468512'); 

INSERT
INTO SPOT (spot_code, spot_title, spot_phone, spot_address, spot_detail, spot_x, spot_y, spot_img, spot_createtime, spot_modifytime, spot_province, spot_detailurl)
VALUES ('10', '남도식당','02-734-0719', '종로구 청진동 204-1','#연탄삼겹살#백종원', '126.97942', '37.57219', '114.jpg', '2017/12/06 12:50', '2018/07/06 11:42', '23', 'http://blog.naver.com/mmmmmz_o/220774936519');  

INSERT
INTO SCHEDULE (user_id, schedule_date, schedule_img, schedule_title, transportation_code, schedule_review, hashtag, schedule_createtime, schedule_modifytime, open_range)
VALUES ('user01' , '2018-07-05', 'user01schedule.jpg', '한강공원나들이', '0' , '', '#광나루한강공원#한강드론공원', '2018-07-04 23:55:25', '2018-07-04 23:55:25', '0'); 

INSERT
INTO SCHEDULE (user_id, schedule_date, schedule_img, schedule_title, transportation_code, schedule_review, hashtag, schedule_createtime, schedule_modifytime, open_range)
VALUES ('user02' , '2018-07-07', 'user02schedule.jpg', '즐거운남산투어', '1' , '', '#남산도시자연공원#대성갈비', '2018-07-05 23:55:25', '2018-07-05 23:55:25', '0'); 

INSERT
INTO SCHEDULE (user_id, schedule_date, schedule_img, schedule_title, transportation_code, schedule_review, hashtag, schedule_createtime, schedule_modifytime, open_range)
VALUES ('user03' , '2018-07-08', '', '스펙타클한우리들의서울맛집', '0' , '정말행복한서울맛집투어였어요! 모든 사람들에게 추천드립니다!!', '#옹달샘#리치몬드#당인식당', '2018-07-06 23:55:25', '2018-07-06 23:55:25', '0'); 

INSERT
INTO WAYPOINT ( waypoint_no, schedule_no, waypoint_title, waypoint_img, waypoint_x, waypoint_y, waypoint_address, waypoint_detail, staytime, movetime, starthour, endhour) 
VALUES ('1' , '1' , '광나루한강공원', 'parkgwang.jpg', '127.12162269', '37.5499839', '강동구 선사로83-66 (암사동 637-6)', '한강공원나들이1', '00:50:00', '00:40:00', '13:00:00', '13:50:00');

INSERT
INTO WAYPOINT ( waypoint_no, schedule_no, waypoint_title, waypoint_img, waypoint_x, waypoint_y, waypoint_address, waypoint_detail, staytime, movetime, starthour, endhour) 
VALUES ('1' , '2' , '한강드론공원', 'dron.jpg', '127.12162269', '37.5499839', '강동구 선사로 83-66 (암사동) 광나루한강공원', '한강공원나들이2', '00:50:00', '00:10:00', '14:00:00', '14:50:00');

INSERT
INTO WAYPOINT ( waypoint_no, schedule_no, waypoint_title, waypoint_img, waypoint_x, waypoint_y, waypoint_address, waypoint_detail, staytime, movetime, starthour, endhour) 
VALUES ('2' , '1' , '남산도시자연공원', 'NAMSAN.jpg', '126.9903773', '37.5501402', '중구 삼일대로 231(예장동)', '즐거운남산투어1', '01:00:00', '00:40:00', '16:00:00', '17:00:00');

INSERT
INTO WAYPOINT ( waypoint_no, schedule_no, waypoint_title, waypoint_img, waypoint_x, waypoint_y, waypoint_address, waypoint_detail, staytime, movetime, starthour, endhour) 
VALUES ('2' , '2' , '대성갈비', 'galbi.jpg', '127.0440495', '37.5470143', '성동구 성수동1가 668-21', '즐거운남산투어2', '01:30:00', '00:10:00', '18:40:00', '20:10:00');

INSERT
INTO WAYPOINT ( waypoint_no, schedule_no, waypoint_title, waypoint_img, waypoint_x, waypoint_y, waypoint_address, waypoint_detail, staytime, movetime, starthour, endhour) 
VALUES ('3' , '1' , '옹달샘', 'sam.jpg', '126.9903773', '37.5501402', '마포구 서교동 402-3', '스펙타클한우리들의서울맛집1', '00:20:00', '00:40:00', '11:00:00', '11:20:00');

INSERT
INTO WAYPOINT ( waypoint_no, schedule_no, waypoint_title, waypoint_img, waypoint_x, waypoint_y, waypoint_address, waypoint_detail, staytime, movetime, starthour, endhour) 
VALUES ('3' , '2' , '리치몬드', 'd.jpg', '127.0440495', '37.5470143', '마포구 성산1동 114-5', '스펙타클한우리들의서울맛집2', '00:30:00', '00:10:00', '12:00:00', '12:30:00');

INSERT
INTO WAYPOINT ( waypoint_no, schedule_no, waypoint_title, waypoint_img, waypoint_x, waypoint_y, waypoint_address, waypoint_detail, staytime, movetime, starthour, endhour) 
VALUES ('3' , '3' , '당인식당', 'dang.jpg', '126.92018459', '37.5455663', '마포구 당인동 25-22', '스펙타클한우리들의서울맛집3', '00:30:00', '00:10:00', '12:40:00', '13:10:00');

INSERT
INTO BOARD (user_id, board_time, board_title, board_content, board_img, hashtag, open_range)
VALUES ('user01', '2018-07-05 09:30:00', '한강공원나들이', '내일은 한강에 갈 예정!!', '180706_130000_1.jpg', '#광나루한강공원', 0);

INSERT
INTO BOARD (user_id, board_time, board_title, board_content, board_img, open_range)
VALUES ('user01', '2018-07-06 13:00:00', '2번 게시물', '오늘은 한강에 갔다. 참 좋았다.', '180706_130000_1.jpg,180706_130000_2.jpg', 0);

INSERT
INTO BOARD (user_id, board_time, board_title, board_content, board_img, open_range)
VALUES ('user02', '2018-06-06 09:09:09', '3번 게시물', '현충일엔 국립현충원 방문~', '180606_090909_1.jpg,180606_090909_2.jpg,180606_090909_3.jpg,180606_090909_4.jpg,180606_090909_5.jpg', 0);

INSERT
INTO BOARD (user_id, board_time, board_title, board_content, board_img, open_range)
VALUES ('user02', '2018-06-08 14:14:14', '4번 게시물', '오늘.저녁.존맛.', '180608_141414_1.jpg', 1);

INSERT
INTO BOARD (user_id, board_time, board_title, board_content, open_range)
VALUES ('user03', '2018-07-01 00:00:01', '5번 게시물', '키키키키 뻘글잼~<br>키키키키 뻘글잼~<br>키키키키 뻘글잼~<br>키키키키 뻘글잼~<br>키키키키 뻘글잼~<br>키키키키 뻘글잼~<br>키키키키 뻘글잼~<br>', 0);

INSERT
INTO BOARD (user_id, board_time, board_title, board_content, open_range)
VALUES ('user04', '2018-04-04 23:00:23', '6번 게시물', '쒸익쒸익..오늘도 퉁퉁이가 날 괴롭혔다..부들부들', 2);

INSERT
INTO COMMENT (user_id, board_no, comm_time, comm_content)
VALUES ('user02', '1', '2018-07-05 09:33:33', '내일 재밌겠다 꺅!!!!');

INSERT
INTO COMMENT (user_id, board_no, comm_time, comm_content)
VALUES ('user04', '1', '2018-07-05 09:44:44', '데이트하시나봐요 흑흑 저도 가고싶어요');

INSERT
INTO COMMENT (user_id, board_no, comm_time, comm_content)
VALUES ('user04', '3', '2018-06-06 10:05:00', '퉁퉁이보다 훨씬 멋있으세요(소근소근)');

INSERT
INTO LIKES (board_no, user_id, likes_time)
VALUES ('1', 'user05', '2018-07-05 09:31:31');

INSERT
INTO LIKES (board_no, user_id, likes_time)
VALUES ('1', 'user02', '2018-07-05 09:35:35');

INSERT
INTO LIKES (board_no, user_id, likes_time)
VALUES ('2', 'user01', '2018-07-06 13:01:01');

INSERT
INTO LIKES (board_no, user_id, likes_time)
VALUES ('3', 'user04', '2018-06-06 10:00:00');

INSERT
INTO CART (spot_no, user_id, cart_code, cart_time)
VALUES ('1', 'user06', '1', '2018-07-06 22:22:22');

INSERT
INTO CART (spot_no, user_id, cart_code, cart_time, stamp_code)
VALUES ('4', 'user06', '1', '2018-07-06 18:18:18', '0');

INSERT
INTO CART (schedule_no, user_id, cart_code, cart_time)
VALUES ('1', 'user04', '0', '2018-07-05 09:55:55');

INSERT
INTO CART (user_id, cart_code, cart_detail, cart_title, cart_address, cart_x, cart_y, cart_time)
VALUES ('user04', '2', '비트캠프 앞 볶음밥맛집', '하나우동', '서초구 서초동 1327-35', '127.02821340000003', '37.4944838', '2018-07-06 20:36:23');

INSERT INTO
inquire (user_id,inquire_code,inquire_chk_code,inquire_detail,inquire_title,inquire_link,inquire_time,inquire_file1,inquire_file2,inquire_file3)
VALUES('user01','0','0','이게대체뭐에요 글 진짜 어이없는내용인데 왜 삭제안됨?;;','음란게시글 ㅡㅡ','','2018-01-20 11:10:05','inquire_test01','inquire_test02','inquire_test03');

INSERT INTO
inquire (user_id,inquire_code,inquire_detail,inquire_title,inquire_link,inquire_time,inquire_file1,inquire_file2,inquire_file3)
VALUES('user02','3','장난 똥때리나지금','머하는 짓이야이게','','2018-03-20 11:10:05','inquire_test01','inquire_test02','inquire_test03');

INSERT INTO
inquire (user_id,inquire_code,inquire_detail,inquire_title,inquire_link,inquire_time,inquire_file1,inquire_file2,inquire_file3)
VALUES('user03','2','테스트용 내용입니다 이것은','테스트한다','','2018-02-20 11:10:05','inquire_test01','inquire_test02','inquire_test03');

INSERT INTO
inquire (user_id,inquire_code,inquire_detail,inquire_title,inquire_link,inquire_time,inquire_file1,inquire_file2,inquire_file3)
VALUES('user04','0','테스트한다아아아아앙~','테슷테슷','','2018-01-20 11:10:05','inquire_test01','inquire_test02','inquire_test03');

INSERT
INTO search (user_id,search_keyword,search_condition,search_time)
VALUES('user01','한강','0','2018-01-01 10:57:25');

INSERT
INTO search (user_id,search_keyword,search_condition,search_time)
VALUES('user01','반포한강공원','1','2018-04-02 10:57:25');

INSERT
INTO search (user_id,search_keyword,search_condition,search_time)
VALUES('user03','공원','1','2018-03-14 10:57:25');

INSERT
INTO search (user_id,search_keyword,search_condition,search_time)
VALUES('user02','한강','0','2018-02-22 10:57:25');

INSERT
INTO search (user_id,search_keyword,search_condition,search_time)
VALUES('user02','강남','0','2018-02-23 10:57:25');

INSERT
INTO search (user_id,search_keyword,search_condition,search_time)
VALUES('user04','광화문','0','2018-03-11 10:57:25');

INSERT
INTO search (user_id,search_keyword,search_condition,search_time)
VALUES('user05','서울숲','0','2018-02-17 10:57:25');

INSERT
INTO reward (user_id,reward_name,reward_img,reward_get_time,reward_level)
VALUES('user01','like','like01','2018-02-05 10:57:25','0');

INSERT
INTO reward (user_id,reward_name,reward_img,reward_get_time,reward_level)
VALUES('user03','board','board01','2018-01-20 10:57:25','0');

INSERT
INTO reward (user_id,reward_name,reward_img,reward_get_time,reward_level)
VALUES('user03','board','board02','2018-01-20 11:10:05','1');

INSERT
INTO reward (user_id,reward_name,reward_img,reward_get_time,reward_level)
VALUES('user02','inquire','inquire01','2018-01-22 11:10:05','0');

INSERT
INTO reward (user_id,reward_name,reward_img,reward_get_time,reward_level)
VALUES('user04','schedule','schedule01','2018-01-10 11:10:05','0');
