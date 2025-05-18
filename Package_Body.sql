create or replace PACKAGE BODY pkg_emp_dtl AS

    PROCEDURE prc_add_student (
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

            COMMIT;
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

    PROCEDURE prc_inst_marks (
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

            COMMIT;
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

    PROCEDURE prc_updt_stud_mark (
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
    END prc_updt_stud_mark;

    FUNCTION fn_get_avg_mark (
        instudid NUMBER
    ) RETURN NUMBER AS
        v_count    NUMBER;
        v_avg_mark NUMBER;
    BEGIN
        SELECT
            COUNT(1)
        INTO v_count
        FROM
            students
        WHERE
            student_id = instudid;

        IF v_count > 0 THEN
            SELECT
                nvl(
                    AVG(marks_obtained), 0
                )
            INTO v_avg_mark
            FROM
                marks
            WHERE
                student_id = instudid;

            RETURN v_avg_mark;
        ELSE
            dbms_output.put_line('Student not exist in the system !!');
            RETURN -1;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line(sqlcode
                                 || ' '
                                 || sqlerrm);
            RETURN NULL;
    END fn_get_avg_mark;

    FUNCTION fn_get_total_marks (
        instudid NUMBER
    ) RETURN NUMBER AS
        v_count NUMBER;
        v_total NUMBER;
    BEGIN
        SELECT
            COUNT(1)
        INTO v_count
        FROM
            students
        WHERE
            student_id = instudid;

        IF v_count > 0 THEN
            SELECT
                nvl(
                    SUM(marks_obtained), 0
                )
            INTO v_total
            FROM
                marks
            WHERE
                student_id = instudid;

            RETURN v_total;
        ELSE
            dbms_output.put_line('Student not existing in the system !!');
            RETURN -1;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line(sqlcode
                                 || ' '
                                 || sqlerrm);
            RETURN NULL;
    END fn_get_total_marks;

END pkg_emp_dtl;