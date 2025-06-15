SELECT
    'csv'              as component,
    'Télécharger email-téléphone des utilisateurs sélectionnés' as title,
    'utilisateurs'           as filename,
    'csv'              as class,
    'file-download'    as icon,
    'yellow'            as color,
    ';'                as separator,
    TRUE               as bom;

SELECT 
    username,
    user_first_name, 
    user_last_name, 
    user_email,
    user_phone  
FROM users
WHERE user_selected=true ;

UPDATE users 
SET user_selected=false, updated_at = CURRENT_TIMESTAMP;




