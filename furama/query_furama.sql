 -- 2. Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.
 SELECT 
    *
FROM
    nhan_vien
WHERE
    SUBSTRING_INDEX(nhan_vien.ho_va_ten, ' ', 1) LIKE 'H%'
        OR SUBSTRING_INDEX(nhan_vien.ho_va_ten, ' ', 1) LIKE 'T%'
        OR SUBSTRING_INDEX(nhan_vien.ho_va_ten, ' ', 1) LIKE 'K%'
        AND CHAR_LENGTH(nhan_vien.ho_va_ten) <= 15;
        
-- 3. Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
SELECT 
    khach_hang.ma, khach_hang.ho_va_ten
FROM
    khach_hang
WHERE
    DATEDIFF(CURDATE(), khach_hang.ngay_sinh) / 365 BETWEEN 18 AND 50
        AND khach_hang.dia_chi LIKE '%Đà Nẵng'
        OR khach_hang.dia_chi LIKE '%Quảng Trị';

-- 4. Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
SELECT 
    khach_hang.ma, khach_hang.ho_va_ten, COUNT(hop_dong.ma_khach_hang) AS 'so_lan_dat_phong'
FROM
    khach_hang
        JOIN
    loai_khach ON khach_hang.ma_loai_khach = loai_khach.ma
        AND khach_hang.ma_loai_khach = 1
        JOIN
    hop_dong ON loai_khach.ma = hop_dong.ma_khach_hang
GROUP BY hop_dong.ma_khach_hang
ORDER BY COUNT(hop_dong.ma_khach_hang);