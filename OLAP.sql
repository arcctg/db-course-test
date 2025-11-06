CREATE TABLE IF NOT EXISTS teacher
(
    teacher_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    biography TEXT,
    specialization VARCHAR(100),
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS student
(
    student_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    registration_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS categorie
(
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS course
(
    course_id SERIAL PRIMARY KEY,
    teacher_id INT NOT NULL REFERENCES teacher(teacher_id),
    category_id INT NOT NULL REFERENCES categorie(category_id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price numeric(10, 2) NOT NULL CHECK (price >= 0),
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS module
(
    module_id SERIAL PRIMARY KEY,
    course_id INT NOT NULL REFERENCES course(course_id),
    title VARCHAR(255) NOT NULL,
    sequence_order SMALLINT NOT NULL CHECK (sequence_order > 0),
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE(course_id, sequence_order)
);

CREATE TABLE IF NOT EXISTS lesson
(
    lesson_id SERIAL PRIMARY KEY,
    module_id INT NOT NULL REFERENCES module(module_id),
    title VARCHAR(255) NOT NULL,
    content TEXT,
    sequence_order SMALLINT NOT NULL CHECK (sequence_order > 0),
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE(module_id, sequence_order)
);

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enrollment_status') THEN
        CREATE TYPE enrollment_status AS ENUM (
            'active',
            'completed',
            'refunded'
        );
    END IF;
END$$;

CREATE TABLE IF NOT EXISTS enrollment
(
    student_id INT NOT NULL REFERENCES student(student_id),
    course_id INT NOT NULL REFERENCES course(course_id),
    enrollment_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    status enrollment_status NOT NULL DEFAULT 'active',
    PRIMARY KEY (student_id, course_id)
);