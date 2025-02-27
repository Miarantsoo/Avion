<%@ page import="models.Avion" %>
<%@ page import="java.util.List" %>
<%@ page import="models.VilleDesservie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Avion> avion = (List<Avion>) request.getAttribute("avion");
    List<VilleDesservie> ville = (List<VilleDesservie>) request.getAttribute("ville");
%>


<div class="container my-2">
    <h2 class="text-center mt-5">Ajouter un vol</h2>
    <form action="${pageContext.request.contextPath}/add-vol" method="POST" class="row g-3 mt-1">
        <input type="hidden" name="add.id" value="">
        <div class="col-md-8 offset-md-2">
            <label for="typeAvion" class="form-label">L'avion du vol</label>
            <select class="form-control" id="typeAvion" name="add.modele">
                <option value="">-</option>
                <% for (int i = 0; i < avion.size(); i++) {%>
                    <option value="<%=avion.get(i).getId()%>"><%=avion.get(i).getModele()%></option>
                <% }%>
            </select>
        </div>
        <div class="col-md-4 offset-md-2">
            <label for="villeDepart" class="form-label">Ville de départ:</label>
            <select class="form-control" id="villeDepart" name="add.villeDepart">
                <option value="">-</option>
                <% for (int i = 0; i < ville.size(); i++) {%>
                    <option value="<%=ville.get(i).getId()%>"><%=ville.get(i).getNom()%></option>
                <% }%>
            </select>
        </div>
        <div class="col-md-4">
            <label for="villeArrive" class="form-label">Ville d'arrivée:</label>
            <select class="form-control" id="villeArrive" name="add.villeArrivee">
                <option value="">-</option>
                <% for (int i = 0; i < ville.size(); i++) {%>
                    <option value="<%=ville.get(i).getId()%>"><%=ville.get(i).getNom()%></option>
                <% }%>
            </select>
        </div>
        <div class="col-md-4 offset-md-2">
            <label for="dateDepart" class="form-label">Date et heure de départ:</label>
            <input type="datetime-local" class="form-control" id="dateDepart" name="add.dateDepart">
        </div>
        <div class="col-md-4">
            <label for="dateArrive" class="form-label">Date et heure d'arrivée:</label>
            <input type="datetime-local" class="form-control" id="dateArrive" name="add.dateArrivee">
        </div>
        <div class="col-md-4 offset-md-2">
            <label for="eco" class="form-label">Prix par siège en "Economique":</label>
            <input type="number" step="0.01" class="form-control" id="eco" name="add.prixEco">
        </div>
        <div class="col-md-4">
            <label for="busi" class="form-label">Prix par siège en "Business":</label>
            <input type="number" step="0.01" class="form-control" id="busi" name="add.prixBusi">
        </div>
        <div class="col-8 offset-2 d-flex justify-content-end">
            <button type="submit" class="btn btn-avion">Ajouter</button>
        </div>
    </form>
</div>
