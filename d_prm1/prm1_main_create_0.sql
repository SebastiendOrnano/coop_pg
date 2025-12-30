-- vérif si le nom d'utilisateur n'est pas déjà utilisé 
-- vérif si l'email' existe déjà

SET redirect_link1 = 
        CASE
            WHEN EXISTS (SELECT 1 FROM prm1 WHERE CONCAT(prm1_first_name,prm1_last_name) = CONCAT(:prm1_first_name,:prm1_last_name)) 
            THEN '/d_prm1/prm1_main_create_alert1_0.sql'
            WHEN EXISTS (SELECT 1 FROM prm1 WHERE  prm1_email= :prm1_email) 
            THEN '/d_prm1/prm1_main_create_alert2_0.sql'
            ELSE ''
        END;

SELECT 
    'redirect' AS component, 
    $redirect_link1 AS link
    WHERE $redirect_link1 != '' ;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/d_prm1/prm1_main_display_4.sql'
ELSE '/d_prm1/prm1_main_display_3.sql'
END;

INSERT INTO prm1 
(
prm1_gender, 
prm1_first_name, 
prm1_last_name, 
prm1_email, 
prm1_date_birthday, 
prm1_phone, 
prm1_category, 
prm1_function,
prm1_status,
prm1_cv_short, 
prm1_cv_long
)
    
VALUES
(
:prm1_gender, 
:prm1_first_name, 
:prm1_last_name, 
:prm1_email, 
COALESCE(NULLIF(:prm1_date_birthday, ''), NULL)::DATE,
:prm1_phone,
:prm1_category,
:prm1_function,
'active',
:prm1_cv_short, 
:prm1_cv_long
)
 
RETURNING  'redirect' AS component,
$redirect_link AS link;


