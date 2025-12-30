SELECT
    'csv'              AS component,
    'Télécharger email-téléphone des membres sélectionnés' AS title,
    'email_membres'           AS filename,
    'csv'              AS class,
    'file-download'    AS icon,
    'yellow'            AS color,
    ';'                AS separator,
    TRUE               AS bom;

SELECT member_first_name, member_last_name, member_email, member_phone, member_date_last_subscription  FROM members
WHERE member_status !='archived' AND age(current_date, member_date_last_subscription) > INTERVAL '1 year';



