INSERT INTO teacher (full_name, email, password_hash, biography, specialization)
VALUES 
    ('Євгеній Трочун', 'trochun.yevhenii@lll.kpi.ua', '(hashed_password)', 'Досвідчений розробник баз даних, 10+ років досвіду.', 'Data Engineering'),
    ('Марія Шевченко', 'm.shevchenko@еmail.com', '(hashed_password)', 'Креативна директорка у дизайн-агенції.', 'UI/UX Design'),
    ('Олександр Коваленко', 'o.kovalenko@email.com', '(hashed_password)', 'Backend-розробник, спеціалізується на Java.', 'Backend Development'),
    ('Вікторія Лисенко', 'v.lysenko@еmail.com', '(hashed_password)', 'Маркетологиня, працювала з великими брендами.', 'Digital Marketing'),
    ('Богдан Хмельницький', 'b.khmelnytsky@email.com', '(hashed_password)', 'Фахівець з української історії та культури.', 'History'),
    ('Наталя Сорока', 'n.soroka@email.com', '(hashed_password)', 'Експерт у сфері Machine Learning.', 'Data Science');

INSERT INTO categorie (name)
VALUES 
    ('Програмування'),
    ('Дизайн'),
    ('Маркетинг'),
    ('Історія');

INSERT INTO student (full_name, email, password_hash)
VALUES
    ('Іван Петренко', 'ivan.p@еmail.com', '(hashed_password)'),
    ('Олена Іванова', 'olena.i@еmail.com', '(hashed_password)'),
    ('Максим Сидоренко', 'max.s@еmail.com', '(hashed_password)'),
    ('Анна Мельник', 'anna.m@еmail.com', '(hashed_password)'),
    ('Петро Касяненко', 'p.kasyanenko@email.com', '(hashed_password)'),
    ('Софія Залізняк', 's.zalizniak@email.com', '(hashed_password)'),
    ('Андрій Лисенко', 'a.lysenko@email.com', '(hashed_password)'),
    ('Марина Ковальчук', 'm.kovalchuk@email.com', '(hashed_password)');

INSERT INTO course (teacher_id, category_id, title, description, price)
VALUES
    (1, 1, 'Вступ до SQL', 'Повний курс по SQL з нуля.', 1500.00),
    (1, 1, 'Основи Python', 'Python для початківців.', 1800.00),
    (2, 2, 'UI/UX Дизайн: Базовий', 'Створення сучасних інтерфейсів.', 2200.00),
    (3, 1, 'Java Advanced', 'Глибоке занурення в Java.', 3500.00),
    (4, 3, 'SMM для бізнесу', 'Як просувати бренд в соцмережах.', 1200.00),
    (5, 1, 'Machine Learning: Базовий', 'Основи ML з Python.', 4000.00),
    (4, 3, 'Google Ads: Практика', 'Налаштування рекламних кампаній.', 1700.00);

INSERT INTO module (course_id, title, sequence_order)
VALUES
    (1, 'Модуль 1: Основи SQL та CRUD', 1),
    (1, 'Модуль 2: Складні запити', 2);

INSERT INTO lesson (module_id, title, content, sequence_order)
VALUES
    (1, 'ER-діаграми та налаштування середовища', 'Топовий кантєнтік)))', 1),
    (1, 'Таблиці, рядки та типи даних', 'Топовий кантєнтік)))', 2),
    (1, 'SQL частина 1 - CRUD операції', 'Топовий кантєнтік)))', 3),
    (2, 'SQL частина 2 - JOIN та операції над множинами', 'Топовий кантєнтік)))', 1),
    (2, 'Агрегація, групування та віконні функції', 'Топовий кантєнтік)))', 2),
    (2, 'Підзапити та CTE', 'Топовий кантєнтік)))', 3);

INSERT INTO module (course_id, title, sequence_order)
VALUES
    (2, 'Модуль 1: Встановлення', 1);
INSERT INTO lesson (module_id, title, content, sequence_order)
VALUES
    (3, 'Урок 1: Python та VSCode', 'Кантєнтік', 1);

INSERT INTO enrollment (student_id, course_id, status)
VALUES
    (1, 1, 'active'),
    (1, 2, 'active'),
    (1, 3, 'refunded'),
    (2, 1, 'completed'),
    (2, 2, 'refunded'),
    (2, 3, 'active'),
    (3, 1, 'active'),
    (3, 2, 'active'),
    (3, 4, 'active'),
    (4, 2, 'completed'),
    (4, 3, 'completed'),
    (5, 6, 'completed'),
    (6, 6, 'active'),
    (7, 6, 'active'),
    (1, 6, 'refunded'),
    (5, 7, 'active'),
    (6, 7, 'completed'),
    (8, 1, 'active'),
    (8, 2, 'active'),
    (8, 4, 'active');