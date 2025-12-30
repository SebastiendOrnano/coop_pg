SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'title'                           AS component,
    'Les partenaires du projet Co-op' AS contents,
    TRUE                              AS center;

SELECT 
    'datagrid'              AS component,
    'gold'                  AS id,
    'Partner GOLD'          AS title;
SELECT 
     o.orga_partner_name                AS title,
     o.orga_partner_link                AS link,
     o.orga_partner_punchline           AS footer,
     o.orga_partner_logo_url            AS image_url
    FROM orga_dept_partners as o
    LEFT JOIN (select orga_dept_id, orga_dept_name, orga_dept_master FROM orga_dept) as d 
    ON o.orga_dept_id=d.orga_dept_id 
    WHERE o.orga_partner_status = 'active' AND o.orga_partner_type='partner' AND o.orga_partner_category='gold' AND d.orga_dept_master = 'master'  ;


SELECT 
    'datagrid'              AS component,
    'silver'                  AS id,
    'Partner SILVER'          AS title;
SELECT 
    o.orga_partner_name                AS title,
    o.orga_partner_link                AS link,
    o.orga_partner_punchline           AS footer,
    o.orga_partner_logo_url            AS image_url
    FROM orga_dept_partners as o
    LEFT JOIN (select orga_dept_id, orga_dept_name, orga_dept_master FROM orga_dept) as d 
    ON o.orga_dept_id=d.orga_dept_id 
WHERE o.orga_partner_status = 'active' AND o.orga_partner_type='partner' AND o.orga_partner_category='silver'AND d.orga_dept_master = 'master'  ;


SELECT 
    'datagrid'              AS component,
    'bronze'                  AS id,
    'Partner BRONZE'          AS title;
SELECT 
    o.orga_partner_name                AS title,
    o.orga_partner_link                AS link,
    o.orga_partner_punchline           AS footer,
    o.orga_partner_logo_url            AS image_url
    FROM orga_dept_partners as o
    LEFT JOIN (select orga_dept_id, orga_dept_name, orga_dept_master FROM orga_dept) as d 
    ON o.orga_dept_id=d.orga_dept_id 
WHERE o.orga_partner_status = 'active' AND o.orga_partner_type='partner' AND o.orga_partner_category='bronze' AND d.orga_dept_master = 'master'  ;


