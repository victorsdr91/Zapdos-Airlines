<%-- 
    Document   : index
    Created on : 19-ene-2016, 10:51:30
    Author     : victo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="com.lang.text" />
<!DOCTYPE html>
<html lang="${language}">
 <% session = request.getSession();
    if(session.getAttribute("language")==null){
        session.setAttribute("language", "en_GB");
    }
    if(request.getParameter("section")!=null){
        if(!request.getParameter("section").equals("login")){
            String option = request.getParameter("section");
            session.setAttribute("section", option+".html");
        }
    }
    else{
        session.setAttribute("section", "index.html");
    }
 %>
<%@include file="view/header.jsp" %>
<% if(request.getParameter("section")!=null){
    String option = request.getParameter("section");
    if(option.equals("firstStep")){ %>
      <%if(session.getAttribute("booking")!=null){ %>

         <%@include file="view/selectFlight.jsp" %> 
        <%}else{ %>
           <%@include  file="view/main.jsp" %>  
        <% }%>
    <% }else if(option.equals("secondStep")){ %>
        <%if(session.getAttribute("booking")!=null){ %>
         <%@include file="view/passengerData.jsp" %>
        <%}else{ %>
           <%@include  file="view/main.jsp" %>  
        <% }%>
         
    <% }else if(option.equals("thirdStep")){ %>
         <%if(session.getAttribute("booking")!=null){ %>
          <%@include file="view/selectServices.jsp" %>
        <%}else{ %>
           <%@include  file="view/main.jsp" %>  
        <% }%>
         
    <% }else if(option.equals("fourthStep")){ %>
    <%if(session.getAttribute("booking")!=null){ %>
          <%@include file="view/selectSeat.jsp" %>
        <%}else{ %>
           <%@include  file="view/main.jsp" %>  
        <% }%>
         
    <% }else if(option.equals("fifthStep")){ %>
    <%if(session.getAttribute("booking")!=null){ %>
          <%@include file="view/loginRegister.jsp" %>
        <%}else{ %>
           <%@include  file="view/main.jsp" %>  
        <% }%>
        
    
    <% }else if(option.equals("sixthStep")){ %>
    <% if(session.getAttribute("booking")!=null){ %>
          <%@include file="view/showBooking.jsp" %>
        <%}else{ %>
           <%@include  file="view/main.jsp" %>  
        <% }%>
        
       
    <% }else if(option.equals("seventhStep")){ %>
        <% if(session.getAttribute("booking")!=null){ %>
          <%@include file="view/selectPayment.jsp" %>  
        <%}else{ %>
           <%@include  file="view/main.jsp" %>  
        <% }%>
        

    <% }else if(option.equals("confirmedBooking")){ %>
       <% if(session.getAttribute("booking")!=null){ %>
          <%@include file="view/messages/confirmedBooking.jsp" %>  
        <%}else{ %>
           <%@include  file="view/main.jsp" %>  
        <% }%>
      
    <% }else if(option.equals("showBooking")){ %>
      <%@include file="view/showPaidBooking.jsp" %> 

    <% }else if(option.equals("errorLogging")){ %>
      <%@include file="view/messages/errorLogging.jsp" %>  

    <% }else if(option.equals("errorSavingBooking")){ %>
      <%@include file="view/messages/errorSavingBooking.jsp" %> 
    
    <% }else if(option.equals("errorDeletingFlight")){ %>
      <%@include file="view/messages/errorDeletingFlight.jsp" %> 
    
    <% }else if(option.equals("deletedFlight")){ %>
      <%@include file="view/messages/flightDeleted.jsp" %> 
      
    <% }else if(option.equals("checkin")){ %>
      <%@include file="view/checkin.jsp" %>  
      
    <% }else if(option.equals("showBoardingCards")){ %>
      <%@include file="view/showBoardingCards.jsp" %> 
     
    <% }else if(option.equals("admin")){ %>
         <%@include file="view/admin.jsp" %> 
         
    <% }else if(option.equals("myBookings")){ %>
         <%@include file="view/myBookings.jsp" %> 

    <% }else if(option.equals("showSelectedBooking")){ %>
         <%@include file="view/showSelectedBooking.jsp" %> 
    
    <% }else if(option.equals("login")){ %>
         <%@include file="view/login.jsp" %> 
         
    <% }else if(option.equals("showIncidents")){ %>
         <%@include file="view/showIncidents.jsp" %> 
                
    <% }else{ %>
            <%@include  file="view/main.jsp" %>
          
 <% }
}
else{ %>
     <%@include file="view/main.jsp" %>
<% } %>
<%@include file="view/footer.jsp" %>
    
       
