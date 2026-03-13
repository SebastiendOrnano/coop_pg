function chartexportsvg(event) {
  console.log('chartexportsvg appelée');

  // Récupérer l'élément qui a déclenché l'appel (le bouton cliqué)
  const clickedButton = event ? event.target.closest('button, a') : null;
  if (!clickedButton) {
    console.error('Bouton cliqué introuvable');
    return;
  }

  // Extraire le nom du graphique depuis l'id du bouton
  // chartexporttempsvg → chart_temp
  // chartexportrhsvg → chart_rh  
  const buttonId = clickedButton.id;
  let chartId;
  
  if (buttonId === 'chartexporttempsvg') {
    chartId = 'chart_temp';
  } else if (buttonId === 'chartexportrhsvg') {
    chartId = 'chart_rh';
  } else {
    console.error('ID de bouton inconnu:', buttonId);
    return;
  }
  
  console.log('Bouton:', buttonId, '→ Graphique:', chartId);

  // Trouver le conteneur du graphique correspondant
  const container = document.getElementById(chartId);
  if (!container) {
    console.error('Div #' + chartId + ' introuvable');
    return;
  }

  // Chercher le SVG dans ce conteneur
  const svgs = container.querySelectorAll('svg');
  console.log('SVGs trouvés dans', chartId + ':', svgs.length);

  if (svgs.length === 0) {
    console.error('Aucun SVG trouvé dans #' + chartId);
    return;
  }

  // Prendre le premier SVG (celui d'ApexCharts)
  const svgElement = svgs[0];
  const svgData = new XMLSerializer().serializeToString(svgElement);
  
  // Nom du fichier basé sur le graphique
  const chartName = chartId.replace('chart_', '');
  const filename = chartName + 'Chart.svg';
  
  // Créer et télécharger le SVG
  const svgBlob = new Blob([svgData], { type: 'image/svg+xml;charset=utf-8' });
  const url = URL.createObjectURL(svgBlob);
  
  const a = document.createElement('a');
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);

  console.log('SVG exporté:', filename);
}

// Écouter tous les boutons d'export au chargement de la page
document.addEventListener('DOMContentLoaded', function() {
  console.log('Script chargé, écoute des boutons...');
  
  const exportButtons = document.querySelectorAll('[id^="chartexport"]');
  exportButtons.forEach(btn => {
    btn.addEventListener('click', function(e) {
      e.preventDefault();
      chartexportsvg(e);
    });
  });
});
