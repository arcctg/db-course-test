-- 2 INSERT запити 

-- додати студента
INSERT INTO student (full_name, email, password_hash)
VALUES 
    ('Василь Левченко', 'v.levchenko@email.com', '(hashed_password)');

-- перевірка
SELECT * FROM student WHERE full_name = 'Василь Левченко';


-- додати курс
INSERT INTO course (teacher_id, category_id, title, description, price)
VALUES 
    (2, 2, 'Дизайн-системи в Figma', 'Практичний курс по створенню дизайн-систем.', 2800.00);

-- перевірка
SELECT * FROM course WHERE title = 'Дизайн-системи в Figma';


-- 2 UPDATE запити

-- оновлення біографії викладача
-- перевірка
SELECT teacher_id, full_name, biography 
FROM teacher 
WHERE full_name = 'Євгеній Трочун';

-- оновлення
UPDATE teacher
SET biography = 'Автор курсу "Вступ до SQL". Досвід 12+ років у Data Engineering.'
WHERE full_name = 'Євгеній Трочун';

-- перевірка
SELECT teacher_id, full_name, biography 
FROM teacher 
WHERE full_name = 'Євгеній Трочун';


-- оновлення ціни на курс
-- перевірка
SELECT course_id, title, price 
FROM course 
WHERE title = 'Java Advanced';

-- оновлення
UPDATE course
SET price = 3250.00
WHERE title = 'Java Advanced';

-- перевірка
SELECT course_id, title, price 
FROM course 
WHERE title = 'Java Advanced';


-- 2 DELETE запити (soft delete)

-- soft delete студента
-- перевірка
SELECT student_id, full_name, is_deleted 
FROM student 
WHERE full_name = 'Максим Сидоренко';

-- виконуємо soft delete
UPDATE student
SET is_deleted = TRUE
WHERE full_name = 'Максим Сидоренко';

-- перевірка
SELECT student_id, full_name, is_deleted 
FROM student 
WHERE full_name = 'Максим Сидоренко';


-- soft delete курсу
-- перевірка
SELECT course_id, title, is_deleted 
FROM course 
WHERE title = 'Java Advanced';

-- виконуємо soft delete
UPDATE course
SET is_deleted = TRUE
WHERE title = 'Java Advanced';

-- перевірка
SELECT course_id, title, is_deleted 
FROM course 
WHERE title = 'Java Advanced';


-- 2 DELETE запити (hard delete якщо саме його треба показати)

-- hard delete викладача
-- перевірка що існує
SELECT * FROM teacher
WHERE full_name = 'Наталя Сорока';

-- перевірка на залежності
SELECT * FROM course
WHERE teacher_id = 6;

-- виконання delete
DELETE FROM teacher
WHERE teacher_id = 6;

-- перевірка
SELECT * FROM teacher
WHERE full_name = 'Наталя Сорока';


-- hard delete уроку
-- перевірка що існує
SELECT * FROM lesson
WHERE lesson_id = 1;

-- виконання delete
DELETE FROM lesson
WHERE lesson_id = 1;

-- перевірка
SELECT * FROM lesson
WHERE lesson_id = 1;


-- 2 прості SELECT

-- знайти всі курси що викладаються викладачем 'Євгеній Трочун'
SELECT 
    t.full_name AS teacher_name, 
    c.title AS course_title, 
    c.price
FROM course c
	INNER JOIN teacher t USING(teacher_id)
WHERE t.full_name = 'Євгеній Трочун' AND c.is_deleted = FALSE;


-- знайти всіх студентів, що відвідували конкретний курс 'Вступ до SQL'
SELECT 
    c.title AS course_title, 
    s.full_name AS student_name, 
    e.status AS enrollment_status
FROM enrollment e
	INNER JOIN student s USING(student_id)
	INNER JOIN course c USING(course_id)
WHERE c.title = 'Вступ до SQL' AND s.is_deleted = FALSE AND e.status != 'refunded';