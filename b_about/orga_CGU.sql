SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'title'   AS component,
    'CGU' AS contents,
    TRUE      AS center;


SELECT
'text' AS component,
'Préambule' AS title;
SELECT
'Les présentes Conditions Générales d''Utilisation *ci-après CGU* régissent l''accès et l''utilisation du site ***Nom du site***, édité par ***Nom de l''entreprise***, dont le siège social est situé ***Adresse de l''entreprise***. L''utilisateur reconnaît avoir pris connaissance des CGU et s''engage à les respecter.' AS contents_md;

SELECT 
     'foldable' AS component;
        ;
SELECT 
   section_title        AS title,
   'foldablemargin'     AS class,
   section_content      AS description_md
FROM info_sections WHERE section_category='CGU' AND section_status='active' ORDER BY section_number ASC;