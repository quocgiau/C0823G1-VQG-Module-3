-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
SELECT 
    *
FROM
    `subject`
WHERE
    credit IN (SELECT 
            MAX(credit)
        FROM
            `subject`);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
SELECT 
    `subject`.*, mark.mark
FROM
    `subject`
        JOIN
    mark ON `subject`.id = mark.sub_id
WHERE
    mark.mark IN (SELECT 
            MAX(mark.mark)
        FROM
            mark);
            
-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
SELECT 
    student.*, AVG(mark.mark) AS 'medium_score'
FROM
    student
        LEFT JOIN
    mark ON student.id = mark.student_id
GROUP BY student.id
ORDER BY 'medium_score' DESC;