SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;

SELECT 
    'alert'                 AS component,
    'Changement du nom d''utilisateur confirmé !' AS title,
    'check'            AS icon,
    'green'                AS color;


SELECT
    '/a_panels/panel_user_1.sql' AS link,
    'Retour au panneau d''administratin du profil' AS title;
  

