SELECT
    'csv'              AS component,
    'Télécharger email-téléphone des membres sélectionnés' AS title,
    'utilisateurs'           AS filename,
    'csv'              AS class,
    'file-download'    AS icon,
    'yellow'            AS color,
    ';'                AS separator,
    TRUE               AS bom;

SELECT 
member_first_name, 
member_last_name, 
member_email,
member_phone  
 
FROM members
WHERE member_selected=true;



