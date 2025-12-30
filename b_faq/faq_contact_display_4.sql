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
    'Gestion FAQ'                             as title,
    '/b_faq/faq_main_display_4.sql'                  as link;

SELECT 
    'datagrid'              as component,
    'faq_contact_display' as id,
    'Suivi des contacts de la FAQ' as title;

SELECT 
    '/b_faq/faq_contact_csv_0.sql'                  as link,
    'Télécharger la liste des contacts'             as description,
    'download'                                      as icon,
    'green'                                         as color;

SELECT 'table' AS component, 
    'FAQ questions'   AS title, 
    JSON('{"name":"Anonym","tooltip":"Anomymiser le contact","link":"/b_faq/faq_contact_anonym2_0.sql?contact_id={id}","icon":"mood-neutral"}') as custom_actions,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT      
    c.contact_id               AS ID,
    q.question                 AS Question,
    c.contact_id               as _sqlpage_id,
    DATE(q.created_at)         AS Date,
    c.contact_first_name       AS CPrénom,
    c.contact_last_name        AS Nom,
    c.contact_email            AS Email
FROM faq_contacts AS c
LEFT JOIN (
    SELECT contact_id, question, created_at FROM faq_questions) AS q
    ON c.contact_id = q.contact_id

ORDER BY q.created_at DESC;