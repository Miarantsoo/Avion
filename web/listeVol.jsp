<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="models.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Vol> vols = (List<Vol>) request.getAttribute("vol");
    List<Avion> avion = (List<Avion>) request.getAttribute("avion");
    List<VilleDesservie> ville = (List<VilleDesservie>) request.getAttribute("ville");
    List<Configuration> conf = (List<Configuration>) request.getAttribute("conf");
    DateFormat sdf = new SimpleDateFormat("EEE dd MMM yyyy HH:mm:ss", Locale.FRENCH);
    User u = null;
    if (session.getAttribute("user") != null) {
        u = (User) session.getAttribute("user");
    }

%>


<div class="col-md-3">
    <form action="${pageContext.request.contextPath}/recherche-vol" method="POST">
        <div class="mt-3 mb-3">
            <label for="typeAvion" class="form-label">Type d'avion:</label>
            <select class="form-control" id="typeAvion" name="rech.modele">
                <option value="">-</option>
                <% for (int i = 0; i < avion.size(); i++) {%>
                <option value="<%=avion.get(i).getModele()%>"><%=avion.get(i).getModele()%>
                </option>
                <% }%>
            </select>
        </div>
        <div class="mb-3">
            <label for="villeDepart" class="form-label">Ville de départ:</label>
            <select class="form-control" id="villeDepart" name="rech.villeDepart">
                <option value="">-</option>
                <% for (int i = 0; i < ville.size(); i++) {%>
                <option value="<%=ville.get(i).getNom()%>"><%=ville.get(i).getNom()%>
                </option>
                <% }%>
            </select>
        </div>
        <div class="mb-3">
            <label for="villeArrive" class="form-label">Ville d'arrivée:</label>
            <select class="form-control" id="villeArrive" name="rech.villeArrivee">
                <option value="">-</option>
                <% for (int i = 0; i < ville.size(); i++) {%>
                <option value="<%=ville.get(i).getNom()%>"><%=ville.get(i).getNom()%>
                </option>
                <% }%>
            </select>
        </div>
        <div class="mb-3">
            <label for="dateDepart" class="form-label">Date et heure de départ:</label>
            <input type="datetime-local" class="form-control" id="dateDepart" name="rech.dateDepart">
        </div>
        <div class="mb-3">
            <label for="dateArrive" class="form-label">Date et heure d'arrivée:</label>
            <input type="datetime-local" class="form-control" id="dateArrive" name="rech.dateArrivee">
        </div>
        <button type="submit" class="btn btn-avion">Rechercher</button>
    </form>
</div>
<div class="col-md-9">
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
                        <div class="text-center d-flex flex-row justify-content-between align-items-center gap-2" style="width: 48%">
                            <div>
                                <h2><%= heureDepartStr %></h2>
                                <small><%= v.getVilleDepart() %></small>
                            </div>
                            <div class="border border-gray w-100" style="height: 1px;" ></div>
                        </div>

                        <div class="d-flex justify-content-center align-items-center" style="width: 2%">
                            <span style="font-size: 1.5rem;"><i class="fa-solid fa-plane"></i></span>
                        </div>

                        <div class="text-center d-flex flex-row justify-content-between align-items-center gap-2" style="width: 48%">
                            <div class="border border-gray w-100" style="height: 1px;" ></div>
                            <div>
                                <h2><%= heureArriveeStr %></h2>
                                <small><%= v.getVilleArrivee() %></small>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4 justify-content-center">
                        <div class="col-auto">
                            <p>Date et heure de départ :
                                <b><%= sdf.format(v.getDateDepart()) %></b>
                            </p>
                        </div>
                        <div class="col-auto">
                            <p>Date et heure d'arrivée :
                                <b><%= sdf.format(v.getDateArrivee()) %></b>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="row text-center">
                        <h2>Heures</h2>
                    </div>
                    <div class="row">
                        <div class="col-md-6 text-center d-flex flex-column justify-content-center align-items-center">
                            <h4>-<%=conf.get(0).getVal()%></h4>
                            <small>Réservation</small>
                        </div>
                        <div class="col-md-6 text-center d-flex flex-column justify-content-center align-items-center">
                            <h4>-<%=conf.get(1).getVal()%></h4>
                            <small>Annulation</small>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="row">
                        <div class="col-md-12">
                            <h2>Promotions</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">Economique</div>
                        <div class="col-md-6 offset-6">Business</div>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="row text-center">
                        <h2>Promotion</h2>
                    </div>
                    <div class="row">
                        <div class="col-md-6 text-center d-flex flex-column justify-content-center align-items-center">
                            <h4><%=v.getNbrEco()%> à -<%=v.getPromEco()%></h4>
                            <small>Economique</small>
                        </div>
                        <div class="col-md-6 text-center d-flex flex-column justify-content-center align-items-center">
                            <h4><%=v.getNbrBusi()%> à <%=v.getPromBusi()%></h4>
                            <small>Business</small>
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
                <% if (u != null) { %>
                <div class="position-absolute bottom-0 right-0 w-100 px-3 d-flex justify-content-end gap-4">
                    <a class="modification" href="${pageContext.request.contextPath}/update-vol?id=<%=v.getId()%>"><i
                            class="fa-solid fa-edit"></i></a>
                    <a class="modification" href="${pageContext.request.contextPath}/delete-vol?id=<%=v.getId()%>"><i
                            class="fa-solid fa-trash"></i></a>
                </div>
                <% } %>
            </div>
        </div>
    </div>
    <% } %>
</div>
