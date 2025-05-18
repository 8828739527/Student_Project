CREATE OR REPLACE TRIGGER tgr_before_inst_marks BEFORE
    INSERT ON marks
    FOR EACH ROW
BEGIN
    IF :new.marks_obtained > 100 THEN
        raise_application_error(
                               -20000,
                               'Marks cannot be more then 1000'
        );
    END IF;
END tgr_before_inst_marks;

CREATE OR REPLACE TRIGGER tgr_dlt_stud_aud_data AFTER
    DELETE ON students
    FOR EACH ROW
BEGIN
    INSERT INTO student_audit_log (
        student_id,
        action
    ) VALUES (
        :old.student_id,
        'DELETED'
    );

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlcode
                             || ' '
                             || sqlerrm);
END tgr_dlt_stud_aud_data;

CREATE OR REPLACE TRIGGER tgr_inst_stud_aud_data AFTER
    INSERT ON students
    FOR EACH ROW
BEGIN
    INSERT INTO student_audit_log (
        student_id,
        action
    ) VALUES (
        :new.student_id,
        'INSERTED'
    );

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlcode
                             || ' '
                             || sqlerrm);
END tgr_inst_stud_aud_data;

CREATE OR REPLACE TRIGGER tgr_updt_stud_aud_data AFTER
    UPDATE ON students
    FOR EACH ROW
BEGIN
    INSERT INTO student_audit_log (
        student_id,
        action
    ) VALUES (
        :new.student_id,
        'UPDATED'
    );

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlcode
                             || ' '
                             || sqlerrm);
END tgr_updt_stud_aud_data;