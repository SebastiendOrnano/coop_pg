SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'title'   as component,
    'Help Dev' as contents,
    TRUE      as center;


SELECT
'text' as component,
'Préambule' as title;
SELECT
'Aide en ligne concernant la structure du gabarit CO-OP' as contents_md;

SELECT 
     'foldable' as component;
        ;
SELECT 
   section_title        as title,
   'foldablemargin'     as class,
   section_content      as description_md
FROM info_sections WHERE section_category='help_dev' AND section_status='active' AND section_lang='FR' ORDER BY section_number ASC;