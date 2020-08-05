import 'package:flutter_app/models/CartDataModel.dart';
import 'package:flutter_app/models/order.dart';

import 'CreateOrderModel.dart';

class User{
  bool isLoggedIn;
  String name;
  final List<Order> orders;
  CartDataModel cartDataModel;
  String phone;

  User({
    this.isLoggedIn = true,
    this.name,
    this.orders,
    this.cartDataModel,
    this.phone
  });
}