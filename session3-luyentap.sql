create database  QUANLYBANHANG;

use QUANLYBANHANG;
create table Khach_Hang (
MA_KH int auto_increment primary key,
Ten_KH varchar(30) not null,
Diachi varchar(50),
Ngaysinh datetime,
So_Dt  varchar(15) unique
);
INSERT INTO Khach_Hang (Ten_KH, Diachi, Ngaysinh, So_Dt)
VALUES 
  ('Nguyen Van A', '123 ABC Street, XYZ City', '1990-01-15', '0901234567'),
  ('Tran Thi B', '456 DEF Street, ABC City', '1985-05-20', '0987654321'),
  ('Le Van C', '789 GHI Street, LMN City', '1995-09-10', '0123456789');


create table Nhan_vien (
MA_NV int auto_increment primary key,
Hoten varchar(30)  not null,
Gioitinh bit  not null,
diachi varchar(50)  not null,
Ngaysinh datetime  not null,
Dienthoai varchar(15) ,
Email Text,
Noisinh varchar(20)  not null,
NgayVaolam datetime
);
INSERT INTO Nhan_vien (Hoten, Gioitinh, diachi, Ngaysinh, Dienthoai, Email, Noisinh, NgayVaolam)
VALUES
  ('Nguyen Van A', 1, '123 ABC Street, XYZ City', '1990-01-15', '0901234567', 'emailA@example.com', 'Hanoi', '2020-01-01'),
  ('Tran Thi B', 0, '456 DEF Street, ABC City', '1985-05-20', '0987654321', 'emailB@example.com', 'Hue', '2019-11-10'),
  ('Le Van C', 1, '789 GHI Street, LMN City', '1995-09-10', '0123456789', NULL, 'Da Nang', NULL);

create table Nha_Cung_Cap (
MA_NCC int auto_increment primary key,
Ten_NCC varchar(30)  not null,
Diachi varchar(50)  not null,
DienThoai varchar(15)  not null,
Email varchar(255)  not null,
Website varchar(255)
);
INSERT INTO Nha_Cung_Cap (Ten_NCC, Diachi, DienThoai, Email, Website)
VALUES
  ('Công ty A', '123 ABC Street, XYZ City', '0901234567', 'emailA@example.com', 'www.companyA.com'),
  ('Công ty B', '456 DEF Street, ABC City', '0987654321', 'emailB@example.com', NULL),
  ('Công ty C', '789 GHI Street, LMN City', '0123456789', 'emailC@example.com', 'www.companyC.com');

create table Loai_SP (
MA_LSP int auto_increment primary key,
Ten_LSP varchar(255)  not null,
Ghichu varchar(255 ) not null
);
INSERT INTO Loai_SP (Ten_LSP, Ghichu)
VALUES
  ('Điện thoại', 'Loại sản phẩm điện thoại di động'),
  ('Laptop', 'Loại sản phẩm máy tính xách tay'),
  ('Máy tính bảng', 'Loại sản phẩm máy tính bảng');

create table San_Pham (
MA_SP int auto_increment primary key,
Ma_LSP int  ,
ten_SP varchar(100)  not null,
Donvitinh varchar(100)  not null,
ghichu varchar(255),
foreign key (Ma_LSP) references Loai_SP(MA_LSP)
);
INSERT INTO San_Pham (Ma_LSP, ten_SP, Donvitinh, ghichu)
VALUES
  (1, 'IPHONE 15', 'Cái', NULL),
  (1, 'Samsung s9', 'Cái', 'Điện thoại mới nhất'),
  (2, 'Laptop Acer Nitro 6', 'Cái', NULL),
  (2, 'Laptop Alienware MR15', 'Cái', 'Laptop cao cấp'),
  (3, 'Apple Pro 1080', 'Cái', 'Máy tính bảng giá rẻ');

create table Phieu_Nhap (
So_PN int auto_increment primary key,
Ma_NV int  not null,
Ma_NCC int  not null,
Ngaynhap datetime default now()  not null, 
ghichu varchar(255),
foreign key (Ma_NCC) references Nha_Cung_Cap(Ma_NCC),
foreign key (Ma_NV) references Nhan_vien(Ma_NV)
);
insert into Phieu_nhap(Ma_NV,Ma_NCC,Ngaynhap) values
(1,1,'2023-07-20'),(2,2,'2023-06-12'),(3,3,'2023-07-18');
CREATE TABLE CT_Phieu_Nhap (
    Ma_SP INT,
    So_PN INT,
    Soluong SMALLINT DEFAULT 0  not null,
    Gianhap DOUBLE CHECK (Gianhap >= 0) ,
    foreign key(So_PN) references Phieu_Nhap(So_PN),
    foreign key(Ma_SP) references San_Pham(Ma_SP)
);
-- Thêm phiếu nhập 1
INSERT INTO CT_Phieu_Nhap (Ma_SP, So_PN, Soluong, Gianhap)
VALUES
  (1, 1, 10, 100000), -- Sản phẩm 1
  (2, 1, 5, 50000);   -- Sản phẩm 2
  -- Thêm phiếu nhập 2
  INSERT INTO CT_Phieu_Nhap (Ma_SP, So_PN, Soluong, Gianhap)
