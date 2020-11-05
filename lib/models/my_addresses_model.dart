import 'package:flutter_app/models/ResponseData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../data/data.dart';
import 'CreateOrderModel.dart';

class MyFavouriteAddressesModel{
  // Список возможных тегов
  // null = empty
  static const List<String> MyAddressesTags = ["work","house","study", null];

  String uuid;
  FavouriteAddress address;
  String name;
  String description;
  String tag;
  String clientUuid;

  MyFavouriteAddressesModel( {
    this.address,
    this.name,
    this.description,
    this.uuid,
    this.tag,
    this.clientUuid
  });

  Future<MyFavouriteAddressesModel> ifNoBrainsSave() async{
    if(name == "")
      name = "";
    if(uuid == null || uuid == "")
      return await save();
    else
      return await update();
  }

  Future<MyFavouriteAddressesModel> save() async{
    // Обновляем токен
    await CreateOrder.sendRefreshToken();
    // Отправляем данные на сервер
    MyFavouriteAddressesModel result;
    var jsonRequest = convert.jsonEncode(this.toServerSaveJson());
    var url = 'https://client.apis.stage.faem.pro/api/v2/addresses/favorite';
    var response = await http.post(url, body: jsonRequest, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Source':'ios_client_app_1',
      'Authorization':'Bearer ' + authCodeData.token
    });
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(response.body);
      result = MyFavouriteAddressesModel.fromJson(jsonResponse);
    } else {
      print(response.body);
      print('Request failed with status: ${response.statusCode}.');
    }
    return result;
  }

  Future<MyFavouriteAddressesModel> update() async{
    // Обновляем токен
    await CreateOrder.sendRefreshToken();
    // Отправляем данные на сервер
    MyFavouriteAddressesModel result;
    var jsonRequest = convert.jsonEncode(this.toServerSaveJson());
    var url = 'https://client.apis.stage.faem.pro/api/v2/addresses/favorite/$uuid';
    var response = await http.put(url, body: jsonRequest, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Source':'ios_client_app_1',
      'Authorization':'Bearer ' + authCodeData.token
    });
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      result = MyFavouriteAddressesModel.fromJson(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return result;
  }

  Future<void> delete() async{
    // Обновляем токен
    await CreateOrder.sendRefreshToken();
    // Отправляем данные на сервер
    var url = 'https://client.apis.stage.faem.pro/api/v2/addresses/favorite/$uuid';
    var response = await http.delete(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Source':'ios_client_app_1',
      'Authorization':'Bearer ' + authCodeData.token
    });
    if (response.statusCode == 200) {
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Future<List<MyFavouriteAddressesModel>> getAddresses() async{
    List<MyFavouriteAddressesModel> addressesList;
    // Обновляем токен
    await CreateOrder.sendRefreshToken();
    // Получаем данные с сервера
    var url = 'https://client.apis.stage.faem.pro/api/v2/addresses/favorite';
    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Source':'ios_client_app_1',
      'Authorization':'Bearer ' + authCodeData.token
    });
    var jsonResponse;
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body) as List;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    addressesList = new List<MyFavouriteAddressesModel>();
    // Если что-то пошло не так, возвращаем пустой список
    if(jsonResponse == null)
      return addressesList;
    // Иначе возвращаем заполненный
    addressesList = jsonResponse.map<MyFavouriteAddressesModel>((i) =>
        MyFavouriteAddressesModel.fromJson(i)).toList();
    return addressesList;
  }

  Map<String, dynamic> toServerSaveJson() => {
    "name": name,
    "description": description,
    "tag": tag,
    "address": address.toJson(),
  };

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "description": description,
    "tag": tag,
    "client_uuid": clientUuid,
    "address": address.toJson(),
  };

  factory MyFavouriteAddressesModel.fromJson(Map<String, dynamic> parsedJson){
    return new MyFavouriteAddressesModel(
      address:FavouriteAddress.fromJson(parsedJson['address']),
      uuid: parsedJson["uuid"],
      name: parsedJson["name"],
      description: parsedJson["description"],
      tag: parsedJson["tag"],
      clientUuid: parsedJson["client_uuid"],
    );
  }
}

class FavouriteAddress {
  FavouriteAddress({
    this.unrestrictedValue,
    this.value,
    this.country,
    this.region,
    this.regionType,
    this.type,
    this.city,
    this.cityType,
    this.street,
    this.streetType,
    this.streetWithType,
    this.house,
    this.frontDoor,
    this.outOfTown,
    this.houseType,
    this.accuracyLevel,
    this.radius,
    this.lat,
    this.lon,
  });

  String unrestrictedValue;
  String value;
  String country;
  String region;
  String regionType;
  String type;
  String city;
  String cityType;
  String street;
  String streetType;
  String streetWithType;
  String house;
  int frontDoor;
  bool outOfTown;
  String houseType;
  int accuracyLevel;
  int radius;
  double lat;
  double lon;

  factory FavouriteAddress.fromJson(Map<String, dynamic> json) => FavouriteAddress(
    unrestrictedValue: json["unrestricted_value"],
    value: json["value"],
    country: json["country"],
    region: json["region"],
    regionType: json["region_type"],
    type: json["type"],
    city: json["city"],
    cityType: json["city_type"],
    street: json["street"],
    streetType: json["street_type"],
    streetWithType: json["street_with_type"],
    house: json["house"],
    frontDoor: json["front_door"],
    outOfTown: json["out_of_town"],
    houseType: json["house_type"],
    accuracyLevel: json["accuracy_level"],
    radius: json["radius"],
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "unrestricted_value": unrestrictedValue,
    "value": value,
    "country": country,
    "region": region,
    "region_type": regionType,
    "type": type,
    "city": city,
    "city_type": cityType,
    "street": street,
    "street_type": streetType,
    "street_with_type": streetWithType,
    "house": house,
    "front_door": frontDoor,
    "out_of_town": outOfTown,
    "house_type": houseType,
    "accuracy_level": accuracyLevel,
    "radius": radius,
    "lat": lat,
    "lon": lon,
  };
  factory FavouriteAddress.fromDestinationPoint(DestinationPoints destinationPoints){
    return new FavouriteAddress(
        unrestrictedValue: destinationPoints.unrestricted_value,
        value:destinationPoints.value,
        country: destinationPoints.country,
        region: destinationPoints.region,
        regionType: destinationPoints.region_type,
        type: destinationPoints.type,
        city: destinationPoints.city,
        cityType: destinationPoints.city_type,
        street: destinationPoints.street,
        streetType: destinationPoints.street_type,
        streetWithType: destinationPoints.street_with_type,
        house: destinationPoints.house,
        frontDoor: destinationPoints.front_door,
        outOfTown: destinationPoints.out_of_town,
        houseType: destinationPoints.house_type,
        accuracyLevel: destinationPoints.accuracy_level,
        radius: destinationPoints.radius,
        lat: destinationPoints.lat,
        lon: destinationPoints.lon
    );
  }
}