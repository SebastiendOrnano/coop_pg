SET  project_forum_topic_status= SELECT project_forum_topic_status FROM  project_forum_topics WHERE project_forum_topic_id = $project_forum_topic_id::INTEGER ;
set project_id = SELECT project_id FROM project_forum_topics WHERE project_forum_topic_id = $project_forum_topic_id::INTEGER ;
SET user_id = (
    SELECT users.user_id FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SELECT 'redirect' as component,
'/e_project_forum/project_forum_message_close_display_3.sql?project_forum_topic_id='||$project_forum_topic_id AS link 
WHERE $project_forum_topic_status='archived';

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
    'Liste des discussion en cours'            as title,
    '/e_project_forum/project_forum_main_display_3.sql?project_id='||$project_id     as link;

SELECT 
    'divider'              as component,
    'Message initial'             as contents,
    'left'                 as position,  
    4                      as size,
    'black'                as color;

SELECT
    'form' as component,
    '' as validate;

SELECT
    'project_forum_topic_name' as name,
    'Titre du message initial' as label,
     7 as width,
    (SELECT project_forum_topic_name FROM project_forum_topics WHERE project_forum_topic_id=$project_forum_topic_id::INTEGER )  AS value;

SELECT
    'project_forum_topic_author' as name,
    'Discussion lancée par : ' as label,
    3 as width,
    (SELECT username FROM users AS u INNER JOIN project_forum_topics as f ON u.user_id = f.project_forum_topic_author_id WHERE f.project_forum_topic_id=$project_forum_topic_id::INTEGER ) as value; 

SELECT
    'created_at' as name,
    'le : ' as label,
    2 as width,
    (SELECT m.created_at FROM project_forum_topics AS t 
    LEFT JOIN  (SELECT project_forum_topic_id, created_at, project_forum_message_rank  FROM project_forum_messages)  AS m
    ON t.project_forum_topic_id = m.project_forum_topic_id
    WHERE t.project_forum_topic_id=$project_forum_topic_id::INTEGER AND m.project_forum_message_rank='main')
    as value; 

SELECT
    'text'             as component,
    'project_forum_message_md' as id;
SELECT
    '**Contenu du message initial :**' as contents_md; 
SELECT
    (SELECT m.project_forum_message_content FROM project_forum_topics AS t 
    LEFT JOIN  (SELECT project_forum_topic_id, project_forum_message_content, project_forum_message_rank  FROM project_forum_messages)  AS m
    ON t.project_forum_topic_id = m.project_forum_topic_id
    WHERE t.project_forum_topic_id=$project_forum_topic_id::INTEGER   AND m.project_forum_message_rank='main')
    as contents_md; 

select 
    'modal2'                as component,
    'my_embed_table_modal'  as id,
    'Documents attachés' as title,
    'Close'                 as close,
    TRUE                   as large,
    '/e_project_forum/project_forum_doc_attach_table_4.sql?project_forum_message_id='||$project_forum_message_id as embed;


SELECT 
    'table'                      AS component, 
    'Message'                    AS markdown,
    'View'                       AS markdown,
JSON('{"name":"doc","tooltip":"doc attachés","link":"#my_embed_table_modal","icon":"book"}') as custom_actions;

SELECT
    '[documents attachés](#my_embed_table_modal)'             AS           view;


SELECT
    'divider'              as component,
    'Réponses'             as contents,
    'left'                 as position,  
    4                      as size,
    'black'                as color;

-- Tableau principal avec colonne markdown contenant un lien
SELECT 
    'table'  AS component, 
    'View'   AS markdown,
    TRUE     AS sort,


     TRUE                         AS search;

-- Données du tableau avec lien markdown
SELECT
    m.project_forum_message_id             AS id,
    m.project_forum_message_id             AS _sqlpage_id,
    to_char(m.created_at AT TIME ZONE 'Europe/Paris', 'YYYY-MM-DD HH24:MI') AS Posted_At,
    (SELECT users.username FROM users WHERE users.user_id = m.project_forum_message_author_id::INTEGER ) AS Author,
    m.project_forum_message_status         AS Statut,
    m.project_forum_message_content        AS Message,

  CASE 
    WHEN EXISTS (
      SELECT 1 
      FROM project_docs as d2
      WHERE d2.project_forum_message_id = m.project_forum_message_id 
        AND d2.project_forum_message_id IS NOT NULL
    )
    THEN JSON('{"name": "doc","tooltip": "doc","link": "/e_project_forum/project_forum_doc_attach_table_3.sql?project_forum_message_id={id}","icon": "paperclip"}')
    ELSE JSON('{"name": "doc"}')
  END AS _sqlpage_actions,
  CASE
  WHEN m.project_forum_message_author_id = $user_id::INTEGER
  THEN  JSON('{"name": "edit","tooltip": "corriger votre message","link": "/e_project_forum/project_forum_message_edit_3.sql?project_forum_message_id={id}","icon": "edit"}')
  ELSE JSON('{"name": "edit"}')
  END AS _sqlpage_actions
    FROM project_forum_messages AS m
    WHERE m.project_forum_topic_id = $project_forum_topic_id::INTEGER 
    AND m.project_forum_message_rank != 'main' 
     AND m.project_forum_message_status = 'active'
    ORDER BY m.created_at ASC;

SELECT 
    'divider'              as component,
    'Votre contribution'   as contents,
    'left'                 as position,  
    4                      as size,
    'green'                as color;

-- Form for replying to the topic
SELECT 'form'      AS component,
 'Envoyer'         as validate,
 'Clear'           as reset,
 '/e_project_forum/project_forum_message_create_0.sql?project_forum_topic_id='||$project_forum_topic_id AS action;

SELECT 
'project_forum_message_content'                  AS name, 
'textarea'                         as type, 
'Votre contribution'               as label,
'Votre post :'  as value,
TRUE                               as required;

SELECT 
    'text' AS type, 
    'project_doc_title' AS name,
    'titre du document' AS label;

SELECT 
    'file' AS type, 
    'project_doc_url' AS name,
    'Document local à partager' AS label,
    'size max : 5 MB' AS description,
    '*'  AS accept;

SELECT 
    'text' AS type, 
    'project_doc_title_link' AS name,
    'titre du lien' AS label;

SELECT 
    'text' AS type, 
    'project_doc_cloud_url' AS name,
    'URL du document partagé sur le cloud' AS label;
