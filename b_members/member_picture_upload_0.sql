-- Redirect the user back to the form if no file was uploaded
SELECT 'redirect' AS component, '/member_main_edit_4.sql' AS link
WHERE sqlpage.uploaded_file_mime_type('Image') NOT LIKE 'image/%';

SET member_picture_url = sqlpage.persist_uploaded_file('member_picture_url', 'x_pictures_events', 'pdf,jpg,jpeg,png');


UPDATE members
SET 
member_picture_title=:member_picture_title, 
member_picture_url=$member_picture_url
WHERE member_id =$member_id::INTEGER


RETURNING 'redirect' AS component, '/b_members/member_picture_form_4.sql?member_id='||$member_id  AS link;
