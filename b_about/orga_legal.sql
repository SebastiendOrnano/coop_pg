SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'title'   AS component,
    'Mentions légales' AS contents,
    TRUE      AS center;

SELECT

'text' AS component;

SELECT

'Ce site est soumis au régime juridique français. À ce titre, il est un service de communication au public en ligne édité à titre non professionnel au sens de l’article 6, Ⅲ, 2° de la loi 2004‑575 du 21 juin 2004. ' AS contents_md;



SELECT 
     'foldable' AS component;
SELECT 
   section_title AS title,
   'foldablemargin' AS class,
   section_content  AS description_md
 FROM info_sections WHERE section_category='legal' AND section_status='active' ORDER BY section_number ASC;
