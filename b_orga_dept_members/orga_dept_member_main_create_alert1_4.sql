SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 'alert' AS component,
    'Attention' AS title,
    'Le couple prénom /nom de famille saisie est déjà utilisé.  
    Vérifier si cet adhérent n''a pas déjà été créé. S''il s''agit d''un homonyme, utilisez 2 prénoms dans le champ prénom' AS description_md,
    'alert-circle' AS icon,
    'red' AS color;

select 
    'button' as component;
select 
    '/b_orga_dept_members/orga_dept_member_main_form_4.sql?orga_dept_id='||$orga_dept_id as link,
    'Reprenez votre saisie' as title,
    TRUE                as narrow,
    'corner-down-left' as icon,
    'info'              as color,
    'Retour'           as tooltip;