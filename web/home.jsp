<%@ page import="models.User" %>
<%@ page import="itu.etu2779.annotation.auth.RoleType" %><%--
  Created by IntelliJ IDEA.
  User: miarantsoa
  Date: 13/02/2025
  Time: 17:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String module = request.getParameter("module");
    User u = null;
    if (session.getAttribute("user") != null) {
        u = (User) session.getAttribute("user");
    }
%>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Atkinson+Hyperlegible+Mono:ital,wght@0,200..800;1,200..800&display=swap"
            rel="stylesheet">
    <title>Avion - 2779</title>
</head>
<body>
<div class="container fixed-top border-bottom bg-white">
    <div class="row">
        <div class="col-md-5 py-3 d-flex justify-content-center align-items-center">
            <% if (u != null) { %>
            <p>Connecté(e) en tant que <%=u.getNom()%> <%=u.getPrenom()%>
            </p>
            <% } %>
        </div>
        <div class="col-md-5 offset-md-2 py-3 d-flex justify-content-center align-items-center">
            <div class="row">
                <div class="col-md-12">
                    <% if (u != null) { %>
                    <a href="${pageContext.request.contextPath}/logout">
                        <button type="button" class="btn btn-avion">Se déconnecter</button>
                    </a>

                    <% } else { %>
                    <a href="${pageContext.request.contextPath}/login">
                        <button type="button" class="btn btn-avion">Se connecter</button>
                    </a>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container my-5 pt-5">
    <div class="row my-3">
        <jsp:include page="<%=module%>"/>
    </div>
</div>
<div class="footer container-fluid fixed-bottom">
    <div class="row">
        <footer class="col-md-12">
            <div id="linksContainer">
                <div class="d-flex flex-column gap-1 justify-content-center align-items-center py-4">
                    <% if (u != null && u.getRole() == RoleType.Admin) { %>
                    <a href="${pageContext.request.contextPath}/add-vol" class="animated-link"
                       data-text="Ajouter un vol">Ajouter un vol</a>
                    <a href="${pageContext.request.contextPath}/liste-vol" class="animated-link"
                       data-text="Liste des vols">Liste des vols</a>
                    <a href="${pageContext.request.contextPath}/promotion-vol" class="animated-link" data-text="Promotion">Promotion</a>
                    <a href="${pageContext.request.contextPath}/reservation-settings" class="animated-link"
                       data-text="Reservation">Réservation</a>
                    <% } else { %>
                    <a href="${pageContext.request.contextPath}/liste-vol" class="animated-link"
                       data-text="Liste des vols">Liste des vols</a>
                    <a href="${pageContext.request.contextPath}/booking" class="animated-link"
                       data-text="Faire une réservation">Faire une réservation</a>
                    <% } %>
                </div>
            </div>
            <div class="d-flex justify-content-between align-items-center">
                <h1 style="color: #202020;">Avion</h1>
                <div id="toggleButton" class="">
                    <i class="fa-solid fa-bars menu-icons"></i>
                    <span id="menu">Menu</span>
                </div>
            </div>
        </footer>
    </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>

</html>
