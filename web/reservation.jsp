<%--
  Created by IntelliJ IDEA.
  User: miarantsoa
  Date: 01/03/2025
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="models.*" %>

<%
    Vol v = (Vol) request.getAttribute("vol");
    List<PrixVol> prix = (List<PrixVol>) request.getAttribute("prix");
    DateFormat sdf = new SimpleDateFormat("EEE dd MMM yyyy HH:mm:ss", Locale.FRENCH);
    User u = null;
    if (session.getAttribute("user") != null) {
        u = (User) session.getAttribute("user");
    }
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM dd, yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
    String dateDepartStr = dateFormat.format(v.getDateDepart());
    String heureDepartStr = timeFormat.format(v.getDateDepart());
    String dateArriveeStr = dateFormat.format(v.getDateArrivee());
    String heureArriveeStr = timeFormat.format(v.getDateArrivee());
%>

<div class="col-md-12 mb-5">
    <div class="card mt-3 py-3 px-2">
        <form action="${pageContext.request.contextPath}/booking" method="post" enctype="multipart/form-data">
            <input type="hidden" name="res.idVol" value="<%=v.getId()%>">
            <input type="hidden" name="res.idClient" value="<%=u.getId()%>">
        <div class="flight-info">
            <div class="position-relative mt-4">
                <div class="row g-3">
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
                                <h2>Promotions (place - %)</h2>
                            </div>
                            <div class="row">
                                <div class="col-md-6 text-center d-flex flex-column justify-content-center align-items-center">
                                    <h4><%=v.getNbrEco()%> à -<%=v.getPromEco()%>%</h4>
                                    <small>Economique</small>
                                </div>
                                <div class="col-md-6 text-center d-flex flex-column justify-content-center align-items-center">
                                    <h4><%=v.getNbrBusi()%> à -<%=v.getPromBusi()%>%</h4>
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
                        <div class="row w-100 d-flex justify-content-center align-items-center">
                            <div class="border border-gray w-75 mt-3"></div>
                        </div>
                        <div class="row mt-5">
                            <div class="row text-center">
                                <h2>Choisir la classe à prendre</h2>
                            </div>
                            <div class="row">
                                <div class="col-md-6 text-center">
                                    <input type="radio" id="economique" name="res.classe" value="TSIEGE001">
                                    <label for="economique">Economique</label>
                                </div>
                                <div class="col-md-6 text-center">
                                    <input type="radio" id="business" name="res.classe" value="TSIEGE002">
                                    <label for="business">Business</label>
                                </div>
                            </div>
                        </div>
                    </div>
                <div class="offset-md-1 col-md-3 border border-gray p-3 d-flex flex-column">
                    <div class="row w-100">
                        <div class="col-md-12">
                            <label class="d-flex align-items-center justify-content-center flex-row gap-2" style="cursor: pointer;" for="passport">
                                <span class="text-xl-center"><i class="fa-solid fa-camera"></i></span>
                                <span class="text-xl-center">Votre passport</span>
                            </label>
                            <input type="file" style="display: none" name="res.passport" id="passport">
                            <p class="text-center text-wrap mt-3" id="file-name"></p>
                        </div>
                    </div>
                    <div class="row w-100 mt-3">
                        <div class="col-md-12">
                            <div id="price-info" class="text-center mt-3 fs-4"></div>
                        </div>
                    </div>
                    <div class="row w-100 mt-auto">
                        <div class="row">
                            <div class="col-md-12">
                                <label for="res.dateResa">Réservation du</label>
                                <input type="datetime-local" name="res.dateResa" id="res.dateResa" class="form-control">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 mt-4 d-flex align-items-center justify-content-center">
                                <button class="btn btn-confirmation w-100" type="submit">Réserver</button>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
            </div>
        </div>
        </form>
    </div>
</div>

<script>
    document.getElementById('passport').addEventListener('change', function(event) {
        document.getElementById('file-name').textContent = event.target.files[0].name;
    });

    const radioButtons = document.querySelectorAll('input[name="res.classe"]');
    const priceInfo = document.getElementById('price-info');

    radioButtons.forEach(radio => {
        radio.addEventListener('change', function() {
            let selectedClass = this.value;
            let selectedPrice = 0;
            let selectedPromotion = 0;
            let modifiedPrice = 0;

            if (selectedClass === 'TSIEGE001') {
                selectedPrice += <%= prix.get(0).getPrix() %>;
                if(<%=v.getNbrEco()%> > 0) {
                    selectedPromotion += <%= v.getPromEco() %>;
                }
            } else if (selectedClass === 'TSIEGE002') {
                selectedPrice += <%= prix.get(1).getPrix() %>;
                if(<%=v.getNbrBusi()%> > 0) {
                    selectedPromotion += <%= v.getPromBusi() %>;
                }
            }

            if(selectedPromotion !== 0) {
                modifiedPrice = selectedPrice - (selectedPrice * selectedPromotion / 100);
                priceInfo.innerHTML = 'Prix de base: <del>'+selectedPrice+'</del><br>Prix modifié: '+modifiedPrice+' <br>Promotion: '+selectedPromotion+' %';
            } else {
                priceInfo.innerHTML = 'Prix de base: '+selectedPrice+' <br>Promotion: '+selectedPromotion+' %';
            }
        });
    });
</script>