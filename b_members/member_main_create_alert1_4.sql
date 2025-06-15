SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 'alert' AS component,
    'Attention' AS title,
    'Le couple prénom /nom de famille saisie est déjà utilisé.  
    Vérifier si cet adhérent n''a pas déjà été créé. S''il s''agit d''un homonyme, utilisez 2 prénoms dans le champ prénom
[Reprenez votre saisie](/b_members/member_main_form_4.sql)' AS description_md,
    'alert-circle' AS icon,
    'red' AS color;
