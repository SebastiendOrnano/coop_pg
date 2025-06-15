SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'hero'                 AS component,
    'CO-OP'                AS title,
    'coop_hero'            AS id,
    'Un site web réalisé avec sqlpage      [Pour en savoir plus](/b_about/orga_hero.sql?info_category="hero"&section_number=1)  
    A website built with sqlpage      [Learn more](/b_about/orga_hero.sql?info_category="hero"&section_number=2)' AS description_md,
    'home_page' AS id,
    '/x_icons/logo_coop_240px.png' AS image;
SELECT 

    'Une démo ' AS title,
    'Un site web qui utilise la plupart des composants de sqlpage   
    [Pour en savoir plus](/b_about/orga_hero.sql?info_category="hero"&section_number=3)  
    A website using most of the components of sqlpage
    [Learn more](/b_about/orga_hero.sql?info_category="hero"&section_number=4)' AS description_md,
    'world-www'  AS icon,
    'red'  AS color;

SELECT 
    'Un gabarit' AS title,
    'Un gabarit pour  servir de base au développement d''un projet autour d''une base de données   
    [Pour en savoir plus](/b_about/orga_hero.sql?info_category="hero"&section_number=5)  
    A template to facilitate the setup of a databased project 
    [Learn more](/b_about/orga_hero.sql?info_category="hero"&section_number=6)' AS description_md,
    'steam'       AS icon,
    'green'     AS color;
