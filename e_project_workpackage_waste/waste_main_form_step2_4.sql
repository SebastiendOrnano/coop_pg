SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link; 
SELECT 
    'Hub lot de travaux'    AS title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id AS link;
SELECT 
    'Déchets'            AS title,
    '/e_project_workpackage_waste/waste_main_display_4.sql?workpackage_id='||$workpackage_id    AS link;


SELECT 
    'form' AS component,
    'Energistrer un déchet' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_workpackage_waste/waste_main_create_0.sql?workpackage_id='||$workpackage_id  AS action;

SELECT 
    'waste_category_id'                AS name,
    'Catégorie'                 AS label,
    'select'                           AS type,
    3                                  AS width,
    TRUE                              AS required,
    'Choisir un type dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',product_category_name, 'value', product_category_id))  AS options
    FROM project_products_categories WHERE product_category_parent_id  =:waste_category_id::INTEGER ;

SELECT
    'waste_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    9 AS width,
    TRUE AS required;

SELECT
    'waste_summary' AS name,
    'textarea' AS type,
    'Détail du déchet' AS label;

SELECT
    'waste_ienes_url' AS name,
    'text' AS type,  
    'URL Fiche base IENES' AS label,
    9 AS width;

SELECT 
    'waste_functional_unit'                AS name,
    'Unité fonctionnelle'                 AS label,
    'select'                           AS type,
    3                                  AS width,
    'Choisir l''unité dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='material_unit';

SELECT 
    'waste_unit'                             AS name,
    'Unité'                                  AS label,
    'select'                                   AS type,
        3                                       AS width,
    'Choisir dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='material_unit';


SELECT
    'waste_quantity' AS name,
    'text' AS type,
   3                                 AS width,
    'Quantité' AS label;


SELECT 
    'waste_value'            AS name,
    'Valeur'                  AS label,
     TRUE                      AS required,
    'text'                     AS type,
    'euros'                    AS suffix,
    'Valeur estimée par unité'                 AS description,
    6                          AS width;

SELECT 
    'waste_destination'           AS name,
    'Destination'                      AS label,
    'select'                      AS type,
    '%'                           AS suffix,
    'utilisation future du déchet'        AS description,
    3                             AS width,
    'Choisir le taux dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='material_origin';

SELECT 
    'recipiend_id' AS name,
    'Destinataire' AS label,
    'select' AS type,
    4 AS width,
    TRUE AS searchable,
   'Saisissez quelques lettres que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',prm2_sub_name, 'value', prm2_sub_id))  AS options
    FROM prm2_sub
    WHERE prm2_sub_status!='archived';


