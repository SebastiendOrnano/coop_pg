SELECT 'csv' 
as component, 
'event_participants_full_list.csv' AS filename;

SELECT participant_first_name, participant_last_name, participant_contact_email, participant_contact_phone, participant_function FROM event_participants WHERE event_id=$event_id::INTEGER;
