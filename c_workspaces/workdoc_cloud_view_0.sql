select 
'text' as component;
select 
'![view](||workdoc_cloud_url||)' as contents_md
from workdocs_cloud where message_id = $message_id::INTEGER

