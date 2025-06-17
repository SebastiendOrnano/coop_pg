SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'title'                           AS component,
    'Nous retrouver sur les réseaux sociaux' AS contents,
    TRUE                              AS center;

SELECT 
    'datagrid'              AS component,
    'social_network'                  AS id;
SELECT 
     orga_partner_link                AS link,
     orga_partner_logo_url            AS image_url
    FROM orga_partners
WHERE orga_partner_status = 'active' AND orga_partner_type='social_network' AND orga_dept_id = '2' ;