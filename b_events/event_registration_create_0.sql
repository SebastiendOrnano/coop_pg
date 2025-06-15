INSERT INTO event_participants 
(
event_id,
participant_gender, 
participant_first_name, 
participant_last_name,
participant_contact_phone, 
participant_contact_email, 
participant_age,
participant_postal_code,
participant_rgpd_validation
)
    
VALUES
(
$event_id::INTEGER,
:participant_gender, 
:participant_first_name, 
:participant_last_name,
:participant_contact_phone, 
:participant_contact_email, 
COALESCE(NULLIF(:participant_age, ''), NULL)::INTEGER,
COALESCE(NULLIF(:participant_postal_code, ''), NULL)::INTEGER,
:participant_rgpd_validation::BOOLEAN
);


UPDATE events
SET
event_participants_nb = (SELECT COUNT(participant_id) FROM event_participants WHERE event_id=$event_id::INTEGER),
updated_at = CURRENT_TIMESTAMP
WHERE event_id=$event_id::INTEGER
 
RETURNING  'redirect' AS component,
'/b_events/event_registration_confirm.sql' AS link;