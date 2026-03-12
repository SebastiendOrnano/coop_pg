SELECT 
    'csv'                             AS component,
    'Télécharger les données' AS title,
    'dataset.csv'              AS filename,
    'file-download'    AS icon,
    'green'            AS color,
    ';'                AS separator,
    TRUE               AS bom;


SELECT  * FROM therm_data WHERE therm_dataset_id=$therm_dataset_id::INTEGER ;
