SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 'alert' AS component,
    'Attention' AS title,
    'Le compte associé à cet email est archivé ou bloqué !
  
[contactez l''administrateur](/b_faq/faq_main_form.sql) pour le réactiver ' AS description_md,
    'alert-circle' AS icon,
    'red' AS color;