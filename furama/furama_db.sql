CREATE DATABASE IF NOT EXISTS furama_db;
USE furama_db;

CREATE TABLE vi_tri (
    ma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ten VARCHAR(45)
);

CREATE TABLE trinh_do (
    ma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ten VARCHAR(45)
);

CREATE TABLE bo_phan (
    ma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ten VARCHAR(45)
);

CREATE TABLE nhan_vien (
    ma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ho_va_ten VARCHAR(45),
    ngay_sinh DATE,
    cccd VARCHAR(45),
    luong DOUBLE,
    sdt VARCHAR(15),
    email VARCHAR(45),
    dia_chi VARCHAR(50),
    ma_vi_tri INT NOT NULL,
    ma_trinh_do INT NOT NULL,
    ma_bo_phan INT NOT NULL,
    FOREIGN KEY (ma_vi_tri)
        REFERENCES vi_tri (ma),
    FOREIGN KEY (ma_trinh_do)
        REFERENCES trinh_do (ma),
    FOREIGN KEY (ma_bo_phan)
        REFERENCES bo_phan (ma)
);

CREATE TABLE loai_khach (
    ma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ten VARCHAR(45)
);

CREATE TABLE khach_hang (
    ma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ho_va_ten VARCHAR(45),
    ngay_sinh DATE,
    gioi_tinh BIT(1),
    cccd VARCHAR(45),
    sdt VARCHAR(15),
    email VARCHAR(45),
    dia_chi VARCHAR(50),
    ma_loai_khach INT NOT NULL,
    FOREIGN KEY (ma_loai_khach)
        REFERENCES loai_khach (ma)
);

CREATE TABLE loai_dich_vu (
    ma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ten VARCHAR(45)
);

CREATE TABLE kieu_thue (
    ma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ten VARCHAR(45)
);

CREATE TABLE dich_vu (
    ma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ten VARCHAR(45),
    dien_tich INT,
    chi_phi_thue DOUBLE,
    so_nguoi_toi_da INT,
    tieu_chuan_phong VARCHAR(45),
    mo_ta_tien_nghi_khac VARCHAR(45),
    dien_tich_ho_boi DOUBLE,
    so_tang INT,
    dich_vu_mien_phi_di_kem TEXT,
    ma_loai_dich_vu INT NOT NULL,
    ma_kieu_thue INT NOT NULL,
    FOREIGN KEY (ma_loai_dich_vu)
        REFERENCES loai_dich_vu (ma),
    FOREIGN KEY (ma_kieu_thue)
        REFERENCES kieu_thue (ma)
);

CREATE TABLE dich_vu_di_kem (
    ma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ten VARCHAR(45),
    gia DOUBLE,
    don_vi VARCHAR(45),
    trang_thai VARCHAR(45)
);

CREATE TABLE hop_dong (
    ma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ngay_lam_hop_dong DATETIME,
    ngay_ket_thuc DATETIME,
    tien_dat_coc DOUBLE,
    ma_nhan_vien INT NOT NULL,
    ma_khach_hang INT NOT NULL,
    ma_dich_vu INT NOT NULL,
    FOREIGN KEY (ma_nhan_vien)
        REFERENCES nhan_vien (ma),
    FOREIGN KEY (ma_khach_hang)
        REFERENCES khach_hang (ma),
    FOREIGN KEY (ma_dich_vu)
        REFERENCES dich_vu (ma)
);

CREATE TABLE hop_dong_chi_tiet (
    ma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    so_luong INT NOT NULL,
    ma_hop_dong INT NOT NULL,
    ma_dich_vu_di_kem INT NOT NULL,
    FOREIGN KEY (ma_hop_dong)
        REFERENCES hop_dong (ma),
    FOREIGN KEY (ma_dich_vu_di_kem)
        REFERENCES dich_vu_di_kem (ma)
);