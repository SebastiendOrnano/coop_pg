

/*SELECT 'debug' AS component,
    '404.sql' AS serving_file,
    sqlpage.path() AS request_path;*/



SELECT 
    'alert'                    as component,
    '404 !' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    'Le fichier que vous recherchez n''existe pas. Vérifier le chemin ou le nom du fichier !' as description;
SELECT 
    'Retour à la page index' AS title,
    'home' AS icon,
    '/a_process/process_main_display_5.sql'                   as link;


