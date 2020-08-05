import 'package:flutter/material.dart';

class ModalTrigger extends StatelessWidget {
  _showModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child:  Align(
            child: Padding(
              padding: EdgeInsets.only(right: 0),
              child: Column(
                children: <Widget>[
                  new FlatButton(
                    child: Row(
                      children: <Widget>[
                        Image(image: AssetImage('assets/dollar.png'),),
                        Padding(
                          padding: EdgeInsets.only(right: 0, left: 15),
                          child: Text("Наличными", style: TextStyle(color: Colors.black),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 160),
                          child:
                          Image(image: AssetImage('assets/check_box.png'),),
                        ),
                      ],
                    ),
                    onPressed: () {
                    },
                  ),
                  new FlatButton(
                    child: Row(
                      children: <Widget>[
                        Image(image: AssetImage('assets/play.png'),),
                        Padding(
                          padding: EdgeInsets.only(right: 0, left: 15),
                          child: Text("Apple Pay", style: TextStyle(color: Colors.black),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 180),
                          child:
                          Image(image: AssetImage('assets/check_box.png'),),
                        ),
                      ],
                    ),
                    onPressed: () {
                    },
                  ),
                  new FlatButton(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 90),
                          child: Text("Другой картой", style: TextStyle(color: Colors.black),),
                        ),
                      ],
                    ),
                    onPressed: () {
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            _showModalBottomSheet(context);
          },
          child:Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
            child: Row(
              children: <Widget>[
                Image(image: AssetImage('assets/images/card.png'),),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("VISA ****8744", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black),),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 170),
                  child: Image(image: AssetImage('assets/images/arrow_right.png'),),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}