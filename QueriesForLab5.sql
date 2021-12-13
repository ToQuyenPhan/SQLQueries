create database LAB5
use LAB5
--Bảng 1: Nhân Viên
create table NHANVIEN(HONV nvarchar(10),
TENLOT nvarchar(10),
TEN nvarchar(10),
MANV decimal(18,0) primary key,
NGSINH date,
DCHI nvarchar(50), 
PHAI nvarchar(10),
LUONG decimal(18,0),
MA_NQL decimal(18,0),
PHG int)
alter table NHANVIEN
add foreign key (MA_NQL) references NHANVIEN(MANV)
alter table NHANVIEN 
add foreign key (PHG) references PHONGBAN(MAPHG)
--Bảng 2: Phòng Ban
create table PHONGBAN(TENPHG nvarchar(15),
MAPHG int primary key, 
TRPHG decimal(18,0),
NG_NHANCHUC date,
foreign key (TRPHG) references NHANVIEN(MANV))
--Bảng 3: Bảng DIADIEM_PHG
create table DIADIEM_PHG(MAPHG int not null,
DIADIEM nvarchar(10) not null,
foreign key (MAPHG) references PHONGBAN(MAPHG))
--Bảng 4: Thân Nhân
create table THANNHAN(MA_NVIEN decimal(18,0) not null,
TENTN nvarchar(10) primary key,
PHAI nvarchar(10),
NGSINH date,
QUANHE nvarchar(10),
foreign key (MA_NVIEN) references NHANVIEN(MANV))
--Bảng 5: Bảng DEAN
create table DEAN(TENDA nvarchar(50),
MADA int primary key,
DDIEM_DA nvarchar(10),
PHONG int,
foreign key (PHONG) references PHONGBAN(MAPHG))
--Bảng 6: Bảng Phân Công
create table PHANCONG(MA_NVIEN decimal(18,0) not null,
SODA int not null,
THOIGIAN decimal(18,1),
foreign key (MA_NVIEN) references NHANVIEN(MANV),
foreign key (SODA) references DEAN(MADA))
--Chèn dữ liệu
--Bảng Nhân Viên
insert into NHANVIEN values('Dinh', 'Ba', 'Tien', 123456789, convert(datetime, '09/01/1955', 103),
'731 Tran Hung Dao, Q1, TPHCM', 'Nam', 30000, 333445555, 5)
insert into NHANVIEN values('Nguyen', 'Thanh', 'Tung', 333445555, convert(datetime, '08/12/1945', 103),
'638 Nguyen Van Cu, Q5, TPHCM', 'Nam', 40000, 888665555, 5)
insert into NHANVIEN values('Bui', 'Thuy', 'Vu', 999887777, convert(datetime, '19/07/1958', 103),
'332 Nguyen Thai Hoc, Q1, TPHCM', 'Nam', 25000, 987654321, 4)
insert into NHANVIEN values('Le', 'Thi', 'Nhan', 987654321, convert(datetime, '20/06/1931', 103),
'291 Ho Van Hue, QPN, TPHCM', 'Nu', 43000, 888665555, 4)
insert into NHANVIEN values('Nguyen', 'Manh', 'Hung', 666884444, convert(datetime, '15/09/1952', 103),
'975 Bia Ria, Vung Tau', 'Nam', 38000, 333445555, 5)
insert into NHANVIEN values('Tran', 'Thanh', 'Tam', 453453453, convert(datetime, '31/07/1962', 103),
'543 Mai Thi Luu, Q1, TPHCM', 'Nam', 25000, 333445555, 5)
insert into NHANVIEN values('Tran', 'Hong', 'Quan', 987987987, convert(datetime, '23/03/1959', 103),
'980 Le Hong Phong, Q10, TPHCM', 'Nam', 25000, 987654321, 4)
insert into NHANVIEN values('Vuong', 'Ngoc', 'Quyen', 888665555, convert(datetime, '10/10/1927', 103),
'450 Trung Vuong, Ha Noi', 'Nu', 55000, null, 1)
--Bảng Phòng Ban
insert into PHONGBAN values('Nghien cuu', 5, 333445555, convert(datetime, '25/05/1978', 103))
insert into PHONGBAN values('Dieu hanh', 4, 987987987, convert(datetime, '01/01/1985', 103))
insert into PHONGBAN values('Quan ly', 1, 888665555, convert(datetime, '19/06/1971', 103))
--Bảng Địa điểm phòng ban
insert into DIADIEM_PHG values( 1, 'TP HCM')
insert into DIADIEM_PHG values( 4, 'HA NOI')
insert into DIADIEM_PHG values( 5, 'VUNG TAU')
insert into DIADIEM_PHG values( 5, 'NHA TRANG')
insert into DIADIEM_PHG values( 5, 'TP HCM')
--Bảng Thân Nhân
insert into THANNHAN values( 333445555, 'Quang', 'Nu', convert(datetime, '05/04/1976', 103), 'Con gai')
insert into THANNHAN values( 333445555, 'Khang', 'Nam', convert(datetime, '25/10/1973', 103), 'Con trai')
insert into THANNHAN values( 333445555, 'Duong', 'Nu', convert(datetime, '03/05/1948', 103), 'Vo chong')
insert into THANNHAN values( 987654321, 'Dang', 'Nam', convert(datetime, '29/02/1932', 103), 'Vo chong')
insert into THANNHAN values( 123456789, 'Duy', 'Nam', convert(datetime, '01/01/1978', 103), 'Con trai')
insert into THANNHAN values( 123456789, 'Chau', 'Nu', convert(datetime, '31/12/1978', 103), 'Con gai')
--Bảng DEAN
insert into DEAN values('San Pham X', 1, 'Vung Tau', 5)
insert into DEAN values('San Pham Y', 2, 'Nha Trang', 5)
insert into DEAN values('San Pham Z', 3, 'TP HCM', 5)
insert into DEAN values('Tin hoc hoa', 10, 'HA NOI', 4)
insert into DEAN values('Cap quang', 20, 'TP HCM', 1)
insert into DEAN values('Dao tao', 30, 'HA NOI', 4)
--Bảng Phân Công
insert into PHANCONG values(123456789, 1, 32.5)
insert into PHANCONG values(123456789, 2, 7.5)
insert into PHANCONG values(666884444, 3, 40.0)
insert into PHANCONG values(453453453, 1, 20.0)
insert into PHANCONG values(453453453, 2, 20.0)
insert into PHANCONG values(333445555, 3, 10.0)
insert into PHANCONG values(333445555, 10, 10.0)
insert into PHANCONG values(333445555, 20, 10.0)
insert into PHANCONG values(999887777, 30, 30.0)
insert into PHANCONG values(999887777, 10, 10.0)
insert into PHANCONG values(987987987, 10, 35.0)
insert into PHANCONG values(987987987, 30, 5.0)
insert into PHANCONG values(987654321, 30, 20.0)
insert into PHANCONG values(987654321, 20, 15.0)
insert into PHANCONG values(888665555, 20, null)
--Tạo stored procedure
--1. Liệt kê danh sách nhân viên có mức lương lớn hơn giá trị tham số truyền vào.
create procedure SP_1
@PLuong decimal
as
	select * from NHANVIEN where LUONG > @PLuong;
