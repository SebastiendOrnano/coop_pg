SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET prm2_sub_id = SELECT prm2_sub_id FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER;

SELECT 
    'alert'                    as component,
    'Suppression de l''employé de la liste' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    'Vous pouvez soit retirer la personne dans la liste des employés sans la supprimer de la liste des personnes physiques soit la supprimer complétement !' as description; 


SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_main_archive_0.sql?employee_id='||$employee_id  as link,
    'Archiver l''employé' as title,
    'green'    as color;
SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_main_delete_alert2_4.sql?employee_id='||$employee_id  as link,
    'Supprimer définitivement la personne' as title,
    'blue'                                  as color;
SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_main_display_4.sql?prm2_sub_id='||$prm2_sub_id   as link,
    'Retour à la liste' as title,
    'green'    as color;



