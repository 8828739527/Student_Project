CREATE OR REPLACE FUNCTION fn_get_avg_mark (
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

CREATE OR REPLACE FUNCTION fn_get_total_marks (
    instudid NUMBER
) RETURN NUMBER AS
    v_total NUMBER;
    v_count NUMBER;
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