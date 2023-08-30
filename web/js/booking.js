function printE(element)
{
    var elemImprimir=window.open(' ','popimpr');
    elemImprimir.document.write(element.innerHTML);
    elemImprimir.document.close();
    elemImprimir.print();
    elemImprimir.close();
}