/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function checkCard(){
    var number = document.getElementById('cnumber').value;
    var type = document.getElementById('ctype').value;
    var error = "";
if ((type=="visa" || type=="visaElectron") && !number.match(/^4\d{3}-?\d{4}-?\d{4}-?\d{4}$/) && !number.match(/^4\d{3}?\d{4}?\d{4}?\d{4}$/) )
  error = "The introduced number is not correct";
else if (type=="masterCard" && !number.match(/^5[1-5]\d{2}-?\d{4}-?\d{4}-?\d{4}$/) && !number.match(/^5[1-5]\d{2}?\d{4}?\d{4}?\d{4}$/))
  error = "The introduced number is not correct";
    
  document.getElementById("error").innerHTML = error;
}
function showCVV(element){
    element.style.width = "70%";
    element.setAttribute("onclick","closeCVV(this)");
}
function closeCVV(element){
    element.style.width = "20%";
    element.setAttribute("onclick","showCVV(this)");
}

function checkCVV(){
    var cvv = document.getElementById("cvv").value;
    var error = "";
    if(cvv<'000' || cvv>'999')
       error = "The introduced cvv is not correct";
   document.getElementById("errorcvv").innerHTML = error;
}

function useData(ccard,cholder,cyear,cmonth){
   document.getElementById('cnumber').value = ccard;
   document.getElementById('cyear').value = cyear;
   document.getElementById('cmonth').value = cmonth;
   document.getElementById('cholder').value = cholder;
}