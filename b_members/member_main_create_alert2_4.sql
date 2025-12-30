SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SELECT 'alert' AS component,
    'Attention' AS title,
    'L''email saisie est déjà utilisé. Vérifier si cet adhérent n''a pas déjà été créé. Si 2 adhérents partagent le même email, il faut leur demander d''utiliser des emails différents. *(NB : il est parfois possible de créer plusieurs alias sur un même compte mail)
    [Reprenez votre saisie](/b_members/member_main_form_4.sql)  ' AS description_md,
    'alert-circle' AS icon,
    'red' AS color;
