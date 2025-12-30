-- vérif si le nom d'utilisateur n'est pas déjà utilisé 
-- vérif si l'email' existe déjà

SET redirect_link = (
    SELECT
        CASE
            WHEN EXISTS (
                SELECT 1 
                FROM orga_dept_members
                WHERE CONCAT (member_first_name,member_last_name) = CONCAT (:member_first_name,:member_last_name)
            ) 
            THEN '/b_orga_dept_members/orga_dept_member_main_create_alert1_4.sql?orga_dept_id='||$orga_dept_id::INTEGER
            WHEN 
            EXISTS (
                SELECT 1 
                FROM orga_dept_members
                WHERE member_email= :member_email) 
            THEN '/b_orga_dept_members/orga_dept_member_main_create_alert2_4.sql?orga_dept_id='||$orga_dept_id::INTEGER
            ELSE ''
        END
);

SELECT 'redirect' AS component, $redirect_link AS link
WHERE $redirect_link != '' OR $redirect IS NOT NULL;


INSERT INTO orga_dept_members 
(
    member_gender, 
    member_first_name, 
    member_last_name,
    member_category,  
    member_status,
    member_publish,
    member_date_birthday, 
    member_date_since, 
    member_date_last_subscription,
    member_email,
    member_phone, 
    member_function,
    member_picture_url, 
    member_picture_title, 
    member_punchline, 
    member_cv_short, 
    member_cv_long,
    member_selected,
    orga_dept_id
)
SELECT 
    :member_gender,
    :member_first_name, 
    :member_last_name, 
    :member_category,
    :member_status,
    :member_publish,
    COALESCE(NULLIF(:member_date_birthday, ''), NULL)::DATE,
    COALESCE(NULLIF(:member_date_since, ''), NULL)::DATE,
    COALESCE(NULLIF(:member_date_last_subscription, ''), NULL)::DATE,
    :member_email, 
    :member_phone, 
    :member_function,
    sqlpage.persist_uploaded_file('member_picture_url', 'x_pictures_persons', 'jpg,jpeg,png,gif'),
    :member_picture_title,
    :member_punchline, 
    :member_cv_short, 
    :member_cv_long,
    false,
    $orga_dept_id::INTEGER

RETURNING 
'redirect' AS component, 
'/b_orga_dept_members/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id::INTEGER AS link;