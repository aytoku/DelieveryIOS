import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/AuthCode.dart';
import 'package:flutter_app/models/CartDataModel.dart';
import 'package:flutter_app/models/ResponseData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CreateOrderTakeAway {
  String address;
  String comment;
  String delivery;
  CartDataModel cartDataModel;
  Records restaurant;

  CreateOrderTakeAway( {
    this.address,
    this.comment,
    this.delivery,
    this.cartDataModel,
    this.restaurant
  });

  sendRefreshToken() async{
    var url = 'https://client.apis.stage.faem.pro/api/v2/auth/refresh';
    var response = await http.post(url, body: jsonEncode({"refresh": authCodeData.refresh_token}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      authCodeData = AuthCodeData.fromJson(jsonResponse);
      //print(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    print(response.body);
  }

  Future sendData() async {
    await sendRefreshToken();
    print(authCodeData.token);
    var url = 'https://client.apis.stage.faem.pro/api/v2/orders';
    var response = await http.post(url, body: jsonEncode({
      "callback_phone": currentUser.phone,
      "increased_fare": 25,
      "comment": comment,
      "products_input": cartDataModel.toJson(),
      "routes": [
        restaurant.destination_points[0].toJson(),
      ],
      "service_uuid": "6b73e9e3-927b-453c-81c4-dfae818291f4",
    }), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Source':'ios_client_app_1',
      'Authorization':'Bearer ' + authCodeData.token
    });
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      http.Response suka = await http.get('https://client.apis.stage.faem.pro/api/v2/orders/' + jsonResponse['uuid'],
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Source':'ios_client_app_1',
            'Authorization':'Bearer ' + authCodeData.token
          });
      print(suka.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    print(response.body);
  }
}