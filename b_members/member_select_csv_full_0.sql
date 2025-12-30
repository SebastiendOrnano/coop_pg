SELECT 
    'csv'              AS component,
    'Télécharger la liste des membres' AS title,
    'utilisateurs'           AS filename,
    'file-download'    AS icon,
    'green'            AS color,
    ';'                AS separator,
    TRUE               AS bom;


SELECT  * FROM members
WHERE member_selected=true ;


UPDATE members 
SET member_selected=false, 
updated_at = CURRENT_TIMESTAMP;



