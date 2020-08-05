import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Config/config.dart';
import 'package:flutter_app/Screens/home_screen.dart';
import 'package:flutter_app/models/Auth.dart';
import 'package:flutter_app/models/AuthCode.dart';
import 'package:flutter_app/models/RestaurantDataItems.dart';
import 'package:flutter_app/models/addCardScreen.dart';
import 'package:flutter_app/models/user.dart';

Map<String,GlobalKey<OrderCheckingState>> orderCheckingStates = new Map<String,GlobalKey<OrderCheckingState>>();
//Map<String,GlobalKey<ChatMessageScreenState>> chatMessagesStates = new Map<String,GlobalKey<ChatMessageScreenState>>();
GlobalKey<HomeScreenState>homeScreenKey = new GlobalKey<HomeScreenState>(debugLabel: 'homeScreenKey');
var home  = new MaterialPageRoute(
  builder: (context) => new HomeScreen(),
);
RestaurantDataItems restaurantDataItems = null;
//GlobalKey<ChatScreenState>chatKey = new GlobalKey<ChatScreenState>();
AuthCodeData authCodeData = null;
AuthData authData = null;
String FCMToken = '';
int code = 0;
NecessaryDataForAuth necessaryDataForAuth = new NecessaryDataForAuth(phone_number: null, refresh_token: null, device_id: null, name: null);

var DeliveryStates = [
  'cooking',
  'offer_offered',
  'smart_distribution',
  'finding_driver',
  'offer_rejected',
  'order_start',
  'on_place',
  'waiting_for_confirmation',
  'on_the_way',
  'order_payment'
];

final addCart = AddCart(
  imageUrl: 'assets/images/restaurant1.jpg',
  name: 'Sandwich Street',);

// User
final currentUser = User(
  cartDataModel: null,
  name: '',
  orders: [
  ],
);