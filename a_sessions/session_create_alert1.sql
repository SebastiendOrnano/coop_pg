SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 'alert' AS component,
    'Attention' AS title,
    'Il n''y a pas de compte associé à cet email. Soit vous avez mal saisi votre email, soit vous n'avez pas de compte.

[Reprenez votre saisie](/a_sessions/session_main_form.sql) ou [Créez un compte](/a_users/user_main_form.sql)  ou [contactez l''administrateur](/b_faq/faq_main_form.sql)' AS description_md,
    'alert-circle' AS icon,
    'red' AS color;