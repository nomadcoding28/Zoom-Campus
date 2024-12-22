import 'package:http/http.dart';
import 'dart:convert';
// Assume this contains the User model.
import '../data/data.dart';

Future login(String mail, String password) async {
  var client = Client();
  final response = await client.post(
    Uri.http("192.168.31.48:8000","/login/"),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({"mail":mail, "password":password}),
  );

  if (response.statusCode != 200) {
    // print();
    // print("FAil\n\n\n\n");
    throw Exception('Failed to register user');
  }else if(response.statusCode == 200){
    print("\n\n\n\LogIN\n\n\n\n");
    
  }
}

Future<void> registerUser(Map<String, dynamic> registrationData) async {
  // String url = "http://"+ip+"/riderregister/";
  var client = Client();
  final response = await client.post(
    Uri.http("192.168.31.48:8000","/signup/"),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(registrationData),
  );

  if (response.statusCode != 200) {
    print(registrationData);
    print("FAil\n\n\n\n");
    throw Exception('Failed to register user');
  }else if(response.statusCode == 200){
    print("\n\n\n\nRegistered\n\n\n\n");
  }
}



Future<int> riderregistercheck() async {
  // String url = "http://"+ip+"/riderregister/";
  var client = Client();
  final response = await client.post(
    Uri.http("192.168.31.48:8000","/ridercheck/"),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({"mail":mail}),
  );

  if (response.statusCode != 200) {
    print("FAil\n\n\n\n");
    return 0;
  }else if(response.statusCode == 200){
    print("\n\n\n\nRegistered\n\n\n\n");
    return 1;
  }
  return 0;
}

Future<int> riderAccept() async {
  // String url = "http://"+ip+"/riderregister/";
  var client = Client();
  final response = await client.post(
    Uri.http("192.168.31.48:8000","/riderAcceptRide/"),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({"mail":mail}),
  );

  if (response.statusCode != 200) {
    print("FAil\n\n\n\n");
    return 0;
  }else if(response.statusCode == 200){
    print("\n\n\n\nRide Accepted\n\n\n\n");
    return 1;
  }
  return 0;
}


Future<int> coriderRequest(String rider_mail) async {
  // String url = "http://"+ip+"/riderregister/";
  var client = Client();
  final response = await client.post(
    Uri.http("192.168.31.48:8000","/reqRider/"),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({"mail":mail, "rider_mail":rider_mail}),
  );

  if (response.statusCode != 200) {
    print("FAil\n\n\n\n");
    return 0;
  }else if(response.statusCode == 200){
    print("\n\n\n\nRide Accepted\n\n\n\n");
    return 1;
  }
  return 0;
}




// Future registerUser(Map<String, dynamic> registrationData) async {
//   final Client httpClient;
//   if (Platform.isAndroid) {
//     final engine = CronetEngine.build(
//         cacheMode: CacheMode.memory,
//         cacheMaxSize: 2 * 1024 * 1024,
//         userAgent: 'Book Agent');
//     httpClient = CronetClient.fromCronetEngine(engine, closeEngine: true);
//   } else {
//     httpClient = IOClient(HttpClient()..userAgent = 'Book Agent');
//   }

//   final response = await client.get(
//     Uri.https(
//       'www.googleapis.com',
//       '/books/v1/volumes',
//       {'q': 'HTTP', 'maxResults': '40', 'printType': 'books'},
//     ),
//   );
//   httpClient.close();
// }



// Future<void> temp(Map<String, String> registrationData) async {
//     // List<int> i = [192,168,31,48]; 
//     String url = "localhost:8000"+"/rider/";
//     var client = http.Client();
//   final response = await client.post(
//     Uri.http("192.168.31.48:8000","/rider/") ,
//     headers: <String, String>{
//       'Content-Type': 'application/json',
//     },
//     // body: jsonEncode(registrationData),
//   );

//   if (response.statusCode != 200) {
//     throw Exception('\n\n\n\nFailed to register user\n\n\n\n');
//   }else if(response.statusCode == 200){
//     print("\n\n\n\nRegistered\n\n\n\n");
//   }
// }
