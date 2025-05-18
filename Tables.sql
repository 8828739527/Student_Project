
-- Students Table
CREATE TABLE students (
    student_id     NUMBER PRIMARY KEY,
    student_name   VARCHAR2(100),
    dob            DATE,
    class          NUMBER,
    joining_date   DATE
);

-- Subjects Table
CREATE TABLE subjects (
    subject_id     NUMBER PRIMARY KEY,
    subject_name   VARCHAR2(100)
);

-- Marks Table
CREATE TABLE marks (
    mark_id         NUMBER PRIMARY KEY,
    student_id      NUMBER,
    subject_id      NUMBER,
    exam_date       DATE,
    marks_obtained  NUMBER,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- Audit Table
CREATE TABLE student_audit_log (
    audit_id    NUMBER PRIMARY KEY,
    student_id  NUMBER,
    action      VARCHAR2(50),
    action_date sysdate
);
