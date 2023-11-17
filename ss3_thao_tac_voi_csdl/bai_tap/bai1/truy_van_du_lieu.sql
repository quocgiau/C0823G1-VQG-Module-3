-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
SELECT 
    *
FROM
    student
WHERE
    `name` LIKE 'H%';
    
-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
SELECT 
    *
FROM
    class
WHERE
    MONTH(`date`) = 12;
    
-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
SELECT 
    *
FROM
    `subject`
WHERE
    credit BETWEEN 3 AND 5;
    
-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
SET sql_safe_updates = 0;
UPDATE student 
SET 
    class_id = 2
WHERE
    `name` = 'Hung';
SET sql_safe_updates = 1;

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
SELECT 
    student.`name`, `subject`.`name`, mark.mark
FROM
    student
        JOIN
    mark ON student.id = mark.student_id
        JOIN
    `subject` ON `subject`.id = mark.sub_id
ORDER BY mark.mark DESC , student.`name` ASC;