var occupiedD = new Array(0,0,0,0,0,0,0,0);
var occupiedB = new Array(0,0,0,0,0,0,0,0);
var passengers = new Array();
var passengersB = new Array();
var seatsPass = new Array();
var seatsPassB = new Array();
var index = 0;
var indexB = 0;

function occupiedSeatsD(){
    for(var i=0;i<occupiedD.length;i++){
        if(occupiedD[i]==1){
            document.getElementById("seatD"+(i+1)).src="./img/seats/ocup.png";
            document.getElementById("seatD"+(i+1)).onclick="";
            document.getElementById("seatD"+(i+1)).style.cursor = "default";
        }
    }
    for(var j=0;j<seatsPass.length;j++){
            document.getElementById("seatD"+seatsPass[j]).src="./img/seats/provis.png";
            document.getElementById("seatD"+seatsPass[j]).onclick="";
            document.getElementById("seatD"+seatsPass[j]).style.cursor = "default";

    }
    selectSeat(passengers[index]);
    var b = document.getElementById("next_but");
    if(passengers.length>1 && b===null ){
        var backbut =document.getElementById("back_but");
        if(backbut!=null){
            var but = backbut.nextSibling;
        }
        else var but = document.getElementById("flightselD").nextSibling;
        var bbut = document.createElement("button");
        bbut.id = "next_but";
        bbut.setAttribute('onclick','confirmPD();');
        bbut.innerHTML = "Next Passenger";
        but.parentNode.insertBefore(bbut,but);
    }
}
function selectDS(seat){
    if(seatsPass[index]){
        document.getElementById("seatD"+seatsPass[index]).src = "./img/seats/free.png";
        document.getElementById("seatD"+seatsPass[index]).setAttribute("onclick","selectDS('seatD"+seatsPass[index]+"');");
    }
  seatsPass[index] = seat.substring(5,6);
  
  var objAjax = ajaxObject();
    dataString = "action=selectSeat&type=D&pass="+passengers[index]+"&seat="+seatsPass[index];
    objAjax.open("POST","Dispatcher",true);
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     document.getElementById(seat).src = "./img/seats/select.png";
                     checkSeats();
            }
    };
  
  
}

function selectSeat(passenger){
    var objAjax = ajaxObject();
    dataString = "action=selectSeat&passenger="+passenger;
    objAjax.open("POST","Dispatcher",true);
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     resp = objAjax.responseText;
                     $("#passenger_name").html(resp);
            }
    };
    
}
function confirmPD(){
    index++;
    var but = document.getElementById("next_but");
    occupiedSeatsD();
    var buttonB = document.getElementById("back_but");
    if(index>0 && buttonB===null){
        var bbut = document.createElement("button");
        bbut.id = "back_but";
        bbut.setAttribute('onclick','backPD();');
        bbut.innerHTML = "Previous Passenger";
        but.parentNode.insertBefore(bbut,but);
    }
    if(passengers[index+1]==null){
        
        but.parentNode.removeChild(but);
    }
    
    
}
function backPD(){
    index--;
    var but = document.getElementById("back_but");
    occupiedSeatsD();
    if(index==0){
        but.parentNode.removeChild(but);
    }
}

function occupiedSeatsB(){
    for(var i=0;i<occupiedB.length;i++){
        if(occupiedB[i]==1){
            document.getElementById("seatB"+(i+1)).src="./img/seats/ocup.png";
            document.getElementById("seatB"+(i+1)).onclick="";
            document.getElementById("seatB"+(i+1)).style.cursor = "default";
        }
    }
        for(var j=0;j<seatsPassB.length;j++){
                document.getElementById("seatB"+seatsPassB[j]).src="./img/seats/provis.png";
                document.getElementById("seatB"+seatsPassB[j]).onclick="";
                document.getElementById("seatB"+seatsPassB[j]).style.cursor = "default";
        }

    selectSeatB(passengersB[indexB]);
    var b = document.getElementById("next_but_B");
      if(passengersB.length>1 && b===null){
        var backbut =document.getElementById("back_but_B");
        if(backbut!=null){
            var but = backbut.nextSibling;
        }
        else var but = document.getElementById("flightselB").nextSibling;
        var bbut = document.createElement("button");
        bbut.id = "next_but_B";
        bbut.setAttribute('onclick','confirmPB();');
        bbut.innerHTML = "Next Passenger";
        but.parentNode.insertBefore(bbut,but);
    }
}
function selectBS(seat){
    if(seatsPassB[indexB]){
        document.getElementById("seatB"+seatsPassB[indexB]).src = "./img/seats/free.png";
        document.getElementById("seatB"+seatsPassB[indexB]).setAttribute("onclick","selectBS('seatB"+seatsPassB[indexB]+"');");
    }
  seatsPassB[indexB] = seat.substring(5,6);
  
  var objAjax = ajaxObject();
    dataString = "action=selectSeat&type=B&pass="+passengersB[indexB]+"&seat="+seatsPassB[indexB];
    objAjax.open("POST","Dispatcher",true);
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     document.getElementById(seat).src = "./img/seats/select.png";
                     checkSeats();
            }
    };
  
}

function selectSeatB(passenger){
    var objAjax = ajaxObject();
    dataString = "action=selectSeat&passengerB="+passenger;
    objAjax.open("POST","Dispatcher",true);
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     resp = objAjax.responseText;
                     $("#passenger_name_B").html(resp);
            }
    }
    
    
}
function confirmPB(){
    indexB++;
    var but = document.getElementById("next_but_B");
    occupiedSeatsB();
    var buttonB = document.getElementById("back_but_B");
    if(indexB>0 && buttonB===null){
        var bbut = document.createElement("button");
        bbut.id = "back_but_B";
        bbut.setAttribute('onclick','backPB();');
        bbut.innerHTML = "Previous Passenger";
        but.parentNode.insertBefore(bbut,but);
    }
    if(passengersB[indexB+1]==null){
        
        but.parentNode.removeChild(but);
    }
    
    
}
function backPB(){
    indexB--;
    var but = document.getElementById("back_but_B");
    occupiedSeatsB();
    if(indexB==0){
        
        but.parentNode.removeChild(but);
    }
}
function checkSeats(){
    var button = document.getElementById("continue");
    if(passengers.length==seatsPass.length){
        if(passengersB.length>0){
            if(passengersB.length==seatsPassB.length){
               button.disabled = false;
               button.style.color = "#121f52";
            }
        }
        else{
            button.disabled = false;
            button.style.color = "#121f52";
        }
    }
}


