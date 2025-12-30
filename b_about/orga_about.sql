SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
  'title'   AS component,
  'À propos du projet Co-op' AS contents,
   TRUE      AS center;

SELECT 
  'foldable' AS component;
SELECT 
  section_title AS title,
  'foldablemargin' AS class,
  section_content  AS description_md
 FROM info_sections WHERE section_category='about' AND section_status='active' ORDER BY section_number ASC;
