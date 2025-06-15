SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET orga_id= SELECT orga_id FROM orga_dept WHERE orga_dept_id=$orga_dept_id::INTEGER;

-- Link back to the process home page
SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
    CASE WHEN $user_role = 'supervisor' 
    THEN '/b_orga_dept/orga_dept_main_display_4.sql?orga_id='||$orga_id
    ELSE '/b_orga_dept/orga_dept_main_display_1.sql?orga_id='||$orga_id
END;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;

SELECT 
    'Gestion des departements'            AS title,
     '/b_orga_dept/orga_dept_main_display_4.sql?orga_id='||$orga_id  AS link;


SELECT 
    'title'     AS component,
    'Structure employeuse'    AS contents,
    3           AS level;

SELECT 
    'form' AS component,
    '' AS validate;

SELECT 
    'orga_id' AS name,
    'hidden' AS type,
    $orga_id AS value,
    'id' AS label;

SELECT 
    'orga_dept_id' AS name,
    'hidden' AS type,
    $orga_dept_id AS value,
    'id' AS label;

SELECT
    'orga_dept_name' AS name,
    TRUE AS readonly,
    'Nom de la filiale ou du département' AS label,
     6 AS width,
    (SELECT orga_dept_name  FROM orga_dept WHERE orga_dept_id = $orga_dept_id::INTEGER ) AS value;

SELECT
    'orga_name' AS name,
    'text' AS type,
    TRUE AS readonly, 
    'Nom de la organisation mère' AS label,
    6 AS width,
    (SELECT orga_name  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT 
    'title'     AS component,
    'Liste des employés'    AS contents,
    3           AS level;

SELECT 
    'table'               AS component, 
    TRUE                  AS sort, 
    'View'                AS markdown, 
    TRUE                AS search;

SELECT
    member_first_name            AS Prénom,
    member_last_name             AS Nom,
    member_function              AS Poste,
   '[View](/b_members/member_dept_profile_complete_4.sql?member_id=' || member_id ||  ') &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Edit](/b_members/member_dept_edit_4.sql?member_id=' || member_id ||'&orga_dept_id='||$orga_dept_id||') &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Delete](/b_orga_dept/orga_dept_member_alert_4.sql?member_id=' || member_id ||')'    AS View
FROM members
WHERE orga_dept_id = $orga_dept_id::INTEGER
ORDER BY created_at ASC;

SELECT 
    'title'   AS component,
    'Ajouter un employé' AS contents,
    3         AS level;

-- Form for replying to the topic



SELECT 
    'form'      AS component,
    'Ajouter un employé' AS validate,
     '/b_orga_dept/orga_dept_member_update_0.sql?member_id='||:member_id AS action;

SELECT 
    'orga_id' AS name,
    'hidden' AS type,
     $orga_id AS value,
    'orga_id' AS label;

SELECT 
    'orga_dept_id' AS name,
    'hidden' AS type,
    $orga_dept_id AS value,
    'dept_id' AS label;

SELECT 
   'member_id' AS name,
    'Nom de l''empoyé' AS label,
    'select' AS type,
    6 AS width,
    TRUE AS searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', member_last_name || '   ' || member_first_name, 'value', member_id)    ORDER BY member_last_name ASC, member_first_name ASC) AS options
    FROM members WHERE orga_dept_id is NULL;