go

exec SP_1 25000;
go
--2. Liệt kê thông tin về nhân viên (mã nhân viên, tên, ngày vào công ty, mã người quản lý, 
-- tên người quản lý) được thuê từ ngày trong khoảng s đến f, trong đó s và f là tham số truyền vào.
create procedure SP_2
@PS date,
@PF date
as
	select n.MANV, n.TEN, NG_NHANCHUC, n.MA_NQL, a.TEN
	from PHONGBAN p join NHANVIEN n on p.TRPHG=n.MANV left join NHANVIEN a on n.MA_NQL=a.MANV
	where NG_NHANCHUC >= @PS and NG_NHANCHUC <= @PF;
go

exec SP_2 '1975-01-01', '1984-01-01';
go
--3. Liệt kê danh sách nhân viên làm việc cho một phòng nào đó. Mã phòng là tham số truyền vào. 
create procedure SP_3
@PPHG int
as
	select * from NHANVIEN
	where PHG = @PPHG
go

exec SP_3 4;
go
--4. Liệt kê danh sách nhân viên không có người quản lý.
create procedure SP_4
as
	select * from NHANVIEN
	where MA_NQL is null
go

exec SP_4;
go
--5. Liệt kê danh sách nhân viên, khoảng thời gian đã làm việc, 
-- tính theo tháng mà nhân viên đã làm việc cho công ty tính đến nay.
create procedure SP_5
as
	select n.*, datediff(month, NG_NHANCHUC, CURRENT_TIMESTAMP) as 'TG'
	from PHONGBAN p join NHANVIEN n on p.TRPHG=n.MANV
