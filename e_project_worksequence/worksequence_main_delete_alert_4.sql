SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET workpackage_id = (SELECT workpackage_id FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER) ;


SELECT 
    'alert'                    AS component,
    'Suppression d''une séquence!' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'Cette suppression entrainera la suppression de tous ses élements liés ! Par prudence, il vaut mieux choisir le statut ''archivé''' AS description;
SELECT 
'/e_project_worksequence/worksequence_main_delete_0.sql?worksequence_id='||$worksequence_id       AS link,
    'Suppression' AS title;
SELECT 
'/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id    AS link,
    'Retour à la liste' AS title,
    'secondary'    AS color;



