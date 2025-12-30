SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 'debug' AS component,
       sqlpage.path() AS request_path;

select 
    'empty_state'      as component,
    'Pas de résultat'  as title,
    '404'              as header,
    'Le lien ci-dessus ne mène nulle part. Vérifier le chemin ou le nom du fichier ou informer l''administrateur !' as description,
    'Revenir à la racine'     as link_text,
    'analyze'                 as link_icon,
    '/'                       as link,
    'not-found'               as id;