go

exec SP_5;
go
--6. Liệt kê danh sách nhân viên, mã phòng, 
--tên phòng của những nhân viên làm việc tại một thành phố nào đó. 
--Tên thành phố là tham số truyền vào.
create procedure SP_6
@PDIADIEM nvarchar(10)
as
	select distinct HONV, TENLOT, TEN, MANV, n.PHG, TENPHG
	from NHANVIEN n join DIADIEM_PHG d on n.PHG=d.MAPHG join PHONGBAN p on n.PHG=p.MAPHG
	where DIADIEM=@PDIADIEM
go

exec SP_6 'VUNG TAU';
go
--7. Liệt kê danh sách các phòng ban, thông tin gồm: mã phòng, tên phòng, số lượng nhân viên.
create procedure SP_7
as
	select MAPHG, TENPHG, count(*) as 'SL'
	from NHANVIEN n, PHONGBAN p
	where n.PHG =p.MAPHG
	group by MAPHG, TENPHG
go

exec SP_7;
go
--8. Liệt kê danh sách nhân viên (mã nhân viên, tên, ngày vào công ty, lương) 
--của những nhân viên có mức lương cao hơn mức lương trung bình của phòng mà họ làm việc).
create procedure SP_8
as
	select MANV, TEN, NG_NHANCHUC, LUONG
	from NHANVIEN n join PHONGBAN p on n.MANV=p.TRPHG
	where LUONG > (select AVG(LUONG) from NHANVIEN)
go

exec SP_8;
go
--9. Liệt kê thông tin n nhân viên có mức lương cao nhất. n là tham số truyền vào.
create procedure SP_9
as
	select * from NHANVIEN n 
	where LUONG = (select MAX(LUONG) from NHANVIEN)
go

exec SP_9;
go
--10. Đối với các nhân viên làm việc ở thành phố a, tăng lương mỗi người 10%. a là tham số truyền vào.
create procedure SP_10
@PDIADIEM nvarchar(10)
as
	update NHANVIEN set LUONG=LUONG+LUONG*10/100
	where PHG in (select PHG 
	from NHANVIEN n join DIADIEM_PHG d on n.PHG= d.MAPHG
	where DIADIEM=@PDIADIEM)
go

exec SP_10 'HA NOI';
go
--11. Xóa toàn bộ các phòng ban không có nhân viên nào. 
create procedure SP_11
as
	delete from PHONGBAN
	where MAPHG  = (select MAPHG
	from PHONGBAN p left join NHANVIEN n on p.MAPHG=n.PHG
	group by MAPHG having count(PHG) = 0)

go

exec SP_11;
go
--Các trigger
--1. Mức lương trung bình của nhân viên trong một phòng ban nào đó không vượt quá 50000
create trigger TR_1 on NHANVIEN
after insert, update
as
	declare @vLUONG decimal
	select @vLUONG=LUONG from inserted
	if @vLUONG > 50000
		print 'Lương lon hơn 50000'
