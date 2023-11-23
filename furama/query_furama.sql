 -- 2. Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.
SELECT 
    *
FROM
    nhan_vien nv
WHERE
    ho_va_ten LIKE 'H%' OR ho_va_ten LIKE 'T%' OR ho_va_ten LIKE 'K%'
   AND LENGTH(ho_va_ten) <= 15;
-- 3. Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
SELECT 
    *
FROM
    khach_hang
WHERE
    DATEDIFF(CURDATE(), ngay_sinh) / 365 BETWEEN 18 AND 50
        AND dia_chi LIKE '%Đà Nẵng'
        OR dia_chi LIKE '%Quảng Trị';

-- 4. Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng.
--    Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
SELECT 
    kh.ma, kh.ho_va_ten, COUNT(hd.ma) AS 'so_lan_dat_phong'
FROM
    khach_hang kh
        JOIN
    hop_dong hd ON kh.ma = hd.ma_khach_hang
        JOIN
    loai_khach lk ON kh.ma_loai_khach = lk.ma
WHERE
    lk.ten = 'Diamond'
GROUP BY kh.ma
ORDER BY so_lan_dat_phong ASC;

-- 5. Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien 
--    (Với tổng tiền được tính theo công thức như sau: Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) 
--    cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra). 
SELECT 
    kh.ma AS 'ma_khach_hang',
    kh.ho_va_ten,
    lk.ten AS 'ten_loai_khach',
    hd.ma AS 'ma_hop_dong',
    dv.ten AS 'ten_dich_vu',
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    (dv.chi_phi_thue + hdct.so_luong * dvdk.gia) AS 'tong_tien'
FROM
    khach_hang kh
        LEFT JOIN
    loai_khach lk ON kh.ma_loai_khach = lk.ma
        LEFT JOIN
    hop_dong hd ON kh.ma = hd.ma_khach_hang
        LEFT JOIN
    dich_vu dv ON hd.ma_dich_vu = dv.ma
        LEFT JOIN
    hop_dong_chi_tiet hdct ON hd.ma = hdct.ma_hop_dong
        LEFT JOIN
    dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma
ORDER BY kh.ma;

-- 6. Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).
SELECT 
    dv.ma,
    dv.ten,
    dv.dien_tich,
    dv.chi_phi_thue,
    ldv.ten AS 'ten_loai_dich_vu'
FROM
    dich_vu dv
        JOIN
    loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma
WHERE
    dv.ma NOT IN (SELECT 
            ma_dich_vu
        FROM
            hop_dong
        WHERE
            MONTH(ngay_lam_hop_dong) IN (1 , 2, 3)
                AND YEAR(ngay_lam_hop_dong) = 2021);

-- 7. Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ đã từng được 
--    khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.
SELECT 
    dv.ma,
    dv.ten,
    dv.dien_tich,
    dv.so_nguoi_toi_da,
    dv.chi_phi_thue,
    ldv.ten AS 'ten_loai_dich_vu'
FROM
    dich_vu dv
        JOIN
    loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma
WHERE
    dv.ma IN (SELECT 
            ma_dich_vu
        FROM
            hop_dong
        WHERE
            YEAR(ngay_lam_hop_dong) = 2020)
        AND dv.ma NOT IN (SELECT 
            ma_dich_vu
        FROM
            hop_dong
        WHERE
            YEAR(ngay_lam_hop_dong) = 2021);

-- 8. Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
-- C1:
SELECT DISTINCT
    ho_va_ten
FROM
    khach_hang;
-- C2:
SELECT 
    ho_va_ten
FROM
    khach_hang
GROUP BY (ho_va_ten);
-- C3:
SELECT 
    ho_va_ten
FROM
    khach_hang kh1
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            khach_hang kh2
        WHERE
            kh1.ho_va_ten = kh2.ho_va_ten
                AND kh1.ma <> kh2.ma);
                
-- 9. Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
SELECT 
    MONTH(ngay_lam_hop_dong) AS 'Thang',
    COUNT(ma_khach_hang) AS 'so_luong_khach_hang'
FROM
    hop_dong
WHERE
    YEAR(ngay_lam_hop_dong) = 2021
GROUP BY MONTH(ngay_lam_hop_dong)
ORDER BY MONTH('Thang');

-- 10. Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong,
--     ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).
SELECT 
    hd.ma,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    hd.tien_dat_coc,
    SUM(hdct.so_luong) AS 'so_luong_dich_vu_di_kem'
FROM
    hop_dong hd
        LEFT JOIN
    hop_dong_chi_tiet hdct ON hd.ma = hdct.ma_hop_dong
        LEFT JOIN
    dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma
GROUP BY (hd.ma);



