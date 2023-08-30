/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

(function(){
    contract("#current");
    contract("#past");
    
}());


function expand(element){
    $( element+" .books" ).slideDown( "slow" );
    $(element+" .view-more").html("View less...");
    var view = $(element+" .view-more");
    view.click = "";
    $(element+" .view-more").unbind();
    $(element+" .view-more").bind("click", function(){contract(element);});
}
function contract(element){
    $(element+" .books").slideUp();
    $(element+" .view-more").html("View more...");
    $(element+" .view-more").unbind();
    $(element+" .view-more").bind("click", function(){expand(element);});
}