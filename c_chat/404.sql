
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
    'Retour à la page index' AS title,
    'home' AS icon,
    '/' AS link;


