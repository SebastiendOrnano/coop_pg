SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;
set workpackage_id = SELECT workpackage_id FROM project_workpackage_materials WHERE material_id=$material_id;
SELECT 
    'alert'                    AS component,
    'Suppression d''un materiau' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'Cette suppression entrainera la suppression de tous ses élements liés ! Par prudence, il vaut mieux choisir le statut ''archivé''' AS description;
SELECT 
    '/e_project_workpackage_materials/material_main_delete_0.sql?material_id='||$material_id     AS link,
    'Suppression' AS title;
SELECT 
    '/e_project_workpackage_materials/material_main_display_4.sql?workpackage_id='||$workpackage_id  AS link,
    'Retour à la liste' AS title,
    'secondary'    AS color;




