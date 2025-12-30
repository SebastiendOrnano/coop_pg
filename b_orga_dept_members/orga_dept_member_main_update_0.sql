


UPDATE  orga_dept_members 
SET
    member_gender =:member_gender,
    member_category = :member_category,
    member_status = CASE 
    WHEN :member_status IS NULL OR :member_status = '' 
    THEN member_status
    ELSE :member_status END,
    member_publish = CASE 
    WHEN :member_publish IS NULL OR :member_publish = '' 
    THEN member_publish
    ELSE :member_publish END,
    member_date_birthday=COALESCE(NULLIF(:member_date_birthday, ''), NULL)::DATE,
    member_date_since=COALESCE(NULLIF(:member_date_since, ''), NULL)::DATE,
    member_date_last_subscription=COALESCE(NULLIF(:member_date_last_subscription, ''), NULL)::DATE,
    member_first_name=:member_first_name, 
    member_last_name=:member_last_name, 
    member_email=:member_email, 
    member_phone=:member_phone, 
    member_function=:member_function, 
    member_punchline=:member_unchline, 
    member_cv_short=:member_cv_short, 
    member_cv_long=:member_cv_long,
    orga_dept_id=NULLIF(:orga_dept_id, '')::INTEGER,
    updated_at = CURRENT_TIMESTAMP
WHERE member_id = $member_id::INTEGER

RETURNING 
'redirect' AS component, 
'/b_orga_dept_members/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id    AS link;