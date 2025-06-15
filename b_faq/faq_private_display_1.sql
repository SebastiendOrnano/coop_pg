SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;

SELECT 
    'title'   as component,
    'FAQ' as contents,
    TRUE      as center;

SELECT 
    'foldable' as component,
    'faq_list_id'    as id;
SELECT 
    'faq_content_class'                       as class,
    question                                  as title,
    '**Categorie** :  *'||question_category||'*

    
**Question** :  *'||question_content||'*

**Réponse** :  '||answer                 as description_md
FROM faq_questions WHERE answer IS NOT NULL AND faq_yes_no=true AND question_public_private='private' AND question_status !='archived'; 