SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage
ELSE  '/e_project_workpackage/workpackage_hub_display_3.sql?workpackage_id='||$workpackage
END;


SELECT 'debug' AS component,
       sqlpage.path() AS request_path;

select 
    'empty_state'      as component,
    'Pas de résultat'  as title,
    '404'              as header,
    'Le lien ci-dessus ne mène nulle part. Vérifier le chemin ou le nom du fichier ou informer l''administrateur !' as description,
    'Revenir à la racine'     as link_text,
    'analyze'                 as link_icon,
    $redirect_link            as link,
    'not-found'               as id;