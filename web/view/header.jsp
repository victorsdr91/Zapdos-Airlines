<%-- 
    Document   : header
    Created on : 28-ene-2016, 22:04:46
    Author     : victo
--%>
<%@page import="model.User"%>
<%      HttpSession sess = request.getSession();
    User user = (User) sess.getAttribute("user"); %>
<head>
    <title>Zapdos Airlines</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="js/jquery.js" ></script>
    <script type="text/javascript" src="js/jquery-ui.min.js" ></script>
    <script type="text/javascript" src="js/datepicker.js" ></script>
    <script type="text/javascript" src="js/passengers.js" ></script>
    <script type="text/javascript" src="js/ajax.js" ></script>
    <script type="text/javascript" src="js/checkFlight.js" ></script>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="css/jquery-ui.theme.min.css" />
</head>
<body onload="datepicker();">
    <header>
        <img src="img/logo_h_500x127.png" alt="Zapdos Airlines"/>
        <nav style="float:left">
            <ul>
                <li>
                    <a href="index.jsp"><fmt:message key="menu.nav.a.home" /> </a>
                    <a href="#"><fmt:message key="menu.nav.a.faq" /></a>
                    <a href="#"><fmt:message key="menu.nav.a.about" /></a>
                </li>
            </ul>
        </nav>

        <% if (user != null) {%>
        <nav id="login_box" class="login" style="width:20%;">
            <div style="text-align:center;">
                <span><fmt:message key="Hi" />  <%=user.getName()%>  -  <%=user.getNif()%> </span>
            </div>
            <div style="text-align:center;">
                <button onclick='window.location = "myBookings.html"' id='myprofileb' class='login_button' style='margin-left:1%;font-size:0.95em;' ><fmt:message key="my.bookings" /></button> 
                <button onclick='disconnect();' id='logout' class='login_button' style='margin-left:1px;font-size:0.95em;' ><fmt:message key="log.out" /></button>
            </div>
        </nav>
        <% } else {%>
        <nav id="login_box" class="login">
            <form action="userLogin" method="post" >
                <div class="labels">
                    <label for='username'>
                        <span>Email</span>
                        <input type='email' id='usernameL' name='username' />
                    </label>
                    <label for='password'>
                        <span><fmt:message key="menu.nav.pwd" /></span>
                        <input type='password' id='passwordL' name='password' />
                    </label>
                </div>
                <button type='submit' id='login' class='login_button' style="float:left">Login</button>
                <input type="hidden" value="<%=sess.getAttribute("section")%>" name="returnS" />
                <div style="clear:left"></div>
            </form>
        </nav>
        <% }%>
    </nav>
    <nav class="langselect">
        <form>
            <select id="language" name="language" onchange="submit()">
                <option value="en_GB" ${language == 'en_GB' ? 'selected' : ''}>English</option>
                <option value="es_ES" ${language == 'es_ES' ? 'selected' : ''} >Español</option>
            </select>
        </form>
    </nav>
    <div style="clear:left;" /></div>
</header>
