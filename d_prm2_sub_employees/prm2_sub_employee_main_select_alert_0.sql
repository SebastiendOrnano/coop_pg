SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET prm2_id = SELECT prm2_id FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER;

SET redirect_link1 = 
(
    SELECT
        CASE
        WHEN 
        (SELECT employee_selected FROM prm2_sub_employees WHERE employee_selected=true) IS NULL or (SELECT employee_selected FROM prm2_sub_employees WHERE employee_selected=true) =''
        THEN '/d_prm2_sub_employees/prm2_sub_employee_main_select_alert1_4.sql?prm2_sub_id='||$prm2_sub_id||'&prm2_id='||$prm2_id
        ELSE '/d_prm2_sub_employees/prm2_sub_employee_main_select_edit_4.sql?prm2_sub_id='||$prm2_sub_id||'&prm2_id='||$prm2_id'
        END
);

SELECT 'redirect' AS component, $redirect_link1 AS link
WHERE $redirect_link1 != '' OR $redirect1 IS NOT NULL;




SELECT 
    'alert'                    as component,
    'Actualisation' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    'Vous pouvez soit retirer la personne dans la liste des employés sans la supprimer de la liste des personnes physiques soit la supprimer complétement !' as description; 

SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_main_display_4.sql?prm2_sub_id='||$prm2_sub_id||'&prm2_id='||$prm2_id    as link,
    'Retour à la liste' as title,
    'green'    as color;

SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_main_remove_0.sql?employee_id='||$employee_id||'&prm2_sub_id='||$prm2_sub_id  as link,
    'Retirer la personne de la liste des employés de l''entreprise' as title;

SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_main_delete_alert2_4.sql?employee_id='||$employee_id||'&prm2_sub_id='||$prm2_sub_id  as link,
    'Supprimer définitivement la personne' as title,
    'red'                                  as color;



