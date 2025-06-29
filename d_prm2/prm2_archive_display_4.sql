SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Organisations actives'         AS title,
    '/d_prm2/prm2_main_display_4.sql' AS link;

-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des organisations'   AS title, 
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
   prm2_id         AS Id,
   prm2_name        AS Nom,
   prm2_town        AS Ville,
   '[sub](/d_prm2_sub/prm2_sub_main_display_4.sql?prm2_id=' || prm2_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Edit](/d_prm2/prm2_main_edit_4.sql?prm2_id=' || prm2_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/d_prm2/prm2_main_delete_alert_4.sql?prm2_id=' || prm2_id|| ')'    AS View
FROM prm2
WHERE prm2_name IS NOT NULL AND prm2_status='archived'
ORDER BY prm2_id ASC;
