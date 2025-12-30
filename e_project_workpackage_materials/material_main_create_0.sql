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

INSERT INTO project_workpackage_materials
(
product_id,
workpackage_id,
material_summary,
material_unit,
material_quantity,
material_status,
material_volume1,
material_volume2,
material_area,
material_length,
material_heigth,
material_width,
material_weigth,
material_thickness,
material_equiv_fonctional_units,
material_carbon_footprint
)
VALUES 
(
:product_id::INTEGER,
$workpackage_id::INTEGER,
:material_summary,
:material_unit,
COALESCE(NULLIF(:material_quantity, ''), NULL)::INTEGER,
'active',
COALESCE(NULLIF(:material_volume1, ''), NULL)::FLOAT,
COALESCE(NULLIF(:material_volume2, ''), NULL)::FLOAT,
COALESCE(NULLIF(:material_area, ''), NULL)::FLOAT,
COALESCE(NULLIF(:material_length, ''), NULL)::FLOAT,
COALESCE(NULLIF(:material_height, ''), NULL)::FLOAT,
COALESCE(NULLIF(:material_width, ''), NULL)::FLOAT,
COALESCE(NULLIF(:material_weight, ''), NULL)::FLOAT,
COALESCE(NULLIF(:material_thickness, ''), NULL)::FLOAT,
COALESCE(NULLIF(:material_equiv_fonctional_units, ''), NULL)::INTEGER,
$material_carbon_footprint::FLOAT
)

RETURNING 'redirect' AS component,
$redirect_link  AS link;



