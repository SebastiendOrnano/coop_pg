SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;
SET workpackage_parent_id = SELECT workpackage_parent_id FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;


SELECT 
    'form' AS component,
    'Mettre à jour' AS validate,
    'Clear' AS reset,
    '/e_project_workpackage/workpackage_date_update_0.sql?workpackage_id='||$workpackage_id AS action;

SELECT
    'workpackage_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    6 AS width,
    TRUE AS required,
    (SELECT workpackage_name  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value;

SELECT 
    'workpackage_type'                AS name,
    'Type de travaux'                 AS label,
    'select'                           AS type,
    3                                  AS width,
    TRUE                              AS required,
    (SELECT workpackage_type  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    'Choisir un type dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='workpackage_type';

SELECT 
    'workpackage_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    3 AS width,
    TRUE                     AS required,
    (SELECT workpackage_status  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'workpackage_date_start_scheduled' AS name,
    'date'                      AS type,
    'date lancement prévue'     AS label,
    true                        AS required,
    'ne peut être modifié si le lot de travaux dépend d''un lot parent' as description,
    CASE
    WHEN $workpackage_parent_id IS NOT NULL
    THEN 'true '
    ELSE ''
    END as readonly,
    (SELECT workpackage_date_start_scheduled FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    3                          AS width;

SELECT 
    'workpackage_duration_scheduled' AS name,
    'durée prévue'              AS label,
    'number'                      AS type,
    'jours'                    AS suffix,
    (SELECT workpackage_duration_scheduled  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    true                        AS required,
    'durée en jours'  AS description,
    3                          AS width;

SELECT 
    'workpackage_date_start_actual' AS name,
    'date'                      AS type,
    'date lancement réelle'     AS label,
    (SELECT workpackage_date_start_actual FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    3                          AS width;

SELECT 
    'workpackage_duration_actual' AS name,
    'durée réelle'              AS label,
    'number'                      AS type,
    'jours'                    AS suffix,
    (SELECT workpackage_duration_actual  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    'durée en jours'  AS description,
    3                          AS width;

SELECT 'html' AS component;
SELECT  
'<script>
// Après sauvegarde réussie ou bouton Close
function notifyParentAndClose() {
  window.parent.postMessage({ action: 'refresh', source: 'workpackage_edit' }, '*');
  
  // Émettre aussi l'événement SQLPage pour compatibilité
  window.dispatchEvent(new CustomEvent("sqlpage:modal:close"));
}
</script>''
 AS html;
