SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SELECT 
    'alert'                    AS component,
    'Suppression d''une sprint!' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'Cette suppression entrainera la suppression de tous ses élements liés ! Par prudence, il vaut mieux choisir le statut ''archivé''' AS description;
SELECT 
'/e_project_products/product_main_delete_0.sql?product_id='||$product_id       AS link,
    'Suppression' AS title;
SELECT 
'/e_project_products/product_main_display_4.sql'   AS link,
    'Retour à la liste' AS title,
    'secondary'    AS color;



