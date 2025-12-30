SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
 '/a_panels/panel_supervisor_4.sql' AS link;

SELECT 
    'Gestion des membres'            AS title,
    '/b_orga_dept_members/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id AS link;

SELECT 
    'alert'     AS component,
    'Formatage du fichier source' AS title,
     TRUE              AS important,
    TRUE              AS dismissible,
'L''importation de données en masse ne fonctionnera que si le fichier contenant les données à importer est correctement formaté.  
Il doit ếtre au format cvs avec une délimitation des champs par des points virgules ";" et "" comme séparateur de chaîne de caractère.   
Lors de l''enregistrement sous dans excel ou calc, pensez à afficher les paramètres du filtre.

Il est souvent nécessaire de faire plusieurs essais avant de trouver le bon réglage. Par prudence, il vaut mieaux faire ces essais sur une version bac à sable de la base de donnéess avant de lancer l''import dans la base de production.' AS description_md,
'red' AS color;

SELECT 
    'alert'     AS component,
    'Conflit sur les valeurs uniques' AS title,
     TRUE              AS important,
    TRUE              AS dismissible,
'L''importation peut aussi échouer si l''on tente de réimporter une donnée qui doit rester unique dans une table. Dans le cas de la table des membres, l''email ne doit pas déjà être présent dans la table.' AS description_md,
'orange' AS color;


SELECT 
    'button' AS component;
SELECT 
    '/x_docs/import_member_example.csv' AS link,
    'Fichier gabarit'         AS title,
    'download'                AS icon,
    'utilisateurs_exemple.csv' AS download,
    'green' AS color;


SELECT 
    'form'       AS component,
    'Import CSV' AS title,
    'Charger le fichier'  AS validate,
    '/b_orga_dept_members/orga_dept_member_import_csv_0.sql' AS action;
SELECT 
    'member_data_input' AS name,
    'file'               AS type,
    'text/csv'           AS accept,
    'Membres'           AS label,
    'Respecter le format de la table members' AS description,
    TRUE                 AS required;

