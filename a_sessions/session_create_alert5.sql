SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'alert'     AS component,
    'Validation de votre rôle' AS title,
    'Votre rôle n''est pas encore validé. Il faut patienter encore que l''administrateur vous  ouvre des droits d''accès. En cas de problème envoyer votre question via le [formulaire de contact](a_faq/faq_form.sql)' AS description_md,
    'alert-triangle'            AS icon,
    'red'                AS color;

