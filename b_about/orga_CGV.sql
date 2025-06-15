SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SET orga_dept_name = (SELECT orga_dept_name FROM orga_dept WHERE orga_dept_id = '1');


SELECT 
    'title'   AS component,
    'CGV' AS contents,
    TRUE      AS center;


SELECT
'text' AS component;
SELECT
'Les présentes Conditions Générales de ventes *ci-après CGV* régissent les règles commerciales des prestations réalisées par '||$orga_dept_name||'. L''utilisateur reconnaît avoir pris connaissance des CGU et s''engage à les respecter.' AS contents_md;

SELECT 
     'foldable' AS component;
        ;
SELECT 
   section_title        AS title,
   'foldablemargin'     AS class,
   section_content      AS description_md
FROM info_sections WHERE section_category='CGV' AND section_status='active' ORDER BY section_number ASC;