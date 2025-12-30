SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SET age = (SELECT EXTRACT(YEAR FROM AGE(CURRENT_DATE, member_date_birthday)) FROM orga_dept_members WHERE member_id = $member_id::INTEGER)::INTEGER;


SET orga_dept_id   = SELECT orga_dept_id FROM orga_dept_members WHERE member_id = $member_id::INTEGER;
SET dept      =    SELECT orga_dept_name FROM orga_dept WHERE orga_dept_id = $orga_dept_id::INTEGER;
SET since     = SELECT member_date_since FROM orga_dept_members WHERE member_id = $member_id::INTEGER;
SET function  = SELECT member_function FROM orga_dept_members WHERE member_id = $member_id::INTEGER;

SELECT 
    'html' AS component,
    '<div  id="portait_img">' AS html;
SELECT 
    '<img  alt=".."  src="'||(SELECT member_picture_url FROM orga_dept_members WHERE member_id = $member_id::INTEGER)|| '" />' AS html;
SELECT 
    '</div>' AS html;

SELECT 
    'title' AS component,
    (SELECT CONCAT (member_first_name, ' ',  member_last_name) FROM orga_dept_members WHERE member_id = $member_id::INTEGER)  AS contents,
    '1'    AS level,
    TRUE AS center;
   
SELECT 
    'text'              AS component,
    TRUE AS center,
    (SELECT member_punchline FROM orga_dept_members WHERE member_id = $member_id::INTEGER) AS title;

SELECT 
    'text'              AS component;


SELECT 
    CONCAT('age : ',$age,' ans')   AS contents_md;
SELECT 
    CONCAT('Employé de la compagnie :  ', $compagny,'   dans le département :  ',$dept,'  depuis : ', $since, ' au poste de :   ',$function) AS contents_md;


SELECT 
     'foldable' AS component;
SELECT 
   'Résumé' AS title,
   'foldablemargin' AS class,
   TRUE AS expanded,
  member_CV_short AS description_md
 FROM orga_dept_members  WHERE member_id = $member_id::INTEGER;

/*
select
    'button' as component,
    'lg'     as size;
select 
   'javascript:print(height="400px",width="200px")'  as link,
    'azure' as outline,
    'Imprimer'  as title,
    'printer'  as icon;*/


SELECT
    'button' AS component,
    'lg'     AS size;
SELECT 
   'javascript:printdiv()'  AS link,
    'azure' AS outline,
    'Imprimer'  AS title,
    'printer'  AS icon;
