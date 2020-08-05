//import 'dart:ffi';
//import 'dart:io';
//
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:food_delivery/PostData/current_data_about_order.dart';
//import 'package:food_delivery/PostData/fcm.dart';
//import 'package:food_delivery/data/data.dart';
//import 'package:food_delivery/models/ChatHistoryModel.dart';
//import 'package:food_delivery/models/OrderStoryModel.dart';
//import 'package:food_delivery/screens/home_screen.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert' as convert;
//
//class FirebaseNotifications {
//  FirebaseMessaging _firebaseMessaging;
//
//  Future setUpFirebase() async{
//    _firebaseMessaging = FirebaseMessaging();
//    await firebaseCloudMessaging_Listeners();
//  }
//
//  // ignore: missing_return
//  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
//    print(message);
//    print('EXPLOOOOSION');
//    messageHandler(message);
//  }
//
//  static Future<void> OrderCheckingUpdater(String order_uuid, String order_state) async {
//    print('vnature' + homeScreenKey.currentState.toString());
//    if(homeScreenKey.currentState != null && homeScreenKey.currentState.orderList != null
//        && !DeliveryStates.contains(order_state)){
//      homeScreenKey.currentState.orderList.removeWhere((element) => element.ordersStoryModelItem.uuid == order_uuid);
//      if(homeScreenKey.currentState.orderList.length == 0)
//        homeScreenKey.currentState.setState(() { });
//    }
//    if(orderCheckingStates.containsKey(order_uuid)) {
//      if(orderCheckingStates[order_uuid].currentState != null) {
//        orderCheckingStates[order_uuid].currentState.setState(() {
//          orderCheckingStates[order_uuid].currentState.ordersStoryModelItem
//              .state = order_state;
//        });
//      } else {
//        if(homeScreenKey.currentState != null && homeScreenKey.currentState.orderList != null) {
//          homeScreenKey.currentState.orderList.forEach((element) {
//            if(element.ordersStoryModelItem.uuid == order_uuid) {
//              element.ordersStoryModelItem.state = order_state;
//              return;
//            }
//          });
//        }
//      }
//    }
//  }
//
//  static void messageHandler(Map<String, dynamic> message) async {
//    if (message.containsKey('data')) {
//      var data =  message['data'];
//      if(data.containsKey('tag')) {
//        switch (data['tag']){
//          case 'order_state' :
//            var payload = convert.jsonDecode(data['payload']);
//            String order_state = payload['state'];
//            String order_uuid = payload['order_uuid'];
//            print('containwsadsfsdfgsdfg');
//            OrderCheckingUpdater(order_uuid, order_state);
//            break;
//
//          case 'chat_message' :
//            var payload = convert.jsonDecode(data['payload']);
//            var message = ChatMessage.fromJson(payload);
//            if(chatKey.currentState != null){
//              chatKey.currentState.setState(() {
//                chatKey.currentState.chatMessageList.insert(0, new ChatMessageScreen(chatMessage: message, key: new ObjectKey(message)));
//              });
//            }
//            //OrderCheckingUpdater(order_uuid, order_state);
//            break;
//
//          case 'chat_messages_read' :
//            var payload = convert.jsonDecode(data['payload']);
//            List<dynamic> messagesUuid = payload['messages_uuid'];
//            if(chatKey.currentState != null && chatKey.currentState.order_uuid == payload['order_uuid']){
//              messagesUuid.forEach((element) {
//                if(chatMessagesStates.containsKey(element)){
//                  // ignore: invalid_use_of_protected_member
//                  if(chatMessagesStates[element].currentState != null) {
//                    chatMessagesStates[element].currentState.setState(() {
//                      print('uznovaemi ' + element);
//                      chatMessagesStates[element].currentState.chatMessage.ack = true;
//                    });
//                  } else {
//                    chatKey.currentState.chatMessageList.forEach((message) {
//                      if(message.chatMessage.uuid == element) {
//                        message.chatMessage.ack = true;
//                        return;
//                      }
//                    });
//                  }
//                }
//              });
//            }
//            break;
//        }
//      }
//    }
//  }
//
//  void firebaseCloudMessaging_Listeners() async{
//    if (Platform.isIOS) iOS_Permission();
//    var token = await _firebaseMessaging.getToken();
//    FCMToken = token;
//    await sendFCMToken(token);
//    print('DAITE MNE TOKEN   ' + token);
//
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print('on message $message');
//        await messageHandler(message);
//      },
//      onBackgroundMessage: myBackgroundMessageHandler,
//      onResume: (Map<String, dynamic> message) async {
//        print('on resume $message');
//        await messageHandler(message);
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        print('on launch $message');
//        await messageHandler(message);
//      },
//    );
//  }
//
//  void iOS_Permission() {
//    _firebaseMessaging.requestNotificationPermissions(
//        IosNotificationSettings(sound: true, badge: true, alert: true));
//    _firebaseMessaging.onIosSettingsRegistered
//        .listen((IosNotificationSettings settings) {
//      print("Settings registered: $settings");
//    });
//  }
//}