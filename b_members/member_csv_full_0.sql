SELECT 
    'csv'                             AS component,
    'Télécharger la liste des membres' AS title,
    'member_full_list.csv'              AS filename,
    'file-download'    AS icon,
    'green'            AS color,
    ';'                AS separator,
    TRUE               AS bom;


SELECT  * FROM members;


