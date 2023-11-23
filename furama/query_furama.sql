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
ORDER BY 'Thang';

-- 10. Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong,
--     ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).
SELECT 
    hd.ma,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    hd.tien_dat_coc,
    SUM(hdct.so_luong) AS 'so_luong_dich_vu_di_kem'
FROM hop_dong hd
LEFT JOIN hop_dong_chi_tiet hdct ON hd.ma = hdct.ma_hop_dong
LEFT JOIN dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma
GROUP BY (hd.ma);

-- 11. Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.
SELECT dvdk.ma, dvdk.ten
FROM dich_vu_di_kem dvdk
JOIN hop_dong_chi_tiet hct ON dvdk.ma = hct.ma_dich_vu_di_kem
JOIN hop_dong hd ON hct.ma_hop_dong = hd.ma
JOIN khach_hang kh ON hd.ma_khach_hang = kh.ma
JOIN loai_khach lk ON kh.ma_loai_khach = lk.ma
WHERE lk.ten = 'Diamond' 
   AND (kh.dia_chi LIKE '% Vinh' OR kh.dia_chi LIKE '% Quảng Ngãi');

-- 12. Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), ten_dich_vu, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), 
-- tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.
SELECT hd.ma AS ma_hop_dong, nv.ho_va_ten AS ho_ten_nhan_vien, kh.ho_va_ten AS ho_ten_khach_hang, kh.sdt, dv.ten AS ten_dich_vu, SUM(hct.so_luong) AS so_luong_dich_vu_di_kem, hd.tien_dat_coc
FROM hop_dong hd
JOIN nhan_vien nv ON hd.ma_nhan_vien = nv.ma
JOIN khach_hang kh ON hd.ma_khach_hang = kh.ma
JOIN dich_vu dv ON hd.ma_dich_vu = dv.ma
JOIN hop_dong_chi_tiet hct ON hd.ma = hct.ma_hop_dong
LEFT JOIN dich_vu_di_kem dvdk ON hct.ma_dich_vu_di_kem = dvdk.ma
WHERE YEAR(hd.ngay_lam_hop_dong) LIKE 2020 AND MONTH(hd.ngay_lam_hop_dong) >= 10
   AND NOT EXISTS (
      SELECT *
      FROM hop_dong hd2
      WHERE hd2.ma_khach_hang = hd.ma_khach_hang
         AND YEAR(hd2.ngay_lam_hop_dong) LIKE 2021 AND MONTH(hd2.ngay_lam_hop_dong) <= 6
   )
GROUP BY hd.ma;

-- 13. Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng. (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).
SELECT dvdk.ma AS ma_dich_vu_di_kem, dvdk.ten AS ten_dich_vu, COUNT(*) AS so_luong_dich_vu_di_kem
FROM dich_vu_di_kem dvdk
JOIN hop_dong_chi_tiet hdcn ON dvdk.ma = hdcn.ma_dich_vu_di_kem
GROUP BY dvdk.ma, dvdk.ten
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM dich_vu_di_kem dvdk2
    JOIN hop_dong_chi_tiet hdcn2 ON dvdk2.ma = hdcn2.ma_dich_vu_di_kem
    GROUP BY dvdk2.ma
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- 14. Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu,
--    ten_dich_vu_di_kem, so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).
SELECT hd.ma AS ma_hop_dong, ldv.ten AS ten_loai_dich_vu, dvdk.ten AS ten_dich_vu_di_kem, COUNT(dvdk.ma) AS so_lan_su_dung
FROM hop_dong hd
JOIN hop_dong_chi_tiet hct ON hd.ma = hct.ma_hop_dong
JOIN dich_vu_di_kem dvdk ON hct.ma_dich_vu_di_kem = dvdk.ma
JOIN loai_dich_vu ldv ON dvdk.ma = ldv.ma
GROUP BY hd.ma, ldv.ten, dvdk.ten
HAVING COUNT(dvdk.ma) = 1;

-- 15. Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, ten_bo_phan, so_dien_thoai, dia_chi mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.
SELECT nv.ma AS ma_nhan_vien, nv.ho_va_ten, td.ten AS ten_trinh_do, bp.ten AS ten_bo_phan, nv.sdt, nv.dia_chi
FROM nhan_vien nv
JOIN trinh_do td ON nv.ma_trinh_do = td.ma
JOIN bo_phan bp ON nv.ma_bo_phan = bp.ma
WHERE nv.ma IN (
    SELECT ma_nhan_vien
    FROM hop_dong
    WHERE ngay_lam_hop_dong BETWEEN '2020-01-01' AND '2021-12-31'
    GROUP BY ma_nhan_vien
    HAVING COUNT(*) <= 3
);

-- 16. Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.
DELETE FROM nhan_vien
WHERE ma NOT IN (
    SELECT ma_nhan_vien
    FROM hop_dong
    WHERE ngay_lam_hop_dong BETWEEN '2019-01-01' AND '2021-12-31'
);

-- 17. Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond, chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.
UPDATE khach_hang
SET ma_loai_khach = (
    SELECT ma
    FROM loai_khach
    WHERE ten = 'Diamond'
)
WHERE ma IN (
    SELECT kh.ma
    FROM khach_hang kh
    INNER JOIN hop_dong hd ON kh.ma = hd.ma_khach_hang
    WHERE kh.ma_loai_khach = (
        SELECT ma
        FROM loai_khach
        WHERE ten = 'Platinum'
    )
    AND YEAR(hd.ngay_lam_hop_dong) = 2021
    AND hd.tien_dat_coc > 10000000
);

-- 18. Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).
DELETE FROM khach_hang
WHERE ma IN (
    SELECT kh.ma
    FROM khach_hang kh
    INNER JOIN hop_dong hd ON kh.ma = hd.ma_khach_hang
    WHERE YEAR(hd.ngay_lam_hop_dong) < 2021
);

-- 19. Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.
UPDATE dich_vu_di_kem
SET gia = gia * 2
WHERE ma IN (
    SELECT ma_dich_vu_di_kem
    FROM hop_dong_chi_tiet
    JOIN hop_dong ON hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma
    WHERE YEAR(hop_dong.ngay_lam_hop_dong) = 2020
    GROUP BY ma_dich_vu_di_kem
    HAVING COUNT(*) > 10
);

-- 20. Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi.
SELECT ma, ho_va_ten, email, sdt, ngay_sinh, dia_chi
FROM nhan_vien
UNION
SELECT ma, ho_va_ten, email, sdt, ngay_sinh, dia_chi
FROM khach_hang;