go
--test
insert into NHANVIEN values('Dinh', 'Ba', 'Tien', 999999999, convert(datetime, '09/01/1955', 103),
'731 Tran Hung Dao, Q1, TPHCM', 'Nam', 55000, 333445555, 5)
--2. Mức lương của trưởng phòng không bé hơn lương của bất cứ nhân viên nào trong phòng.
create trigger TR_2 on NHANVIEN
after insert, update
as
	declare @vLUONG decimal, @vLLN decimal, @vMANV decimal
	select @vLUONG=LUONG from inserted
	select @vMANV=MANV from inserted
	select @vLLN = (select max(LUONG) from NHANVIEN where MANV<>@vMANV
	and PHG = (select PHG from NHANVIEN where MANV=@vMANV) group by PHG)
	if exists (select MANV from inserted
	where MANV in (select MANV from NHANVIEN n, PHONGBAN p where n.MANV=p.TRPHG))
	begin
		if @vLUONG < @vLLN
		begin
			print 'Luong truong phong khong the nho hon luong nhan vien'
			rollback transaction
		end
	end
go
--test
update NHANVIEN set LUONG = 30000 where MANV = 333445555
--3. Mức lương trung bình của nhân viên ở TPHCM và Hà Nội chênh lệch không quá 10000
create trigger TR_3 on NHANVIEN
after insert, update
as
	declare @vTPHCM decimal, @vHANOI decimal, @vMes nvarchar(50)
	select @vMes = 'Luong tb khong chenh lenh qua 10000'
	select @vTPHCM = (select avg(LUONG) from NHANVIEN n 
	join DIADIEM_PHG d on n.PHG=d.MAPHG where DIADIEM = 'TP HCM')
	select @vHANOI = (select avg(LUONG) from NHANVIEN n 
	join DIADIEM_PHG d on n.PHG=d.MAPHG where DIADIEM = 'HA NOI')
	if @vTPHCM > @vHANOI
	begin
		if @vTPHCM - @vHANOI > 10000
		begin
			print @vMes
			rollback transaction
		end
	end
	else
		if @vHANOI - @vTPHCM > 10000
		begin
			print @vMes
			rollback transaction
		end
go
update NHANVIEN set LUONG = 0 where MANV = 333445555
update NHANVIEN set LUONG = 0 where MANV = 123456789
update NHANVIEN set LUONG = 0 where MANV = 666884444
--4. Trong công ty không có quá 5 nhân viên có quan hệ liên quan tới nhau (cùng gia đình).
create trigger TR_4 on THANNHAN
after insert, update
as
	if exists (select MA_NVIEN from inserted 
	where MA_NVIEN in (select MA_NVIEN from THANNHAN group by MA_NVIEN having count(*) > 5))
	begin
		print 'Nhan vien da co 5 than nhan'
		rollback transaction
	end
go
--test
insert into THANNHAN(MA_NVIEN, TENTN) values(333445555, 'An')
insert into THANNHAN(MA_NVIEN, TENTN) values(333445555, 'Binh')
insert into THANNHAN(MA_NVIEN, TENTN) values(333445555, 'Canh')
--5. Số lượng nhân viên nam và nữ trong công ty chênh lệch không quá 10%
create trigger TR_5 on NHANVIEN
after insert, update
as
	declare @vTONGNV int, @vTONGNAM int, @vTONGNU int, @vMes nvarchar(50)
	select @vMes = 'So luong nam nu khong chenh lech qua 10%'
	select @vTONGNV = (select count(*) from NHANVIEN)
	select @vTONGNAM = (select count(*) from NHANVIEN where PHAI = 'Nam')
	select @vTONGNU = (select count(*) from NHANVIEN where PHAI = 'Nu')
	if @vTONGNAM > @vTONGNU
	begin
		if @vTONGNAM*100/@vTONGNV - @vTONGNU*100/@vTONGNV > 10
		begin
			print @vMes
			rollback transaction
		end
	end
	else
		if @vTONGNU*100/@vTONGNV - @vTONGNAM*100/@vTONGNV > 10
		begin
			print @vMes
			rollback transaction
		end
go
--test
insert into NHANVIEN values('Dinh', 'Ba', 'Tien', 999999999, convert(datetime, '09/01/1955', 103),
'731 Tran Hung Dao, Q1, TPHCM', 'Nam', 30000, null, 5) 

if OBJECT_ID ('Tr_2', 'TR') is not null
drop trigger Tr_2
go
delete from THANNHAN
where TENTN = 'Binh'
select * from NHANVIEN