CREATE OR REPLACE PACKAGE pkg_emp_dtl AS
    PROCEDURE prc_add_student (
        instudid   NUMBER,
        instudname VARCHAR2,
        indob      DATE,
        inclass    NUMBER,
        injndt     DATE
    );

    PROCEDURE prc_inst_marks (
        inmrkid  NUMBER,
        instudid NUMBER,
        insubjid NUMBER,
        inexmdt  DATE,
        inmrkobt NUMBER
    );

    PROCEDURE prc_updt_stud_mark (
        instudid NUMBER,
        inmrkid  NUMBER,
        innewmrk NUMBER,
        insubjid NUMBER
    );

    FUNCTION fn_get_avg_mark (
        instudid NUMBER
    ) RETURN NUMBER;

    FUNCTION fn_get_total_marks (
        instudid NUMBER
    ) RETURN NUMBER;

END pkg_emp_dtl;