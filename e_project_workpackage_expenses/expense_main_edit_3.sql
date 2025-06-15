SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET workpackage_id= SELECT workpackage_id FROM project_workpackage_expenses WHERE expense_id=$expense_id::INTEGER;
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
    'Actualiser une dépense' AS title,
    'Actualiser' AS validate,
    'Clear' AS reset,
    '/e_project_workpackage_expenses/expense_main_update_0.sql?expense_id='||$expense_id AS action;

SELECT
    'expense_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    (SELECT expense_name FROM project_workpackage_expenses WHERE expense_id = $expense_id::INTEGER ) AS value,
    12 AS width,
    TRUE AS required;

SELECT
    'expense_summary' AS name,
    'textarea' AS type,
    (SELECT expense_summary FROM project_workpackage_expenses WHERE expense_id = $expense_id::INTEGER ) AS value,
    'Description de la dépense' AS label;



SELECT 
    'expense_category'                AS name,
    'Catégorie'                         AS label,
    'select'                           AS type,
    3                                  AS width,
    TRUE                              AS required,
    (SELECT expense_category FROM project_workpackage_expenses WHERE expense_id = $expense_id::INTEGER ) AS value,
    'Choisir un type dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='expense_category';

SELECT 
    'expense_unit'                AS name,
    'Unité'                 AS label,
    'select'                           AS type,
    2                                  AS width,
    (SELECT expense_unit FROM project_workpackage_expenses WHERE expense_id = $expense_id::INTEGER ) AS value,
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
    (SELECT expense_quantity FROM project_workpackage_expenses WHERE expense_id = $expense_id::INTEGER ) AS value,
    'Quantité' AS label;

SELECT 
    'expense_invoice_date' AS name,
    'Date de la dépense' AS label,
    'date' AS type,
    (SELECT expense_invoice_date FROM project_workpackage_expenses WHERE expense_id = $expense_id::INTEGER ) AS value,
    4 AS width;

SELECT 
    'expense_value'          AS name,
    'Prix HT'                  AS label,
    'text'                   AS type,
    'euros'                    AS suffix,
    (SELECT expense_value FROM project_workpackage_expenses WHERE expense_id = $expense_id::NUMERIC ) AS value,
    'prix  HT'                 AS description,
    3                          AS width;

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
    'provider_id' AS name,
    'Fournisseur' AS label,
    'select' AS type,
    (SELECT provider_id FROM project_workpackage_expenses WHERE expense_id = $expense_id::INTEGER ) AS value,
    4 AS width,
    TRUE AS searchable,
   'Saisissez quelques lettres que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',prm2_sub_name, 'value', prm2_sub_id))  AS options
    FROM prm2_sub
    WHERE prm2_sub_status!='archived';

SELECT 
    'expense_status'                AS name,
    'Statut'                 AS label,
    'select'                           AS type,
    3                                  AS width,
    TRUE                              AS required,
    (SELECT expense_status FROM project_workpackage_expenses WHERE expense_id = $expense_id::INTEGER ) AS value,
    'Choisir un type dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';



