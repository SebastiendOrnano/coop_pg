SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'                    as component,
    'Suppression des employés' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    'En supprimer complétement une personne vous supprimer aussi tous les documents liés et si cette personne est personne est membre d''une équipe cela peut aussi bloquer celle-ci. par prudence vous pouvez soit l''archiver soit l''anonymiser' as description; 

SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_select_display_4.sql?prm2_sub_id='||$prm2_sub_id    as link,
    'Retour à la liste' as title,
    'green'    as color;

SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_select_delete_0.sql?prm2_sub_id='||$prm2_sub_id as link,
    'Supprimer définitivement les personnes' as title,
    'red'                                  as color;

SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_select_archive_0.sql?prm2_sub_id='||$prm2_sub_id as link,
    'Archiver les employés'                 as title,
    'blue'                                  as color;

SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_select_anonym_0.sql?prm2_sub_id='||$prm2_sub_id  as link,
    'anonymiser les employés'                as title,
    'green'                                  as color;



