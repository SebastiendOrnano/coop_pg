SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;


SET user_id = (
    SELECT u.user_id  FROM users as u
    LEFT JOIN (SELECT session_id, user_id, session_token FROM sessions) as s
    ON s.user_id = u.user_id
    WHERE s.session_token = sqlpage.cookie('session_token')
);


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;

SELECT 
    'datagrid'                                   AS component;
SELECT 
    '/c_workspaces/workspace_main_form_3.sql'    AS link,
    'success'                                    AS color,
    'Créer un nouvel espace de travail'          AS description,
    'users-plus'                                  AS icon;


SELECT 
    'divider' AS component,
    'Espaces de travail'    AS contents,
    'blue' AS color;


SELECT 
    'table'               AS component, 
    TRUE                  AS sort,
    TRUE                  AS hover,
    'View'                AS markdown,
--  TRUE                  AS striped_rows,
    TRUE                  AS small,
    TRUE                 AS search,
    '/c_workspaces/workspace_main_edit_3.sql?workspace_id={id}' as edit_url;

SELECT
    s.workspace_id               AS Id,
    s.workspace_id              as _sqlpage_id,
    CASE 
    WHEN (SELECT user_id FROM workspace_participants AS g WHERE user_id=$user_id::INTEGER AND g.workspace_id= s.workspace_id) IS NULL
    THEN '' 
    ELSE 'red' 
    END  AS _sqlpage_color,
    s.workspace_title            AS Nom,
    s.workspace_summary          AS Description,
    s.workspace_category         AS Categorie,
    s.workspace_status           AS Statut,
  CASE
    WHEN (
      SELECT user_id
      FROM workspace_participants AS g
      WHERE user_id = $user_id::INTEGER AND g.workspace_id = s.workspace_id
    ) IS NULL
    THEN
      json_build_array(
        json_build_object(
          'name', 'Join',
          'tooltip', 'Rejoindre le groupe de travail',
          'link', '/c_workspaces/workspace_main_join_0.sql?workspace_id='||s.workspace_id,
          'icon', 'link-plus'
        ),
         json_build_object(
          'name', 'Enter'
        ),
        json_build_object(
          'name', 'Quit'
        )
      )
    ELSE
      json_build_array(
           json_build_object(
          'name', 'Join'
 
        ),
        json_build_object(
          'name', 'Enter',
          'tooltip', 'Entrer dans la salle de travail',
          'link', '/c_workspaces/workspace_hub_display_3.sql?workspace_id='||s.workspace_id,
          'icon', 'login-2'
        ),
        json_build_object(
          'name', 'Quit',
          'tooltip', 'Quitter le groupe de travail',
          'link', '/c_workspaces/workspace_main_quit_0.sql?workspace_id='||s.workspace_id,
          'icon', 'door-exit'
        )
      )
  END AS _sqlpage_actions
    FROM workspaces AS s
    LEFT JOIN (select user_id, workspace_participant_id, workspace_id from workspace_participants) as g
    ON s.workspace_id = g.workspace_id
WHERE s.workspace_status!='archived' 
ORDER BY s.workspace_id ASC;