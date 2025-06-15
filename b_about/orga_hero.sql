SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;


SELECT 
    'foldable' AS component;
SELECT 
   section_title              AS title,
   'foldablemargin'           AS class,
   TRUE                       AS expanded,
   section_content            AS description_md
   FROM info_sections WHERE section_category='hero' AND section_status='active' AND section_number=$section_number::INTEGER;
