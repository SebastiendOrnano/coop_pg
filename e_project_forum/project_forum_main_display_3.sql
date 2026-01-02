SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion éditeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
 SELECT 
    'Projets'            as title,
    '/e_project/project_main_display_3.sql'     as link;   
 SELECT 
    'Hub du projet'            as title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     as link;

SELECT 
    'datagrid'              as component,
    'panel_project_meeting_display' as id,
    'Gestion des réunions du projet :  '|| $project_name as title;
SELECT 
    '/e_project_forum/project_forum_main_form_3.sql?project_id='||$project_id          as link,
    'Lancer une nouvelle discussion'          as description,
    'arrows-random'                                    as icon,
    'yellow'                                   as color;

-- Get the last inserted topic ID
SET project_forum_topic_id = (SELECT MAX(project_forum_topic_id) FROM project_forum_topics WHERE project_forum_topic_name = :project_forum_topic_name);

-- Display list of project_forum_topics
SELECT 'table' AS component, 
    'Forum project_forum_topics'   AS title, 
    'Forum forum_topics'   AS title, 
    '/e_project_forum/project_forum_main_edit_3.sql?project_forum_topic_id={id}' as edit_url,
    JSON('{"name":"topic","tooltip":"Voir la discussion","link":"/e_project_forum/project_forum_message_display_3.sql?project_forum_topic_id={id}","icon":"transform"}') as custom_actions,
    TRUE                   AS sort, 
    TRUE                   AS search;

SELECT       -- NOTE: the dots join values FROM the project_forum_topics and project_forum_messages tables
   --  t.forum_group                AS G, (if group filter is actived)
    t.project_forum_topic_id                   AS ID,
    t.project_forum_topic_id                   AS _sqlpage_id,
    t.project_forum_topic_name                 AS Topic,
    t.project_forum_topic_status               AS Statut,
    t.project_forum_topic_category             AS Categorie,
    to_char(m.created_at AT TIME ZONE 'Europe/Paris', 'YYYY-MM-DD HH24:MI')                  AS Created_at,
    t.number_messages             AS Nb,
   (SELECT username FROM users WHERE users.user_id =  project_forum_topic_author_id)   AS Contributeur
FROM project_forum_topics AS t
LEFT JOIN (
    SELECT project_forum_topic_id, MAX(created_at) AS created_at FROM project_forum_messages
    GROUP BY project_forum_topic_id) AS m 
    ON t.project_forum_topic_id = m.project_forum_topic_id
WHERE  t.project_forum_topic_status !='archived' AND t.forum_type='forum'
ORDER BY t.project_forum_topic_status DESC, m.created_at DESC;
