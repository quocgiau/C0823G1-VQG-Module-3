-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
SELECT *
FROM `subject` sb
WHERE credit IN (SELECT MAX(credit)
				 FROM `subject` sb);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
SELECT sb.*, m.mark
FROM `subject` sb
JOIN mark m ON sb.id = m.sub_id
WHERE m.mark IN (SELECT MAX(mark)
				 FROM mark);
            
-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
SELECT s.*, AVG(m.mark) AS 'medium_score'
FROM student s
LEFT JOIN mark m ON s.id = m.student_id
GROUP BY s.id
ORDER BY 'medium_score' DESC;