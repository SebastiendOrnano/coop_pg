SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Admin'         AS title,
    '/a_panels/panel_admin_5.sql' AS link;

SELECT 
    'csv'              AS component,
    'Télécharger la liste des sessions' AS title,
    'log_sessions'           AS filename,
    'file-download'    AS icon,
    'green'            AS color,
    ';'                AS separator,
    TRUE               AS bom;

SELECT 
    username, user_id, created_at, logout_at, session_duration
FROM sessions
WHERE session_duration IS NOT NULL;



SELECT 
    'chart'             AS component,
    'Nb de sessions connectées par jour durant le mois dernier' AS title,
    'bar'              AS type,
    'indigo'            AS color,
    5                   AS marker,
    (CURRENT_DATE-INTERVAL '1 MONTH')                     AS xmax;
SELECT
      DATE(created_at)                    AS x,
      COUNT(session_token)                AS y
FROM sessions
WHERE DATE(created_at) > (CURRENT_DATE-INTERVAL '1 MONTH') AND  session_duration IS NOT NULL 
GROUP BY DATE(created_at)
ORDER BY DATE(created_at);



SELECT 
    'chart'             AS component,
    'Nb de sessions connectées par mois durant l''an dernier' AS title,
    'bar'              AS type,
    'indigo'            AS color,
    5                   AS marker,
    TRUE                AS time;
SELECT
      DATE(created_at)                    AS x,
      COUNT(session_token)                AS y
FROM sessions
WHERE DATE(created_at) > CURRENT_DATE-INTERVAL '1 YEAR'AND  session_duration IS NOT NULL
GROUP BY DATE(created_at)
ORDER BY DATE(created_at);

SELECT 
    'alert'                     AS component,
    'Warning'                   AS title,
    'Les stats suivantes sur la durée des sessions connectées ne prennent en compte que les sessions qui ont été correctement refermées (logout). Une analyse plus poussée suppose l''emploi d''un script.' AS description,
    'alert-triangle'            AS icon,
    'yellow'                    AS color;


SELECT 
    'chart'             AS component,
    'Durée moyenne des sessions connectées  par jour durant le mois dernier  en secondes' AS title,
    'bar'              AS type,
    'indigo'            AS color,
    5                   AS marker,
    TRUE                AS time;
SELECT
      DATE(created_at)                    AS x,
      ROUND(AVG(session_duration) )       AS y
FROM sessions
WHERE DATE(created_at) > (CURRENT_DATE-INTERVAL '1 MONTH') AND  session_duration IS NOT NULL 
GROUP BY DATE(created_at)
ORDER BY DATE(created_at);

SELECT
    'chart'             AS component,
    'Durée max des sessions connectées  par jour durant le mois dernier en secondes' AS title,
    'area'              AS type,
    'green'             AS color,
    5                   AS marker,
    TRUE                AS time;
SELECT 
      DATE(created_at)             AS x,
      MAX(session_duration)        AS y
FROM sessions
WHERE DATE(created_at) > (CURRENT_DATE-INTERVAL '1 MONTH') AND  session_duration IS NOT NULL 
GROUP BY DATE(created_at)
ORDER BY DATE(created_at);

SELECT 
    'chart'             AS component,
    'Durée moyenne des sessions connectées  par mois durant l''année  en secondes' AS title,
    'area'              AS type,
    'indigo'            AS color,
    5                   AS marker,
    TRUE                AS time;
SELECT
      DATE(created_at)                    AS x,
      ROUND(AVG(session_duration) )       AS y
FROM sessions
WHERE DATE(created_at) > CURRENT_DATE-INTERVAL '1 YEAR'AND  session_duration IS NOT NULL
GROUP BY DATE(created_at)
ORDER BY DATE(created_at);
