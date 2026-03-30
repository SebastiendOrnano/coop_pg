
async function mapexportpng(event) {
  console.log('mapexportpng appelée');

  // Trouver le bouton cliqué
  const clickedButton = event ? event.target.closest('button, a') : null;
  if (!clickedButton) {
    console.error('Bouton cliqué introuvable');
    return;
  }

  // On veut toujours exporter la carte #map
  const mapId = 'map';
  const mapContainer = document.getElementById(mapId);
  if (!mapContainer) {
    console.error('Carte non trouvée avec id =', mapId);
    return;
  }

  try {
    console.log('Capture de la carte...');
    // Convertir la carte en image
    const canvas = await html2canvas(mapContainer, {
      useCORS: true, // important pour les tuiles OSM
      logging: false
    });
    const dataUrl = canvas.toDataURL('image/png');

    // Créer et déclencher le téléchargement
    const link = document.createElement('a');
    link.href = dataUrl;
    link.download = 'carte_projets.png';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);

    console.log('Carte exportée avec succès !');
  } catch (err) {
    console.error('Erreur lors de la capture :', err);
  }
}

// Attacher le gestionnaire au chargement
document.addEventListener('DOMContentLoaded', function() {
  console.log('Script chargé, écoute des boutons...');
  const btn = document.getElementById('mapexportpng');
  if (btn) {
    btn.addEventListener('click', function(e) {
      e.preventDefault();
      mapexportpng(e);
    });
  }
});