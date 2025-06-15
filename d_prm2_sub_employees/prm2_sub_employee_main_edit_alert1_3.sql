SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET prm2_sub_id = SELECT prm2_sub_id FROM prm2_sub_employees WHERE employee_id=$employee_id::INTEGER;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion éditeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
 SELECT 
    'Gestion du département'            as title,
    '/d_prm2_sub/prm2_sub_main_display_3.sql?prm2_id='||$prm2_id  as link;
SELECT 
    'Gestion des employés'            as title,
    '/d_prm2_sub_employees/prm2_sub_employee_main_display_3.sql?prm2_sub_id='||$prm2_sub_id  as link;


SELECT 
    'alert'                    as component,
    'Mettre à jour le profil de l''employé' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    'Vous pouvez actualiser soit simplement le profil de la personne en tant qu''employé soit le profil général de la personne' as description; 


SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_main_edit1_3.sql?employee_id='||$employee_id  as link,
    'Actualiser le rôle-fonction de l''employée dans l''entrepise' as title,
    'green'    as color;
SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_main_edit2_3.sql?employee_id='||$employee_id  as link,
    'Actualiser le profil général' as title,
    'red'    as color;
SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_main_display_3.sql?prm2_sub_id='||$prm2_sub_id    as link,
    'Retour à la liste' as title,
    'blue'    as color;
