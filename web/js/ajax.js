/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function ajaxObject(){
	if(window.XMLHttpRequest){
		obj = new XMLHttpRequest();
	}
	else{
		obj = new ActiveXObject("Microsoft.XMLHTTP");
	}
	return obj;
}

function loadFrom(){
    var objAjax = ajaxObject();
    dataString = "action=loadFrom";
    objAjax.open("POST","Dispatcher",true);
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     resp = objAjax.responseText;
                     $("#fromAirports").html(resp);
                     loadTo($("#fromAirports").val());
            }
    };
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
}

function loadTo(from){
    
    
    var objAjax = ajaxObject();
    dataString = "action=loadTo&from="+from;
    objAjax.open("POST","Dispatcher",true);
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     resp = objAjax.responseText;
                     $("#toAirports").html(resp);
                     var f = document.getElementById("fromAirports");
                     var t = document.getElementById("toAirports");
                     for(var i = 0; i < f.length; i++){
                         if(f[i].selected){
                             var country = f[i].innerHTML.substring(0,f[i].innerHTML.indexOf(":"));
                             var city = f[i].innerHTML.substring(f[i].innerHTML.indexOf(":")+2,f[i].innerHTML.length);
                             
                             getCity("f",country,city);
                         }
                     }
                    for(var i = 0; i < t.length; i++){
                         if(t[i].selected){
                             var country = t[i].innerHTML.substring(0,t[i].innerHTML.indexOf(":"));
                             var city = t[i].innerHTML.substring(t[i].innerHTML.indexOf(":")+2,t[i].innerHTML.length);
                             getCity("t",country,city);
                         }
                     }
            }
    }
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
}

function addDepartureFlight(id){
    var objAjax = ajaxObject();
    var flightsB = document.getElementsByClassName("bflight");
    var bflightdates = document.getElementsByClassName("bflightdate");
    var date = document.getElementById("dfd_"+id);
    var ddate = date.innerHTML;
        var yearD = ddate.substring(0,ddate.indexOf('-'));
        ddate = ddate.substring(ddate.indexOf('-')+1,ddate.length);
        var monthD = ddate.substring(0,ddate.indexOf('-'))-1;
        ddate = ddate.substring(ddate.indexOf('-')+1,ddate.length);
        var dayD = ddate.substring(0,ddate.length);
        var depDate = new Date();
        depDate.setFullYear(yearD, monthD, dayD);
    
    
    for(var i = 0 ; i<bflightdates.length ; i++){
        var bdate = bflightdates[i].innerHTML;
        var year = bdate.substring(0,bdate.indexOf('-'));
        bdate = bdate.substring(bdate.indexOf('-')+1,bdate.length);
        var month = bdate.substring(0,bdate.indexOf('-'))-1;
        bdate = bdate.substring(bdate.indexOf('-')+1,bdate.length);
        var day = bdate.substring(0,bdate.length);
        var backDate = new Date();
        backDate.setFullYear(year, month, day);
        
        if(backDate <= depDate){
           flightsB[i].style.display = "none";
        }else flightsB[i].style.display = "block";
            
    }
    
    dataString = "action=refreshBooking&departureFlight=true&id="+id;
    objAjax.open("POST","Dispatcher",true);
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     resp = objAjax.responseText;
                     $("#cart").html(resp).hide().fadeIn();
            }
    };
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
}
function addBackFlight(id){
    var objAjax = ajaxObject();
    var flightsB = document.getElementsByClassName("dflight");
    var bflightdates = document.getElementsByClassName("dflightdate");
    var date = document.getElementById("bfd_"+id);
    var ddate = date.innerHTML;
        var yearD = ddate.substring(0,ddate.indexOf('-'));
        ddate = ddate.substring(ddate.indexOf('-')+1,ddate.length);
        var monthD = ddate.substring(0,ddate.indexOf('-'))-1;
        ddate = ddate.substring(ddate.indexOf('-')+1,ddate.length);
        var dayD = ddate.substring(0,ddate.length);
        var depDate = new Date();
        depDate.setFullYear(yearD, monthD, dayD);
    
    
    for(var i = 0 ; i<bflightdates.length ; i++){
        var bdate = bflightdates[i].innerHTML;
        var year = bdate.substring(0,bdate.indexOf('-'));
        bdate = bdate.substring(bdate.indexOf('-')+1,bdate.length);
        var month = bdate.substring(0,bdate.indexOf('-'))-1;
        bdate = bdate.substring(bdate.indexOf('-')+1,bdate.length);
        var day = bdate.substring(0,bdate.length);
        var backDate = new Date();
        backDate.setFullYear(year, month, day);
        
        if(backDate > depDate){
           flightsB[i].style.display = "none";
        }else flightsB[i].style.display = "block";
            
    }
    
    
    var objAjax = ajaxObject();
    dataString = "action=refreshBooking&backFlight=true&id="+id;
    objAjax.open("POST","Dispatcher",true);
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     resp = objAjax.responseText;
                     $("#cart").html(resp).hide().fadeIn();
            }
    };
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
}

