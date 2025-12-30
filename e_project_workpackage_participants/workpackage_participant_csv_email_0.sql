SELECT
    'csv'              AS component,
    'Télécharger email-téléphone des participants' AS title,
    'email_membres'           AS filename,
    'csv'              AS class,
    'file-download'    AS icon,
    'yellow'            AS color,
    ';'                AS separator,
    TRUE               AS bom;

SELECT
    e.workpackage_participant_id      AS ParticipId,
    e.workpackage_participant_role    AS ParticipRole,
    e.workpackage_participant_type    AS ParticipType,
    t.workpackage_id                  AS TeamId,
    t.workpackage_name                AS TeamName,
    p.prm1_id                  AS PersonId,
    p.prm1_first_name          AS PersonFirstName,
    P.prm1_last_name           AS PersonName,
    p.prm1_email               AS PersonEmail, 
    p.prm1_phone               AS PersonPhone,
    c.prm2_sub_name            AS CorpoName,
    c.prm2_sub_contact_mail    AS CorpoMail,
    c.prm2_sub_contact_phone   AS CorpoPhone
FROM project_workpackage_participants AS e
LEFT JOIN (SELECT workpackage_id, workpackage_name FROM project_workpackage ) AS t
ON e.workpackage_id = t.workpackage_id
LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name, prm1_email, prm1_phone FROM prm1) AS p
ON e.prm1_id = p.prm1_id
LEFT JOIN (SELECT prm2_sub_id, prm2_sub_name, prm2_sub_contact_mail, prm2_sub_contact_phone FROM prm2_sub) AS c
ON e.prm2_sub_id = c.prm2_sub_id
WHERE e.workpackage_id =$workpackage_id::INTEGER AND e.workpackage_participant_status= 'active';