VALUES
  (3, 2, 8, 80000),   -- Sản phẩm 3
  (4, 2, 12, 120000); -- Sản phẩm 4
  
create table Phieu_Xuat(
So_PX  INT AUTO_INCREMENT PRIMARY KEY,
MA_NV int ,
MA_KH int ,
NgayBan datetime default now()  not null,
ghichu varchar(255),
foreign key (MA_KH) references Khach_hang(MA_KH),
foreign key (MA_NV) references Nhan_Vien(MA_NV)
);
INSERT INTO Phieu_Xuat (MA_NV, MA_KH, NgayBan)
VALUES (1, 1, NOW()),(2, 2, NOW());
create table CT_Phieu_Xuat(
SO_PX int,
MA_SP int,
Soluong int  check (Soluong > 0) ,
Giaban double check (Giaban > 0),
foreign key(SO_PX) references Phieu_Xuat(SO_PX),
foreign key(MA_SP) references San_Pham(MA_SP)
);
-- Thêm chi tiết phiếu xuất 1
INSERT INTO CT_Phieu_Xuat (SO_PX, MA_SP, Soluong, Giaban)
VALUES
  (1, 1, 5, 150000),   
  (1, 2, 3, 200000),   
  (1, 3, 4, 180000);   

-- Thêm chi tiết phiếu xuất 2
INSERT INTO CT_Phieu_Xuat (SO_PX, MA_SP, Soluong, Giaban)
VALUES
  (2, 2, 8, 220000),   -- Sản phẩm 2
  (2, 3, 6, 190000),   -- Sản phẩm 3
  (2, 4, 5, 210000);   -- Sản phẩm 4
INSERT INTO Nhan_vien (Hoten, Gioitinh, diachi, Ngaysinh, Dienthoai, Email, Noisinh, NgayVaolam)
VALUES ('Tran Van D', 1, '456 XYZ Street, ABC City', '1992-08-25', '0909876543', 'emailD@example.com', 'Hanoi', '2023-07-20');

-- -----------------------------------------------------------

-- Bài 4: Dùng lệnh UPDATE cập nhật dữ liệu các bảng
update Khach_Hang set So_DT = "0999999999" where MA_KH = 1;
update Nhan_Vien set Diachi ="CM" where MA_NV = 2;
-- Bài 5: Dùng lệnh DELETE xóa dữ liệu các bảng
delete from Nhan_Vien where MA_NV = 4;
delete from San_pham where MA_SP = 3;
-- Bài 6: Dùng lệnh SELECT lấy dữ liệu từ các bảng
-- ------------------------1-----------------------------------
SELECT 
  MA_NV,Hoten,
  CASE WHEN Gioitinh = 1 THEN 'Nam' ELSE 'Nữ' END as Gioitinh,
  Ngaysinh,  diachi,  Dienthoai,
  YEAR(NOW()) - YEAR(Ngaysinh) as Tuoi
FROM Nhan_vien
ORDER BY Tuoi;
-- ------------------------2-----------------------------------
SELECT 
  PN.So_PN as "Số phiếu nhập",
  NV.MA_NV as "Mã nhân viên",
  NV.Hoten as "Họ tên nhân viên",
  NCC.Ten_NCC as "Tên nhà cung cấp",
  PN.Ngaynhap as "Ngày Nhập",
  PN.ghichu as "Ghi chú"
FROM Phieu_Nhap PN
JOIN Nhan_vien NV ON PN.Ma_NV = NV.MA_NV
JOIN Nha_Cung_Cap NCC ON PN.Ma_NCC = NCC.MA_NCC
WHERE MONTH(PN.Ngaynhap) = 6 AND YEAR(PN.Ngaynhap) = 2023;
-- ------------------------3-----------------------------------
select * from San_Pham where donvitinh = "Cái";
-- ------------------------4-----------------------------------
SELECT 
  CTPN.So_PN as "Số phiếu nhập",
  SP.MA_SP as "Mã sản phẩm",
  SP.Ten_SP as "Tên sản phẩm",
 LSP.ten_LSP as "loại sản phẩm",
  SP.Donvitinh as "Đơn vị tính",
CTPN.Soluong as "Số lượng",
  CTPN.Gianhap as "Giá nhập",
  CTPN.Soluong *  CTPN.Gianhap as "Thành tiền"
