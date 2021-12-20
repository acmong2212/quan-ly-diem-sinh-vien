create database quanly_diem_sinhvien;

create table Lop(
MaLop int primary key,
TenLop varchar(50),
MaKhoa int,
foreign key (MaKhoa) references Khoa(MaKhoa)
);

create table Khoa(
MaKhoa int primary key,
TenKhoa varchar(50),
SoCBGD int
);

create table MonHoc(
MaMH int primary key,
TenMH varchar(50),
SoTiet int
);

create table SinhVien(
MaSV int primary key,
HoTen varchar(100),
Nu varchar (50),
NgaySinh date,
MaLop int,
foreign key (MaLop) references Lop(MaLop),
HocBong int,
Tinh varchar(50)
);

create table KetQua(
MaKQ int primary key,
MaSV int,
MaMH int,
DiemThi int,
foreign key (MaSV) references sinhvien(MaSV),
foreign key (MaMH) references monhoc(MaMH)
);

-- Câu 1: Liệt kê danh sách các lớp của khoa, thông tin cần Malop, TenLop, MaKhoa
select lop.* from lop;

-- Câu 2: Lập danh sách sinh viên gồm: MaSV, HoTen, HocBong
select sinhvien.MaSV, sinhvien.HoTen, sinhvien.HocBong from sinhvien;

-- Câu 3: Lập danh sách sinh viên có học bổng. Danh sách cần MaSV, Nu, HocBong
select sinhvien.MaSV, sinhvien.HoTen, sinhvien.Nu ,sinhvien.HocBong from sinhvien
where HocBong is not null;

-- Câu 5: Lập danh sách sinh viên có họ ‘Trần’
select * from sinhvien
where HoTen like 'Tran%';

-- Câu 6: Lập danh sách sinh viên nữ có học bổng
select sinhvien.MaSV, sinhvien.HoTen, sinhvien.Nu ,sinhvien.HocBong from sinhvien
where HocBong is not null and Nu = 'Nu';

-- Câu 7: Lập danh sách sinh viên nữ hoặc danh sách sinh viên có học bổng
select sinhvien.MaSV, sinhvien.HoTen, sinhvien.Nu, sinhvien.HocBong from sinhvien
where nu = 'nu';

-- Câu 8: Lập danh sách sinh viên có năm sinh từ 1978 đến 1985. Danh sách cần các thuộc tính của quan hệ SinhVien
select sinhvien.MaSV, sinhvien.HoTen, sinhvien.NgaySinh from sinhvien
where NgaySinh >= '1978-01-01' and NgaySinh <= '1985-12-31';

-- Câu 9: Liệt kê danh sách sinh viên được sắp xếp tăng dần theo MaSV
select * from sinhvien
order by MaSV;

-- Câu 10: Liệt kê danh sách sinh viên được sắp xếp giảm dần theo HocBong
select * from sinhvien
where HocBong is not null
order by HocBong desc;

-- Ví du 12: Lập danh sách sinh viên có học bổng của khoa CNTT. Thông tin cần: MaSV,
select MaSV, HoTen, khoa.TenKhoa, HocBong from sinhvien
join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.MaKhoa = khoa.MaKhoa
where khoa.TenKhoa = 'CNTT' and HocBong is not null;
 
-- Câu 14: Cho biết số sinh viên của mỗi lớp
select lop.TenLop, count(MaSV) as 'Tong sinh vien' from sinhvien
join lop on sinhvien.MaLop = lop.MaLop
group by lop.TenLop;

-- Câu 15: Cho biết số lượng sinh viên của mỗi khoa.
select khoa.TenKhoa, count(MaSV) as 'Tong sinh vien' from sinhvien
join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.MaKhoa = khoa.MaKhoa
group by khoa.TenKhoa;

-- Câu 16: Cho biết số lượng sinh viên nữ của mỗi khoa.
select khoa.TenKhoa, count(Nu) as 'Tong sinh vien nu' from sinhvien
join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.MaKhoa = khoa.MaKhoa
where Nu = 'nu'
group by khoa.TenKhoa;

-- Câu 17: Cho biết tổng tiền học bổng của mỗi lớp
select lop.TenLop, sum(HocBong) as 'Tong tien hoc bong' from sinhvien
join lop on sinhvien.MaLop = lop.MaLop
group by lop.TenLop;

-- Câu 18: Cho biết tổng số tiền học bổng của mỗi khoa
select khoa.TenKhoa, sum(HocBong) as 'Tong tien hoc bong' from sinhvien
join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.MaKhoa = khoa.MaKhoa
group by khoa.TenKhoa;

-- Câu 19: Lập danh sánh những khoa có nhiều hơn 4 sinh viên. Danh sách cần: MaKhoa, TenKhoa, Soluong
select khoa.MaKhoa, khoa.TenKhoa, count(MaSV) as 'SoLuong' from sinhvien
join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.MaKhoa = khoa.MaKhoa
group by khoa.TenKhoa
having count(MaSV) > 4;

-- Câu 20: Lập danh sánh những khoa có nhiều hơn 1 sinh viên nữ. Danh sách cần: MaKhoa, TenKhoa, Soluong
select khoa.MaKhoa, khoa.TenKhoa, count(Nu) as 'SoLuong' from sinhvien
join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.MaKhoa = khoa.MaKhoa
where sinhvien.nu = 'nu'
group by khoa.TenKhoa
having SoLuong > 1;

-- Câu 22: Lập danh sách sinh viên có học bổng cao nhất
select HoTen, HocBong as 'Hoc bong cao nhat' from sinhvien
where HocBong = (select max(HocBong) from sinhvien);

-- Câu 23: Lập danh sách sinh viên có điểm thi môn THMLN cao nhất
select HoTen, monhoc.TenMH, ketqua.DiemThi from sinhvien
join ketqua on sinhvien.MaSV = ketqua.MaSV join monhoc on ketqua.MaMH = monhoc.MaMH
where monhoc.TenMH = 'THMLN' and ketqua.DiemThi = (select max(DiemThi) from ketqua);

-- Câu 25: Cho biết những khoa nào có nhiều sinh viên nhất
select khoa.MaKhoa, khoa.TenKhoa, count(MaSV) as 'SoLuong' from sinhvien
join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.MaKhoa = khoa.MaKhoa
group by khoa.TenKhoa