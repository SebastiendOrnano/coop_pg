SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;
SET workpackage_parent_id = SELECT workpackage_parent_id FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;

SELECT 'text' AS component;
SELECT
'actualisation confimée' as contents;

SELECT 'html' AS component;
SELECT '<script>
  // Afficher le message, puis fermer le modal après 2 secondes
  setTimeout(function () {
    // Demander éventuellement un refresh au parent (si besoin pour d''autres cas)
    window.parent.postMessage(
      { action: "refresh", source: "workpackage_edit", timestamp: Date.now() },
      "*"
    );

    // Émettre l''événement attendu par la page parente
    window.dispatchEvent(new CustomEvent("sqlpage:modal:close"));
  }, 1000);
</script>' AS html;

