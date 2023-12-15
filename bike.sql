use bike;

-- BoothInfo 테이블 생성
CREATE TABLE BoothInfo (
    BNo INT, -- 부스 번호 (고유 식별자)
    BName VARCHAR(50), -- 부스 이름
	RoadLocation VARCHAR(100), -- 도로명주소
    BLocation VARCHAR(50), -- 부스 위치
    Latitude DECIMAL(10, 6), -- 위도
    Longitude DECIMAL(10, 6), -- 경도
    Install_date DATE, -- 설치 날짜
	Install_type VARCHAR(10), -- 설치 유형 (LCD 또는 QR)
    LCDNo INT(3),
    QRNo INT(3),
    PRIMARY KEY (BNo, BName, BLocation)
);

-- BoothMaster 테이블 생성
CREATE TABLE BoothMaster (
    BID VARCHAR(30) PRIMARY KEY, -- 부스 마스터의 고유 식별자
    RoadLocation VARCHAR(100), -- 도로명주소
    BLocation VARCHAR(50), -- 부스 마스터의 위치
    Longitude DECIMAL(10, 6), -- 경도
    Latitude DECIMAL(10, 6) -- 위도 (없는 대여소면 둘다 0)
);

-- Riding 테이블 생성
CREATE TABLE Riding (
    Start_BID INT, -- 시작 부스 식별자
    Start_BName VARCHAR(50), -- 시작 부스 이름
    Finish_BID INT, -- 종료 부스 식별자
    Finish_BName VARCHAR(50), -- 종료 부스 이름
    TravelDate DATE, -- 여행 날짜
    BorrowTime TIME, -- 여행 시작 시간
    UsedTime TIME, -- 여행 시간
    UsedDistance DECIMAL(10, 2), -- 이동 거리
    PRIMARY KEY (Start_BID, Finish_BID),
    FOREIGN KEY (Start_BID, Start_BName) REFERENCES BoothInfo (BNo, BName), -- BoothInfo에 대한 외래 키
    FOREIGN KEY (Finish_BID, Finish_BName) REFERENCES BoothInfo (BNo, BName) -- BoothInfo에 대한 외래 키
);

-- 즐겨찾기 // BoothMaster와 내용 동일
CREATE TABLE favorites (
    BID VARCHAR(30) PRIMARY KEY, -- 부스 마스터의 고유 식별자
    RoadLocation VARCHAR(100), -- 도로명주소
    BLocation VARCHAR(50), -- 부스 마스터의 위치
    Longitude DECIMAL(10, 6), -- 경도
    Latitude DECIMAL(10, 6) -- 위도 (없는 대여소면 둘다 0)
);

/* -- 원본이 지도를 쓰는 것을 감안하면 위도/경도도 필요할 수 있어서 보류 중
ALTER TABLE favorites DROP COLUMN Longitude;
ALTER TABLE favorites DROP COLUMN Latitude;
*/

-- 회원 테이블
CREATE TABLE userlist (
    UID VARCHAR(40),
    username VARCHAR(30),
    PASSWORD VARCHAR(50),
    HP INT(11) -- 에러 대비해서 12로 놔야 할까?
);


/* Usage 테이블 생성
CREATE TABLE Usage (
    Start_BID INT, -- 시작 부스 식별자
    Start_BName VARCHAR(50), -- 시작 부스 이름
    Finish_BID INT, -- 종료 부스 식별자
    Finish_BName VARCHAR(50), -- 종료 부스 이름
    TravelDate DATE, -- 여행 날짜
    BorrowTime TIME, -- 여행 시작 시간
    UsedTime TIME, -- 사용 시간
    UsedDistance DECIMAL(10, 2), -- 이동 거리
    FOREIGN KEY (Start_BID, Start_BName) REFERENCES BoothInfo(BNo, BName), -- BoothInfo에 대한 외래 키
    FOREIGN KEY (Finish_BID, Finish_BName) REFERENCES BoothInfo(BNo, BName) -- BoothInfo에 대한 외래 키
);
*/

-- 전체 리스트 보기 / BoothInfo 확인용
SELECT *
FROM BOOTHINFO

-- 대여소 정보 조회
-- (혹시 몰라서) BNo로 찾기
SELECT BNo -- 실제로 검색하면 도로명을 띄워줌
FROM BOOTHINFO
WHERE ID = 000 -- 000 -> (input)

-- 부스 이름으로 찾기
SELECT BName -- BNo 를 띄워도 되긴 함
FROM BOOTHINFO
WHERE BName = station -- station = 입력값

-- 대여소 정보 조회
SELECT BID, RoadLocation, BLocation
FROM BoothMaster
WHERE Longitude NOT 0 AND Latitude NOT 0 
-- 위도, 경도 0 : 없는 대여소 제외 목적

-- BoothMaster 확인용
SELECT *
FROM BOOTHMASTER

-- Riding 확인용
SELECT *
FROM Riding

-- 회원가입
INSERT INTO userlist (UID, password, username, HP) -- HP = 핸드폰 번호
	-- input(UID, password, username, HP) -- <- 입력값


-- 즐겨찾기 추가
INSERT INTO favorites -- (BID, RoadLocation, BLocation, Latitude, Longitude) -- 위에서 favorite에 Latitude, Longitude 뺐으면 여기도 빼야 됨
FROM BoothMaster
WHERE BLocation = station -- station = 입력값

-- 즐겨찾기 제거 //원본 사이트에서는 제대로 동작하지 않음
DELETE FROM favorites
WHERE BLocation = station -- station = 입력값