import 'package:flutter/material.dart';

class PickList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          PickListView(
            name: 'Сэндвичи',
          ),
          PickListView(
            name: 'Салаты',
          ),
          PickListView(
            name: 'Десерт',
          ),
          PickListView(
            name: 'Напитки',
          ),
        ],
      ),
    );
  }
}

class PickListView extends StatelessWidget{

  final String name;
  PickListView({this.name});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Card(
        child: ListTile(
          onTap: () {
          },
          title: Text(
            name,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}