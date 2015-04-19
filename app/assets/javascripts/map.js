

/*$(document).ready(function () {
 alert("Hello world!");
 });*/

var rendererOptions = {
    suppressMarkers : true

    /*markerOptions: {
     icon: "http://icdn.pro/images/es/c/o/coche-de-transporte-de-ambulancia-de-emergencia-del-vehiculo-icono-6274-96.png"
     }*/
};


var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
var map;
var current_location;
var barrios;
var repvalues;

function loadMap(){
    var mapOptions = {
        center: current_location,
        zoom:17
    };
    map = new google.maps.Map(document.getElementById('map-container'), mapOptions);
    drawParent(barrios);
    drawZones(repvalues);
}

var p;
function initialize(b, r) {
    barrios = b;
    repvalues = r;
    if(navigator.geolocation) {
        console.log("has geolocation" );
        navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
    } else {
        // Browser doesn't support Geolocation
        handleNoGeolocation();
    }

    function successCallback(position) {
        p = position;
        console.log("geolocation obtained " + position);
        current_location = new google.maps.LatLng(position.coords.latitude,
            position.coords.longitude);

        loadMap();
    }

    function errorCallback(){
        handleNoGeolocation();
    }


    function handleNoGeolocation(){
        console.log("no geolocation");
        current_location = new google.maps.LatLng(40.452666, -3.678407);
        loadMap();
    }


}
function drawParent(zones){
    for (key in zones.params.zones) {
        var geometry = zones.params.zones[key].shape;
        var coordinates = geometry.coordinates[0];
        console.log(zones.params.zones[key]);
       // map.data.loadGeoJson(geometry);

        var polygonCoords = [];
        for (var i = 0; i < coordinates.length; i++ ){
            polygonCoords.push(new google.maps.LatLng(coordinates[i][0], coordinates[i][1]));
        }
        //console.log(polygonCoords);
        // Construct the polygon.
        var polygon = new google.maps.Polygon({
            paths: polygonCoords,
            strokeColor: '#FF0000',
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillColor: '#FF0000',
            fillOpacity: 0.35,
            map: map
        });


    }

}
function drawZones(zones) {


    console.log(zones);
    for (key in zones.params.zones) {
        var geometry = zones.params.zones[key].shape;
        var coordinates = geometry.coordinates;
        //console.log(geometry);
        //console.log(coordinates);

        var color = '#' + (function co(lor) {
                return (lor +=
                    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'a', 'b', 'c', 'd', 'e', 'f'][Math.floor(Math.random() * 16)])
                && (lor.length == 6) ? lor : co(lor);
            })('');

        var center = new google.maps.LatLng(coordinates[0], coordinates[1]);

        var circleOptions = {
            strokeColor: color,
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillColor: color,
            fillOpacity: 0.35,
            map: map,
            center: center,
            radius: 30
        };
        // Add the circle for this city to the map.
        lightCircle = new google.maps.Circle(circleOptions);

        var marker = new google.maps.Marker({
            position: center,
            map: map,
            icon: "http://www.basicgo.com/bundles/basicgo/frontend/imagenes/exclamacionAviso.png",
            customInfo: JSON.parse(zones.params.zones[key].data_info.data)
        });
        google.maps.event.addListener(marker, 'click', function() {
            console.log(marker.customInfo);
            var modal = $('#valoration-modal');
            var img =   $('<img class="text-center">');
            img.attr('src', this.customInfo.foto);
            $('#valoration-modal-body').html('').append(img).append(this.customInfo.texto);
            modal.modal('show');
        });

    }

}

//google.maps.event.addDomListener(window, 'load', initialize);
