set workpackage_id = SELECT workpackage_id FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 
SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_workpackage_materials/material_main_display_4.sql?workpackage_id='||$workpackage_id
ELSE  '/e_project_workpackage_materials/material_main_display_3.sql?workpackage_id='||$workpackage_id
END;

SET material_carbon_footprint =  :product_climate_change_indicator::FLOAT * :material_equiv_fonctional_units::INTEGER ;

UPDATE project_workpackage_materials 
SET 
material_summary=:material_summary,
material_quantity=COALESCE(NULLIF(:material_quantity, ''), NULL)::INTEGER,
material_unit=:material_unit,
material_status=:material_status,
material_volume1=COALESCE(NULLIF(:material_volume1, ''), NULL)::FLOAT,
material_volume2=COALESCE(NULLIF(:material_volume2, ''), NULL)::FLOAT,
material_area=COALESCE(NULLIF(:material_area, ''), NULL)::FLOAT,
material_length=COALESCE(NULLIF(:material_length, ''), NULL)::FLOAT,
material_heigth=COALESCE(NULLIF(:material_height, ''), NULL)::FLOAT,
material_width=COALESCE(NULLIF(:material_width, ''), NULL)::FLOAT,
material_weigth=COALESCE(NULLIF(:material_weight, ''), NULL)::FLOAT,
material_thickness=COALESCE(NULLIF(:material_thickness, ''), NULL)::FLOAT,
material_equiv_fonctional_units=COALESCE(NULLIF(:material_equiv_fonctional_units, ''), NULL)::INTEGER,
material_carbon_footprint = $material_carbon_footprint::FLOAT,
updated_at = CURRENT_TIMESTAMP

WHERE material_id=$material_id::INTEGER

RETURNING 'redirect' AS component,
$redirect_link AS link;


