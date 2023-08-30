/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function checkEmail(email){
    var objAjax = ajaxObject();
    dataString = "action=checkEmail&email="+email;
    
    objAjax.open("POST","Dispatcher",true);
    objAjax.onreadystatechange = function(){
            if(objAjax.readyState === 4 && objAjax.status === 200){
                    var but = document.getElementById("register_b");
                     resp = objAjax.responseText;
                     if(resp==1){
                         but.disabled = false;
                         but.style.color = "#121f52";
                         
                         document.getElementById("email").style.borderColor="green";
                     }
                     else{
                         but.setAttribute("disabled","true");
                         but.style.color = "grey";
                         document.getElementById("email").style.borderColor="red";
                     }
            }
    };
    objAjax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");      
    objAjax.send(dataString);
}

function checkPassword(){
    var pass = document.getElementById("rpassword");
    var passc = document.getElementById("rconfpassword");
    var but = document.getElementById("register_b");
    if(pass.value!=passc.value){
        but.setAttribute("disabled","true");
        but.style.color = "grey";
        pass.style.borderColor = "red";
        passc.style.borderColor = "red";
        
    }
    else{
         but.disabled = false;
         but.style.color = "#121f52";
         pass.style.borderColor = "green";
        passc.style.borderColor = "green";
         
        
    }
}
function checkNIF(nif){
    var bool = checkNif(nif);
    var but = document.getElementById("register_b");
    var nif = document.getElementById("nif");
    if(bool){
        nif.style.borderColor = "green";
        but.disabled = false;
        but.style.color = "#121f52";
    }
    else{
        nif.style.borderColor = "red";
        but.disabled = true;
        but.style.color = "grey";
    }
}

function checkData(){
    var nif = document.getElementById("nif");
    var pass = document.getElementById("rpassword");
    var passc = document.getElementById("rconfpassword");
    var email = document.getElementById("email");
    var but = document.getElementById("register_b");
    if(nif.style.borderColor == "red" || pass.style.borderColor == "red" || passc.style.borderColor == "red" || email.style.borderColor == "red"){
        event.preventDefault();
         but.disabled = true;
        but.style.color = "grey";
    }
}