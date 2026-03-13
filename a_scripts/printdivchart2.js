function printdivchart() {
    var ids = ['recap_dataset_temp', 'recap_dataset_rh', 'recap_dataset', 'chart_temp', 'chart_rh'];
    var bodyContent = '';
    ids.forEach(function(id) {
        var el = document.getElementById(id);
        if (el) {
            bodyContent += el.outerHTML;
        } else {
            console.warn('Élément introuvable pour id=', id);
        }
    });

    if (!bodyContent) {
        alert('Aucun élément à imprimer : vérifiez les id.');
        return;
    }

    var printWindow = window.open('', '_blank');
    printWindow.document.open();

    // Récupérer TOUS les styles (head + styles inline critiques pour Bootstrap)
    var headContent = document.querySelector('head').innerHTML;
    
    // AJOUTER les styles @media print pour forcer la grille Bootstrap
    var printStyles = `
        <style>
            @media print {
                /* Forcer Bootstrap grid */
                .row { 
                    display: flex !important; 
                    flex-wrap: wrap !important; 
                    margin: 0 -15px !important; 
                }
                .col-md-3 { 
                    flex: 0 0 25% !important; 
                    max-width: 25% !important; 
                    padding: 0 15px !important; 
                    box-sizing: border-box !important;
                    display: block !important;
                }
                /* Input groups */
                .input-group { 
                    display: flex !important; 
                    width: 100% !important; 
                }
                .input-group-text { 
                    background: #f8f9fa !important; 
                    border: 1px solid #ced4da !important; 
                    padding: 0.375rem 0.75rem !important;
                }
                .form-control { 
                    border: 1px solid #ced4da !important; 
                    padding: 0.375rem 0.75rem !important;
                }
                .form-label { 
                    margin-bottom: 0.5rem !important; 
                    font-weight: 500 !important;
                }
                /* Masquer éléments non désirés */
                * { visibility: hidden; }
                body > * { visibility: visible; }
                /* Charts et autres éléments visibles */
                #recap_dataset, #chart_temp, #chart_rh { 
                    visibility: visible !important; 
                    position: absolute !important; 
                    left: 0 !important; 
                    top: 0 !important;
                }
            }
            /* Styles screen pour preview */
            body { margin: 0; padding: 20px; font-family: -apple-system, BlinkMacSystemFont, sans-serif; }
            .row { display: flex; flex-wrap: wrap; margin: 0 -15px; }
            .col-md-3 { flex: 0 0 25%; max-width: 25%; padding: 0 15px; box-sizing: border-box; }
        </style>
    `;

    printWindow.document.write(
        '<html><head>' + 
        headContent + 
        printStyles + 
        '</head><body>' +
        bodyContent +
        '</body></html>'
    );
    printWindow.document.close();

    printWindow.onload = function () {
        printWindow.focus();
        // Forcer le media print
        printWindow.matchMedia('print').addListener(function(mql) {
            if (mql.matches) {
                printWindow.print();
                printWindow.close();
            }
        });
        printWindow.print();
    };
}

