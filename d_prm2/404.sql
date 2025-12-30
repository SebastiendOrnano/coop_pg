SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

/*SELECT 'debug' AS component,
    '404.sql' AS serving_file,
    sqlpage.path() AS request_path;*/



SELECT 
    'alert'                    AS component,
    '404 !' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    'Le fichier que vous recherchez n''existe pas. Vérifier le chemin ou le nom du fichier !' AS description;
SELECT 
    'Retour à la liste ' AS title,
    'home' AS icon,
    '/d_prm2/prm2_display_4.sql' AS link;