function refreshCart(){
    var objAjax = ajaxObject();
    dataString = "action=refreshBooking";
    objAjax.open("POST","Dispatcher",true);
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     resp = objAjax.responseText;
                      $("#cart").html(resp).hide().fadeIn();
            }
    };
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
}

function deleteBookingItem(item){
    var objAjax = ajaxObject();
    dataString = "action=refreshBooking&deleteItem="+item;
    objAjax.open("POST","Dispatcher",true);
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     resp = objAjax.responseText;
                     $("#cart").html(resp).hide().fadeIn();
            }
    };
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
    
}

function addBookingService(flight, passenger, service){
     var objAjax = ajaxObject();
    dataString = "action=refreshBooking&addservice="+service+"&pid="+passenger+"&flight="+flight;
    var selectedservice = document.getElementById('service_'+service+""+passenger+"_"+flight).parentNode;
    if(selectedservice.id === "1M"){
        document.getElementById('service_'+(service+1)+""+passenger+"_"+flight).disabled=true;
        document.getElementById('service_'+(service+1)+""+passenger+"_"+flight).style.color = "grey";
    }
    else if(selectedservice.id === "2M"){
        document.getElementById('service_'+(service-1)+""+passenger+"_"+flight).disabled=true;
        document.getElementById('service_'+(service-1)+""+passenger+"_"+flight).style.color = "grey";
    }
    objAjax.open("POST","Dispatcher",true);
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
     objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     resp = objAjax.responseText;
                     $("#cart").html(resp).hide().fadeIn();
                     var services = document.getElementById('service_'+service+""+passenger+"_"+flight);
                     services.innerHTML="Delete Service";
                     services.onclick=" ";
                     services.style.color = "red";
                     services.setAttribute("onclick","deleteBookingService('"+ flight +"',"+ passenger +","+ service +")");
            }
    };
}
function deleteBookingService(flight, passenger, service){
     var objAjax = ajaxObject();
     var deletedservice = document.getElementById('service_'+service+""+passenger+"_"+flight).parentNode;
     if(deletedservice.id === "1M"){
        document.getElementById('service_'+(service+1)+""+passenger+"_"+flight).disabled=false;
        document.getElementById('service_'+(service+1)+""+passenger+"_"+flight).style.color = "#121f52";
    }
    else if(deletedservice.id === "2M"){
        document.getElementById('service_'+(service-1)+""+passenger+"_"+flight).disabled=false;
        document.getElementById('service_'+(service-1)+""+passenger+"_"+flight).style.color = "#121f52";
    }
    dataString = "action=refreshBooking&deleteservice="+deletedservice.id+"&pid="+passenger+"&flight="+flight;
    objAjax.open("POST","Dispatcher",true);
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
     objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     resp = objAjax.responseText;
                     $("#cart").html(resp).hide().fadeIn();
                     var services = document.getElementById('service_'+service+""+passenger+"_"+flight);
                     services.innerHTML="Add Service";
                     services.onclick=" ";
                     services.style.color = "#121f52";
                     services.setAttribute("onclick","addBookingService('"+ flight +"',"+ passenger +","+ service +")");
            }
    };
}

function disconnect(){

    var objAjax = ajaxObject();
    dataString = "action=UserLogout&disconnect=true";
    objAjax.open("POST","Dispatcher",true);
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     location.reload();
            }
    };
    
}

function check(element, flight, booking){
    var objAjax = ajaxObject();
    dataString = "action=checkFlight&flight="+flight+"&booking="+booking;
    objAjax.open("POST","Dispatcher",true);
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     var error = objAjax.responseText;
                     if(error>'0'){
                        element.disabled = true;
                        element.classList.add("disabled");
                     }else {
                         alert("No ha podido hacerse el check-in");
                     }
            }
    };
}