<%--
  Created by IntelliJ IDEA.
  User: miarantsoa
  Date: 12/02/2025
  Time: 11:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>

<%
    String erreur = "";
    if(request.getAttribute("erreur")!=null){
        erreur += (String) request.getAttribute("erreur");
    }
    HashMap<String, String[]> errors = new HashMap<>();
    if(request.getAttribute("error")!=null){
        errors = (HashMap<String, String[]>) request.getAttribute("error");
    }
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Atkinson+Hyperlegible+Mono:ital,wght@0,200..800;1,200..800&display=swap"
            rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lottie-web/5.12.2/lottie.min.js"></script>
    <title>Avion - 2779</title>
</head>
<body>
    <div class="container login-container">
        <div class="row login-container">
            <div class="col-md-9">
                <div id="lottie"></div>
            </div>
            <div class="col-md-3 d-flex flex-column justify-content-center align-items-center">
                <% if (!erreur.equals("")) { %>
                    <div class="alert alert-danger">
                        <%=erreur%>
                    </div>
                <% } %>
                <form action="${pageContext.request.contextPath}/login" class="w-100 d-flex flex-column justify-content-start align-items-center" method="post">
                    <label for="email">Email:</label>
                    <%
                        if(errors.containsKey("log.email")) {
                            String[] email = errors.get("log.email");
                    %>
                    <input type="text" name="log.email" id="email" class="form-control w-100" value="<%=email[0]%>">
                    <span style="color: red;"><%=email[1]%></span>
                    <br>
                    <%
                    } else {
                    %>
                    <input type="text" name="log.email" class="form-control w-100" id="email">
                    <span></span>
                    <br>
                    <%
                        }
                    %>
                    <label for="mdp">Mot de passe:</label>
                    <%
                        if(errors.containsKey("log.mdp")) {
                            String[] mdp = errors.get("log.mdp");
                    %>
                    <input type="password" name="log.mdp" id="mdp" class="form-control w-100" value="<%=mdp[0]%>">
                    <span style="color: red;"><%=mdp[1]%></span>
                    <br>
                    <%
                    } else {
                    %>
                    <input type="password" name="log.mdp" class="form-control w-100" id="mdp">
                    <span></span>
                    <br>
                    <%
                        }
                    %>
                    <button class="btn btn-avion" type="submit">Se connecter</button>
                </form>
            </div>
        </div>
    </div>
<script>
    const animation = bodymovin.loadAnimation({
        container: document.getElementById('lottie'),
        path: "${pageContext.request.contextPath}/assets/lottie/airplane.json",
        renderer: 'svg',
        loop: true,
        autoplay: true,
    })
</script>
</body>
</html>


