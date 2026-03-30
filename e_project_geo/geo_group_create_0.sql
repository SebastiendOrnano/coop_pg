SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_geo/geo_group_display_4.sql?project_id='||$project_id
ELSE  '/e_project_geo/geo_group_display_3.sql?project_id='||$project_id
END;

INSERT INTO project_geo_group (
    project_id,
    geo_group_title,
    geo_group_status,
    geo_group_rank,
    geo_group_description
)
VALUES
(
    $project_id::integer,
    :geo_group_title,
    'active',
    :geo_group_rank,
    :geo_group_description
)

RETURNING 'redirect' AS component,
         $redirect_link AS link;
