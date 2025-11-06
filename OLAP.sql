-- Обчислити середній рівень завершення курсів за категоріями

SELECT
	cat.category_id,
    cat.name AS category_name,
    ROUND(AVG((e.status = 'completed')::INT) * 100, 2) AS avg_completion_percentag
FROM enrollment e
	INNER JOIN course c USING(course_id)
	INNER JOIN categorie cat USING(category_id)
WHERE c.is_deleted = FALSE AND e.status != 'refunded'
GROUP BY cat.category_id, cat.name
ORDER BY avg_completion_percentag DESC, cat.category_id ASC;


-- Знайти топ-5 викладачів за загальною кількістю зареєстрованих студентів 

SELECT
    t.full_name AS teacher_name,
    COUNT(DISTINCT e.student_id) AS total_students
FROM teacher t
	LEFT JOIN course c ON t.teacher_id = c.teacher_id AND c.is_deleted = FALSE 
	LEFT JOIN enrollment e ON c.course_id = e.course_id AND e.status != 'refunded'
WHERE t.is_deleted = FALSE
GROUP BY t.teacher_id, t.full_name
ORDER BY total_students DESC, teacher_name ASC
LIMIT 5;


-- Ранжувати курси за кількістю реєстрацій у межах кожної категорії (віконні функції)

SELECT
    cat.name AS category_name,
    c.title AS course_title,
    COUNT(e.student_id) AS total_enrollments,
    RANK() OVER (
        PARTITION BY cat.category_id
        ORDER BY COALESCE(COUNT(e.student_id), 0) DESC
    ) AS category_rank
FROM categorie cat 
	LEFT JOIN course c ON cat.category_id = c.category_id AND c.is_deleted = FALSE
	LEFT JOIN enrollment e ON c.course_id = e.course_id AND e.status != 'refunded'
WHERE cat.is_deleted = FALSE
GROUP BY cat.category_id, cat.name, c.course_id, c.title
ORDER BY category_name ASC, category_rank ASC;


-- Визначити студентів, які зареєструвалися на декілька курсів, але не завершили жодного (CTE)

WITH student_stats AS (
    SELECT
        e.student_id,
        COUNT(*) FILTER (WHERE e.status != 'refunded') AS total_active_enrollments,
        COUNT(*) FILTER (WHERE e.status = 'completed') AS completed_courses
    FROM enrollment e
    	INNER JOIN course c USING(course_id)
    WHERE c.is_deleted = FALSE
    GROUP BY e.student_id
)
SELECT
    s.full_name AS student_name,
    ss.total_active_enrollments
FROM student_stats ss
	INNER JOIN student s USING(student_id)
WHERE s.is_deleted = FALSE AND ss.total_active_enrollments >= 2 AND ss.completed_courses = 0
ORDER BY ss.total_active_enrollments DESC, s.full_name ASC;