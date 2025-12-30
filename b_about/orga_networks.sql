SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'title'                           AS component,
    'Nous retrouver sur les réseaux sociaux' AS contents,
    TRUE                              AS center;

SELECT 
    'datagrid'              AS component,
    'social_network'                  AS id;
SELECT 
     o.orga_partner_link                AS link,
     o.orga_partner_logo_url            AS image_url
    FROM orga_dept_partners as o 
        LEFT JOIN (select orga_dept_id, orga_dept_name, orga_dept_master FROM orga_dept) as d 
    ON o.orga_dept_id=d.orga_dept_id 
WHERE o.orga_partner_status = 'active' AND o.orga_partner_type='social_network' AND d.orga_dept_master = 'master'  ;