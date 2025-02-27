<%--
  Created by IntelliJ IDEA.
  User: miarantsoa
  Date: 26/02/2025
  Time: 05:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Vol" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="models.Avion" %>
<%@ page import="models.VilleDesservie" %>
<%@ page import="models.User" %>

<%
    List<Vol> vols = (List<Vol>) request.getAttribute("vol");
    List<Avion> avion = (List<Avion>) request.getAttribute("avion");
    List<VilleDesservie> ville = (List<VilleDesservie>) request.getAttribute("ville");
    DateFormat sdf = new SimpleDateFormat("EEE dd MMM yyyy HH:mm:ss", Locale.FRENCH);
    User u = null;
    if (session.getAttribute("user") != null) {
        u = (User) session.getAttribute("user");
    }

%>

<div class="col-md-12">
    <% for (int i = 0; i < vols.size(); i++) { %>
    <% Vol v = vols.get(i); %>
    <%
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM dd, yyyy");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        String dateDepartStr = dateFormat.format(v.getDateDepart());
        String heureDepartStr = timeFormat.format(v.getDateDepart());
        String dateArriveeStr = dateFormat.format(v.getDateArrivee());
        String heureArriveeStr = timeFormat.format(v.getDateArrivee());
    %>
    <div class="card mt-3 py-3 px-2">
        <div class="flight-info">
            <div class="flight-summary d-flex align-items-center justify-content-between">
                <span>Vol de <b><%=v.getVilleDepart()%></b> à <b><%=v.getVilleArrivee()%></b> le <b><%=sdf.format(v.getDateDepart())%></b></span>
                <i class="fa-solid fa-circle-plus toggle-flight" style="cursor: pointer;"></i>
            </div>
            <div class="flight-details position-relative mt-4" style="display: none;">
                <div class="row">
                    <div class="col-md-8">
                        <p>Type d'avion: <b><%=v.getModele()%>
                        </b></p>
                        <div class="row mt-4">
                            <div class="d-flex justify-content-between align-items-center" style="color: #6c757d">
                                <h6>
                                    <%= dateDepartStr %> - Départ
                                </h6>
                                <h6>
                                    <%= dateArriveeStr %> - Arrivée
                                </h6>
                            </div>

                            <div class="row">
                                <div class="text-center d-flex flex-row justify-content-between align-items-center gap-2"
                                     style="width: 48%">
                                    <div>
                                        <h2><%= heureDepartStr %>
                                        </h2>
                                        <small><%= v.getVilleDepart() %>
                                        </small>
                                    </div>
                                    <div class="border border-gray w-100" style="height: 1px;"></div>
                                </div>

                                <div class="d-flex justify-content-center align-items-center" style="width: 2%">
                                    <span style="font-size: 1.5rem;"><i class="fa-solid fa-plane"></i></span>
                                </div>

                                <div class="text-center d-flex flex-row justify-content-between align-items-center gap-2"
                                     style="width: 48%">
                                    <div class="border border-gray w-100" style="height: 1px;"></div>
                                    <div>
                                        <h2><%= heureArriveeStr %>
                                        </h2>
                                        <small><%= v.getVilleArrivee() %>
                                        </small>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4 justify-content-center">
                                <div class="col-auto">
                                    <p>Date et heure de départ :
                                        <b><%= sdf.format(v.getDateDepart()) %>
                                        </b>
                                    </p>
                                </div>
                                <div class="col-auto">
                                    <p>Date et heure d'arrivée :
                                        <b><%= sdf.format(v.getDateArrivee()) %>
                                        </b>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-4">
                            <div class="row text-center">
                                <h2>Places restantes</h2>
                            </div>
                            <div class="row">
                                <div class="col-md-6 text-center d-flex flex-column justify-content-center align-items-center">
                                    <h4><%=v.getEconomique()%></h4>
                                    <small>Economique</small>
                                </div>
                                <div class="col-md-6 text-center d-flex flex-column justify-content-center align-items-center">
                                    <h4><%=v.getBusiness()%></h4>
                                    <small>Business</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <form action="${pageContext.request.contextPath}/promotion-vol" method="post">
                            <input type="hidden" name="prom.idVol" value="<%=v.getId()%>">
                            <label for="nbrEco">Nombre de place pour "Economique":</label>
                            <input type="number" name="prom.nbrBusi" id="nbrEco" class="form-control">
                            <br>
                            <label for="prEco">Promotion pour "Economique":</label>
                            <input type="number" name="prom.prEco" id="prEco" class="form-control">
                            <br>
                            <label for="nbrBusi">Nombre de place pour "Business":</label>
                            <input type="number" name="prom.nbrBusi" id="nbrBusi" class="form-control">
                            <br>
                            <label for="prBusi">Promotion pour "Economique":</label>
                            <input type="number" name="prom.prBusi" id="prBusi" class="form-control">
                            <br>
                            <button type="submit" class="btn btn-confirmation">Confirmer</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <% } %>
</div>