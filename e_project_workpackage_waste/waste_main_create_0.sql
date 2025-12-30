SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_workpackage_waste/waste_main_display_4.sql?workpackage_id='||$workpackage_id
ELSE  '/e_project_workpackage_waste/waste_main_display_3.sql?workpackage_id='||$workpackage_id
END;

INSERT INTO project_workpackage_waste
(
	recipiend_id,
	workpackage_id,
	waste_name,
	waste_status,
	waste_ienes_url,
	waste_functional_unit,
	waste_unit,
	waste_quantity,
	waste_category_id,
	waste_summary,
	waste_destination,
	waste_value
	)
VALUES 
(
	COALESCE(NULLIF(:recipiend_id, ''), NULL)::INTEGER,
	$workpackage_id::INTEGER,
	:waste_name,
	'active',
	:waste_ienes_url,
	:waste_functional_unit,
	:waste_unit,
	COALESCE(NULLIF(:waste_quantity, ''), NULL)::INTEGER,
	COALESCE(NULLIF(:waste_category_id, ''), NULL)::INTEGER,
	:waste_summary,
	:waste_destination,
	:waste_value::FLOAT
)

RETURNING 'redirect' AS component,
$redirect_link  AS link;


