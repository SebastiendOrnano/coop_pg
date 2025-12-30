SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'alert'     AS component,
    'Vous avez oublié votre mot de passe ?' AS title,
    'L''administrateur n''a pas accès aux mots de passe. Seuls les utilisateurs connectés peuvent modifier leur mot de passe.
    
[Vous devez contacter l''administrateur](http://localhost:8080/b_faq/faq_main_form.sql) pour qu''il supprime votre compte actuel puis vous pourrez recréer un compte avec le même email.' AS description_md,
    'alert-triangle'            AS icon,
    'red'                AS color;

