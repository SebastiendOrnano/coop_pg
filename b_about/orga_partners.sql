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
     orga_partner_name                AS title,
     orga_partner_link                AS link,
     orga_partner_punchline           AS footer,
     orga_partner_logo_url            AS image_url
    FROM orga_partners
WHERE orga_partner_status = 'active' AND orga_partner_type='partner' AND orga_partner_category='gold';


SELECT 
    'datagrid'              AS component,
    'silver'                  AS id,
    'Partner SILVER'          AS title;
SELECT 
    orga_partner_name                AS title,
    orga_partner_link                AS link,
    orga_partner_punchline           AS footer,
    orga_partner_logo_url            AS image_url
    FROM orga_partners
WHERE orga_partner_status = 'active' AND orga_partner_type='partner' AND orga_partner_category='silver';


SELECT 
    'datagrid'              AS component,
    'bronze'                  AS id,
    'Partner BRONZE'          AS title;
SELECT 
    orga_partner_name                AS title,
    orga_partner_link                AS link,
    orga_partner_punchline           AS footer,
    orga_partner_logo_url            AS image_url
    FROM orga_partners
WHERE orga_partner_status = 'active' AND orga_partner_type='partner' AND orga_partner_category='bronze';


