-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
SELECT 
    *
FROM
    student s
WHERE
    `name` LIKE 'H%';
    
-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
SELECT 
    *
FROM
    class c
WHERE
    MONTH(`date`) = 12;
    
-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
SELECT 
    *
FROM
    `subject` sb
WHERE
    credit BETWEEN 3 AND 5;
    
-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
SET sql_safe_updates = 0;
UPDATE student s
SET 
    class_id = 2
WHERE
    `name` = 'Hung';
SET sql_safe_updates = 1;

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
SELECT 
    s.`name`, sb.`name`, m.mark
FROM
    student s
        JOIN
    mark m ON s.id = m.student_id
        JOIN
    `subject` sb ON sb.id = m.sub_id
ORDER BY m.mark DESC , s.`name` ASC;