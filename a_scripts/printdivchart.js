function printdivchart() {
    var ids = ['recap_dataset', 'chart_temp', 'chart_rh'];

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

    var headContent = document.querySelector('head').innerHTML;

    printWindow.document.write(
        '<html><head>' + headContent + '</head><body>' +
        bodyContent +
        '</body></html>'
    );
    printWindow.document.close();

    printWindow.onload = function () {
        printWindow.focus();
        printWindow.print();
        printWindow.close();
    };
}


