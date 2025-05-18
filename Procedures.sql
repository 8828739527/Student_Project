create or replace PROCEDURE prc_add_student (
    instudid   NUMBER,
    instudname VARCHAR2,
    indob      DATE,
    inclass    NUMBER,
    injndt     DATE
) AS
    v_count NUMBER;
BEGIN
    SELECT
        COUNT(1)
    INTO v_count
    FROM
        students
    WHERE
        student_id = instudid;

    IF v_count = 0 THEN
        INSERT INTO students VALUES (
            instudid,
            instudname,
            indob,
            inclass,
            injndt
        );

        dbms_output.put_line('Student Record Inserted Successfully !!');
    ELSE
        dbms_output.put_line('Student Already Existing');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlcode
                             || ' '
                             || sqlerrm);
END prc_add_student;

CREATE OR REPLACE PROCEDURE prc_inst_marks (
    inmrkid  NUMBER,
    instudid NUMBER,
    insubjid NUMBER,
    inexmdt  DATE,
    inmrkobt NUMBER
) AS
    v_count NUMBER;
BEGIN
    SELECT
        COUNT(1)
    INTO v_count
    FROM
        marks
    WHERE
        mark_id = inmrkid;

    IF v_count = 0 THEN
        INSERT INTO marks VALUES (
            inmrkid,
            instudid,
            insubjid,
            inexmdt,
            inmrkobt
        );

        dbms_output.put_line('Marks Inserted Successfully !!');
    ELSE
        dbms_output.put_line(inmrkid || ' is already existing in the system');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlcode
                             || ' '
                             || sqlerrm);
END prc_inst_marks;

CREATE OR REPLACE PROCEDURE prc_updt_stud_mark (
    instudid NUMBER,
    inmrkid  NUMBER,
    innewmrk NUMBER,
    insubjid NUMBER
) AS
    v_count NUMBER;
BEGIN
    SELECT
        COUNT(1)
    INTO v_count
    FROM
        marks
    WHERE
        mark_id = inmrkid;

    IF v_count > 0 THEN
        UPDATE marks
        SET
            marks_obtained = innewmrk
        WHERE
            mark_id = inmrkid
            AND subject_id = insubjid
            AND student_id = instudid;

        COMMIT;
        dbms_output.put_line('Data Updated Successfully !!');
    ELSE
        dbms_output.put_line(inmrkid || ' is not present in system !!');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlcode
                             || ' '
                             || sqlerrm);
END;