SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET therm_set_sensor_id = SELECT therm_set_sensor_id FROM therm_dataset WHERE therm_dataset_id = $therm_dataset_id::integer
SET therm_set_id = SELECT therm_set_id FROM therm_set_sensor WHERE therm_set_sensor_id=$therm_set_sensor_id::INTEGER;
SET room_id = SELECT  room_id FROM therm_set WHERE therm_set_id=$therm_set_id::INTEGER;
SET building_id = SELECT  building_id FROM project_building_rooms WHERE room_id=$room_id::INTEGER;
SET project_id = SELECT  project_id FROM project_building WHERE building_id=$building_id::INTEGER;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Editeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
 SELECT 
    'liste des projets'            as title,
    '/e_project/project_main_display_3.sql'     as link;   
 SELECT 
    'hub du projet'            as title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     as link;   
 SELECT 
    'Therm'            as title,
    '/e_project_therm/therm_set_display_3.sql?project_id='||$project_id     as link;   
 SELECT 
    'Capteur'            as title,
    '/e_project_therm/therm_set_sensor_display_3.sql?therm_set_id='||$therm_set_id     as link;   
 SELECT 
    'Dataset'            as title,
    '/e_project_therm/therm_dataset_display_3.sql?therm_set_sensor_id='||$therm_set_sensor_id   as link;


SELECT 
    'alert'     AS component,
    'Formatage du fichier source' AS title,
     TRUE              AS important,
    TRUE              AS dismissible,
'L''importation de données en masse ne fonctionnera que si le fichier contenant les données à importer est correctement formaté.  
Il doit ếtre au format cvs avec une délimitation des champs par des points virgules ";" et "" comme séparateur de chaîne de caractère.   
Lors de l''enregistrement sous dans excel ou calc, pensez à afficher les paramètres du filtre.

Il est souvent nécessaire de faire plusieurs essais avant de trouver le bon réglage. Vous pouvez utiliser le bouton ''purge'' pour éliminer un jeu de données incohérent' AS description_md,
'red' AS color;

SELECT 
    'button' AS component;
SELECT 
    '/x_docs/data_set1.csv' AS link,
    'Fichier gabarit'         AS title,
    'download'                AS icon,
    'dataset_example.csv' AS download,
    'green' AS color;


SELECT 
    'form'       AS component,
    'Import CSV' AS title,
    'Charger le fichier'  AS validate,
    '/e_project_therm/therm_data_upload_0.sql?therm_dataset_id='||$therm_dataset_id AS action;
SELECT 
    'dataset_sensor_input' AS name,
    'file'               AS type,
    'text/csv'           AS accept,
    'DataSetSensor1'           AS label,
    'Respecter le format de la table dataset' AS description,
    TRUE                 AS required;