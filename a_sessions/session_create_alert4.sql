SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 'alert' AS component,
    'Attention' AS title,
    'Vous n''avez pas les droits nécessaires pour accéder à cette page.

[Reprenez votre saisie](/a_sessions/session_main_form.sql) ou [Créez un compte](/a_users/user_main_form.sql)  ou [contactez l''administrateur](/b_faq/faq_main_form.sql)' AS description_md,
    'alert-circle' AS icon,
    'red' AS color;