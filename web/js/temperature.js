/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function getCity(or, country, city){
     var objAjax = ajaxObject();
     var ct;
     switch(country){
         case "Irlanda": ct = "IE";
             break;
         case "Ireland": ct = "IE";
             break;
         case "España": ct = "SP";
             break;
         case "Spain": ct = "SP";
             break
         case "Italy": ct = "IY";
             break;
         case "Italia": ct = "IY";
             break;
         case "France": ct = "FR";
             break;
         case "Francia": ct = "FR";
             break;
    }
    objAjax.open("POST","http://api.wunderground.com/api/5333eae75b2f707b/forecast/lang:SP/q/"+ct+"/"+city+".json",true);
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send();
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                     resp = JSON.parse(objAjax.responseText);
                     
                     var result = resp.forecast.simpleforecast.forecastday;
                     var div;
                     if(or==="f"){
                         div= document.getElementById("fromtemp");
                     }
                     else{
                         div= document.getElementById("totemp");
                     }
                     div.innerHTML = "";
                     for(var i = 0 ; i< result.length ; i++){
                         r = result[i];
                         div.innerHTML += "<div style='background:#CEF6F5;float:left;width:25%'>" +
                                          "<div style='text-align:center;font-weight:bold;'>"+ r.date.day +"-"+ r.date.month +"</div>" +
                                          "<div style='text-align:center;font-weight:bold;'><img src='"+ r.icon_url +"' alt='"+ r.icon +"' style='width:30px' /></div>" +
                                          "<div style='text-align:center;font-size:0.8em;'>"+ r.high.celsius +"/"+ r.low.celsius +"  </div>" +
                                          "</div>";
                    }
                     
            }
    };

}