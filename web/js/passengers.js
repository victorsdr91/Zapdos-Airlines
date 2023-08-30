/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var adults = 0;
var child = 0;
var infant = 0;
function showPassengers() {
    i = 0;
    var passengers = document.getElementById('passengers');
    var showed = document.getElementById("showPassengers");
    if (showed == null) {
        showed = document.createElement('div');
        showed.setAttribute('id', 'showPassengers');
        showed.setAttribute('style', 'width:' + (passengers.offsetWidth - 2) + 'px;top: ' + (passengers.offsetTop + 20) + 'px; left: ' + (passengers.offsetLeft) + 'px');
        var span = passengers.parentNode;

        span.appendChild(showed);

        $('#showPassengers').mouseenter(function () {
            $('#showPassengers').mouseleave(function () {
                destroyDiv();
            });
        });
    }
    refreshDiv();
}
function refreshDiv() {
    showed = document.getElementById('showPassengers');
    showed.innerHTML = "<div><h4>Adultos: " + adults + "</h4> <button class='add_b' onclick = 'addPass(1);'>+</button>  <button class='add_b' onclick = 'rmPass(1);'>-</button></div>" +
            "<div><h4>Adolescentes: " + child + "</h4> <button class='add_b' onclick = 'addPass(2);'>+</button>  <button class='add_b' onclick = 'rmPass(2);'>-</button></div>" +
            "<div><h4>Bebés: " + infant + "</h4> <button class='add_b' onclick = 'addPass(3);'>+</button>  <button class='add_b' onclick = 'rmPass(3);'>-</button></div>";
    $(showed).hide().slideDown("slow");
    $('#adults').val(adults);
    $('#childs').val(child);
    $('#infants').val(infant);
}
function addPass(type) {
    switch (type) {
        case 1:
            adults++;
            break;
        case 2:
            child++;
            break;
        case 3:
            if (adults > infant)
                infant++;
            break;
    }

    refreshDiv();
    var passengers = document.getElementById('passengers');
    passengers.value = (adults + infant + child) + " Pasajeros";
}

function rmPass(type) {
    switch (type) {
        case 1:
            if (adults > 0 && infant < adults)
                adults--;
            break;
        case 2:
            if (child > 0)
                child--;
            break;
        case 3:
            if (infant > 0)
                infant--;
            break;
    }

    refreshDiv();
    var passengers = document.getElementById('passengers');
    passengers.value = (adults + infant + child) + " Pasajeros";
}
function destroyDiv() {
    var showed = document.getElementById('showPassengers');
    $("#showPassengers").slideUp("slow");
}

var nifdisabled = new Array();
var c = 0;
function checkNIF(nife) {
    var but = document.getElementById("continue");
    var nif = event.target;
    var bool = true;
    var nifs = document.getElementsByClassName("nif");
    for (var j = 0; j < nifs.length; j++) {
        if (!checkNif(nifs[j].value)) {
            nifs[j].style.borderColor = "red";
            but.disabled = true;
            but.style.color = "grey";
            bool = false;
        }
    }
    if (checkNif(nife)){
        nif.style.borderColor = "";
    }
    if(bool){
        but.disabled = false;
        but.style.color = "#121f52";
    }
}

function checkCountry(passenger, country) {
    if (country != "") {
        var select = document.getElementById(passenger);
        for (var i = 0; i < select.length; i++) {
            if (select[i].value == country) {
                select[i].selected = true;
            }
            else
                select[i].selected = false;
        }
    }
}
