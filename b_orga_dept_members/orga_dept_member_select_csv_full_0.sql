SELECT 
    'csv'              AS component,
    'Télécharger la liste des membres' AS title,
    'utilisateurs'           AS filename,
    'file-download'    AS icon,
    'green'            AS color,
    ';'                AS separator,
    TRUE               AS bom;


SELECT  * FROM orga_dept_members
WHERE member_selected=true ;


UPDATE  orga_dept_members 
SET member_selected=false, 
updated_at = CURRENT_TIMESTAMP;



