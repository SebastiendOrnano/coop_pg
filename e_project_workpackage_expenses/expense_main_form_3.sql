SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

set project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'   AS link;   
 SELECT 
    'Hub projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;   
SELECT 
    'Hub lot de travaux'            AS title,
    '/e_project_workpackage/workpackage_hub_display_3.sql?workpackage_id='||$workpackage_id    AS link;
SELECT 
    'Gestion des dépenses'            AS title,
    '/e_project_workpackage_expenses/expense_main_display_3.sql?workpackage_id='||$workpackage_id     AS link;

SELECT 
    'form' AS component,
    'Energistrer une dépense' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_workpackage_expenses/expense_main_create_0.sql?workpackage_id='||$workpackage_id   AS action;


SELECT 
    'expense_category'                AS name,
    'Catégorie'                 AS label,
    'select'                           AS type,
    3                                  AS width,
    TRUE                              AS required,
    'Choisir un type dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='expense_category';

SELECT
    'expense_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    9 AS width,
    TRUE AS required;

SELECT
    'expense_summary' AS name,
    'textarea' AS type,
    'Détail de l''achat (description matériau / contenu prestation)' AS label;

SELECT 
    'expense_unit'                AS name,
    'Unité'                 AS label,
    'select'                           AS type,
    2                                  AS width,
    'Choisir l''unité dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='expense_unit';

SELECT
    'expense_quantity' AS name,
    'text' AS type,
    2                              AS width,
    'Quantité' AS label;

SELECT 
    'expense_invoice_date'       AS name,
    'Date facture'               AS label,
    'date'                       AS type,
    true                         AS required,
    2                            AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')   AS description;

SELECT
    'expense_invoice_url'  AS name,
    'file'                 AS type,
    5                      AS width,
    'Scan facture'         AS label;

SELECT
    'expense_invoice_ref'  AS name,
    'text'                 AS type,
    2                      AS width,
    'Réf facture'          AS label;

SELECT 
    'expense_value'            AS name,
    'Prix HT'                  AS label,
     TRUE                      AS required,
    'text'                     AS type,
    'euros'                    AS suffix,
    'prix  HT'                 AS description,
    2                          AS width;

SELECT 
    'expense_taxt_rate'           AS name,
    '% taxe'                      AS label,
    'select'                      AS type,
    '%'                           AS suffix,
    'taux taxe applicable'        AS description,
    1                             AS width,
    'Choisir le taux dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='tax_rate';

SELECT 
    'expense_material_origin'           AS name,
    'Origine'                      AS label,
    'select'                      AS type,
    '%'                           AS suffix,
    'si matriaux origin'        AS description,
    3                             AS width,
    'Choisir le taux dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='material_origin';

SELECT 
    'provider_id' AS name,
    'Fournisseur' AS label,
    'select' AS type,
    4 AS width,
    TRUE AS searchable,
   'Saisissez quelques lettres que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',prm2_sub_name, 'value', prm2_sub_id))  AS options
    FROM prm2_sub
    WHERE prm2_sub_status!='archived';

SELECT 
    'expense_saving'                         AS name,
    'Économie réalisée'                      AS label,
    'text'                                   AS type,
    'euros'                                  AS suffix,
    'Économie réalisée (si réemploi ou don)' AS description,
    2                                        AS width;
