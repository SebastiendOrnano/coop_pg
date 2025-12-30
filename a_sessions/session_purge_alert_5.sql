SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'alert'                    AS component,
    'Vider le log des sessions' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'La suppression est irréversible. Il ne sera plus possible d''effectuer des statistiques !' AS description;
SELECT 
    '/a_sessions/session_purge_0.sql'      AS link,
    'alert-circle'                         AS icon,
    'Je confirme la suppression'           AS title,
    'red'                                  AS color;
SELECT 
    '/a_panels/panel_admin_5.sql'    AS link,
    'annulation'                         AS title,
    'alert-circle'                        AS icon,
    'yellow'                             AS color;
