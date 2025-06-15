SELECT 
    'csv'              as component,
    'Télécharger la liste des membres' as title,
    'utilisateurs'           as filename,
    'file-download'    as icon,
    'green'            as color,
    ';'                as separator,
    TRUE               as bom;


SELECT  * FROM prm1
WHERE prm1_selected=true ;


UPDATE prm1 
SET prm1_selected=false, updated_at = CURRENT_TIMESTAMP
WHERE prm1_selected = true;



