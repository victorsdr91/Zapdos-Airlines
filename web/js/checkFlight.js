/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var backFlight = null;
var departureFlight = null;
function checkContinue(flight){
    var container = document.getElementById('flights_cont');
    var cont = document.createElement('button');
    if(document.getElementById('continue_flight')!=null) 
            document.getElementById('continue_flight').parentNode.removeChild(document.getElementById('continue'));
    cont.setAttribute('id','continue_flight');
    cont.innerHTML = "Continue";
    cont.classList.add("continue_butt");
    cont.setAttribute("onclick","window.location = 'secondStep.html';");
    switch(flight){
        case 'departureFlight':
            departureFlight = true;
            if(backFlight===null || backFlight) container.appendChild(cont);
            break;
        case 'backFlight':
            backFlight = true;
            if(departureFlight) container.appendChild(cont);
            break;
        case 'departureRemoved':
            departureFlight = false;
            backFlight = false;
            break;
        case 'backRemoved':
            backFlight = false;
            break;
    }
}

function checkNif(dni) {
  var numero = dni.substr(0,dni.length-1);
  var let = dni.substr(dni.length-1,1);
  numero = numero % 23;
  var letra='TRWAGMYFPDXBNJZSQVHLCKET';
  letra=letra.substring(numero,numero+1);
  if (letra!=let){ 
      return false;
  }
  else{
      return true;
  }
}
