// https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248a9782188b11c4d9794307df180180306&start=8.681495,49.41461&end=8.687872,49.420318
const String url = "https://api.openrouteservice.org/v2/directions/driving-car";
const String apiKey =
    "5b3ce3597851110001cf6248a9782188b11c4d9794307df180180306";
getRouteUrl(String startPoint, String endPoint) {
  return Uri.parse('$url?api_key=$apiKey&start=$startPoint&end=$endPoint');
}