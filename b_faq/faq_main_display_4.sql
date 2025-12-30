SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;



SELECT 
    'datagrid'              as component,
    'faq_main_display' as id,
    'Gestion de la FAQ' as title;

SELECT 
    '/b_faq/faq_contact_display_4.sql'               as link,
    'Suivi des contacts           '                  as description,
    'user-plus'                                      as icon,
    'yellow'                                         as color;

SELECT 
    '/b_faq/faq_public_display.sql'             as link,
    'Visualiser la FAQ publique'                   as description,
    'help-hexagon'                                 as icon,
    'green'                                        as color;

SELECT 
    '/b_faq/faq_private_display_1.sql'             as link,
    'Visualiser la FAQ privée'                   as description,
    'help-hexagon'                                 as icon,
    'red'                                          as color;

SELECT 
    '/b_faq/faq_archive_display_4.sql'             as link,
    'Visualiser les questions archivées'                   as description,
    'archive'                                 as icon,
    'blue'                                          as color;

SELECT 'table' AS component, 
    'FAQ questions'   AS title, 
    JSON('{"name":"Close","tooltip":"Fermer la discussion","link":"/b_faq/faq_main_close_0.sql?question_id={id}","icon":"archive"}') as custom_actions,
    JSON('{"name":"Anonym","tooltip":"Anonymiser le contact","link":"/b_faq/faq_contact_anonym_0.sql?question_id={id}","icon":"mood-neutral"}') as custom_actions,
    '/b_faq/faq_main_edit_4.sql?question_id={id}' as edit_url,
    '/b_faq/faq_main_delete_0.sql?question_id={id}' as delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT      
    q.question_id              AS ID,
    q.question_id              as _sqlpage_id,
    q.question                 AS Question,
    q.answer_yes_no            AS Answer,
    q.question_status          AS Statut,
    q.question_category        AS Categorie,
    q.question_public_private  AS PublicPrivate,
    q.faq_yes_no               AS FAQ,
    DATE(q.created_at)         AS Date,
    c.contact_last_name        AS Contact
FROM faq_questions AS q
LEFT JOIN (
    SELECT contact_id, contact_last_name FROM faq_contacts) AS c
    ON q.contact_id = c.contact_id
WHERE  q.question_status !='archived'
ORDER BY q.created_at DESC;