FROM CT_phieu_nhap CTPN
join San_pham  SP on CTPN.Ma_SP = SP.Ma_SP
join Loai_sp LSP on SP.Ma_LSP = LSP.Ma_LSP
JOIN Phieu_Nhap PN ON CTPN.So_PN = PN.So_PN
WHERE MONTH(PN.Ngaynhap) = MONTH(NOW()) AND YEAR(PN.Ngaynhap) = YEAR(NOW());

-- ------------------------5-----------------------------------
SELECT 
NCC.Ma_NCC as "Mã nhà cung cấp",
NCC.ten_NCC as "Tên nhà cung cấp",
NCC.diachi as "Địa chỉ",
NCC.Dienthoai as "Số điện thoại",
NCC.email as "Email",
PN.So_Pn as "Số phiếu nhập",
PN.Ngaynhap as "Ngày nhập"
FROM Nha_Cung_Cap NCC
JOIN Phieu_nhap PN on NCC.MA_NCC =  PN.MA_NCC
where month(PN.NGayNhap) = month(now()) and year(PN.ngaynhap) = year(now()) 
ORDER BY PN.Ngaynhap;
-- ------------------------6-----------------------------------
select 
  PX.So_PX as "Số phiếu xuất",
  NV.MA_NV as "Mã nhân viên",
  NV.Hoten as "Nhân viên bán hàng",
  PX.NgayBan as "Ngày bán",
  SP.MA_SP as "Mã sản phẩm",
  SP.Ten_SP as "Tên sản phẩm",
  SP.Donvitinh as "Đơn vị tính",
  CTPX.Soluong as "Số lượng",
  CTPX.giaban as "Giá bán",
  CTPX.Soluong * CTPX.Giaban as "Doanh thu"
from CT_Phieu_Xuat CTPX
join Phieu_Xuat PX on CTPX.So_PX = PX.So_PX
join Nhan_vien NV on PX.Ma_NV = NV.MA_NV
join San_pham SP on CTPX.Ma_SP = SP.MA_SP
where month(PX.NgayBan) between 1 and 6 and year(PX.NgayBan) = 2023;
-- ------------------------7----------------------------------
select * from Khach_hang 
where month(ngaysinh) = month(now());
-- ------------------------8---------------------------------
SELECT DISTINCT
  PX.So_PX as "Số phiếu xuất",
  NV.MA_NV as "Mã nhân viên",
  NV.Hoten as "Nhân viên bán hàng",
  PX.NgayBan as "Ngày bán",
  SP.MA_SP as "Mã sản phẩm",
  SP.Ten_SP as "Tên sản phẩm",
  SP.Donvitinh as "Đơn vị tính",
  CTPX.Soluong as "Số lượng",
  CTPX.giaban as "Giá bán",
  CTPX.Soluong * CTPX.giaban as "Doanh thu"
FROM CT_Phieu_Xuat CTPX
JOIN Phieu_Xuat PX ON CTPX.So_PX = PX.So_PX
JOIN Nhan_vien NV ON PX.Ma_NV = NV.MA_NV
JOIN San_pham SP ON CTPX.Ma_SP = SP.MA_SP
WHERE PX.NgayBan BETWEEN '2023-07-15' AND '2023-08-15';
-- ------------------------9-------------------------------
SELECT 
  PX.So_PX as "Số phiếu xuất",
  PX.NgayBan as "Ngày bán",
  KH.MA_KH as "Mã khách hàng",
  KH.Ten_KH as "Tên khách hàng",
  SUM(CTPX.Soluong * CTPX.giaban) as "Trị giá"
FROM Phieu_Xuat PX
JOIN CT_Phieu_Xuat CTPX ON PX.So_PX = CTPX.So_PX
JOIN Khach_Hang KH ON PX.Ma_KH = KH.MA_KH
GROUP BY PX.So_PX, PX.NgayBan, KH.MA_KH, KH.Ten_KH;
-- ------------------------10------------------------------
SELECT 
  SUM(CTPX.Soluong) as "Tổng số lượng"
FROM CT_Phieu_Xuat CTPX
JOIN Phieu_Xuat PX ON CTPX.So_PX = PX.So_PX
JOIN San_pham SP ON CTPX.Ma_SP = SP.MA_SP
WHERE SP.Ten_SP LIKE '%Alienware%' AND PX.NgayBan BETWEEN '2023-07-01' AND '2023-08-1';
-- ------------------------11------------------------------
SELECT 
  SUM(CTPX.Soluong) as "Tổng số lượng"
FROM CT_Phieu_Xuat CTPX
JOIN Phieu_Xuat PX ON CTPX.So_PX = PX.So_PX
JOIN San_pham SP ON CTPX.Ma_SP = SP.MA_SP
WHERE SP.Ten_SP LIKE '%Alienware%' AND PX.NgayBan BETWEEN '2023-07-01' AND '2023-08-1';
