SET redirect_link1 = (
    SELECT
      CASE
           WHEN EXISTS 
           (
                SELECT 1
                FROM prm2_sub_employees
                WHERE employee_selected = true
            ) 
            THEN ''
            ELSE '/d_prm2_sub_employees/prm2_sub_employee_select_alert2_0.sql?prm2_sub_id='||$prm2_sub_id
        END
);

SELECT 'redirect' AS component,
$redirect_link1 AS link
WHERE $redirect_link1 != '' OR $redirect1 IS NOT NULL;


SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET prm2_id = SELECT prm2_id FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER;

SELECT 
    'alert'                    as component,
    'Suppression des employées' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    'Vous pouvez soit retirer les personnes sélectionnées dans la liste des employés sans les supprimer de la liste des personnes physiques soit la supprimer complétement !' as description; 

SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_select_display_4.sql?prm2_sub_id='||$prm2_sub_id    as link,
    'Retour à la liste' as title,
    'green'    as color;

SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_select_remove_0.sql?prm2_sub_id='||$prm2_sub_id  as link,
    'Retirer les personnes de la liste des employés de l''entreprise' as title;

SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_select_delete_alert2_4.sql?prm2_sub_id='||$prm2_sub_id  as link,
    'Supprimer définitivement les personnes' as title,
    'red'                                  as color;



