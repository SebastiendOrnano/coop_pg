SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;

SELECT 
    'alert'     as component,
    'Changement du mot de passe confirmé !' as title,
    'check'            as icon,
    'green'                as color;


SELECT
    '/a_panels/panel_user_1.sql' as link,
    'Retour au panneau d''administratin du profil' as title;
  

