/* SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SET project_forum_topic_id =SELECT project_forum_topic_id FROM project_forum_messages where project_forum_message_id=$project_forum_message_id::INTEGER;



SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;

SELECT 
    'Discussion en cours'            as title,
    '/e_project_forum/project_forum_message_display_4.sql?project_forum_topic_id='||$project_forum_topic_id   as link;
*/



SELECT 
    'table' AS component, 
    'Liste des documents'   AS title,
    JSON('{"name":"remove","tooltip":"décrocher le doc du message mais sans le supprimer","link":"/e_project_forum/project_forum_doc_remove_0.sql?project_doc_id={id}","icon":"layout-sidebar-right-collapse"}') as custom_actions,
    '/e_project_forum/project_forum_doc_delete_0.sql?project_doc_id={id}' as delete_url,
    'Titre'           AS markdown;

SELECT
    project_doc_id        AS Id,
    project_doc_id        AS _sqlpage_id,
    CASE 
    WHEN project_doc_local_cloud='local' THEN '['||project_doc_title||']('||project_doc_url||')' 
    WHEN project_doc_local_cloud='cloud' THEN '['||project_doc_title_link||']('||project_doc_cloud_url||')' 
    END   AS Titre,
    project_doc_category             AS Categorie,
    CASE 
    WHEN project_doc_local_cloud='local' THEN project_doc_format   
    WHEN project_doc_local_cloud='cloud' THEN project_doc_cloud_format  
    END                              AS Format,
    project_doc_type               AS Type,
    project_doc_local_cloud                AS LocalCloud
FROM project_docs
WHERE project_forum_message_id = $project_forum_message_id::INTEGER
ORDER BY created_at DESC;