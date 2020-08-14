import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Internet/check_internet.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

class AboutAppScreen extends StatefulWidget {
  @override
  AboutAppScreenState createState() => AboutAppScreenState();
}

class AboutAppScreenState extends State<AboutAppScreen> {
  noConnection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
              height: 50,
              width: 100,
              child: Center(
                child: Text("Нет подключения к интернету"),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                            child: Container(
                                height: 50,
                                width: 55,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 17, bottom: 17, right: 10),
                                  child: SvgPicture.asset(
                                      'assets/svg_images/arrow_left.svg'),
                                )),
                            onTap: (){
                              Navigator.pop(context);
                            }
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "Служба поддержки",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF424242)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Column(
                      children: <Widget>[
                        Flexible(
                            flex: 2,
                            child: Column(
                              children: <Widget>[
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20, bottom: 10),
                                    child: Image(
                                      image: AssetImage('assets/images/faem_icon.png'),
                                    )
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 25),
                                  child: Center(
                                    child: Text(
                                      'Версия 4.95 от 25 авг. 2019 г.\nсборка 34234',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Color(0x97979797), fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                          height: 30,
                          color: Color(0xFFF9F9F9),
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Лицензионное соглашение',
                                            style:
                                            TextStyle(fontSize: 17, color: Color(0xFF424242))),
                                        GestureDetector(
                                          child:
                                          SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    if (await Internet.checkConnection()) {
                                      if (await canLaunch("https://faem.ru/legal/agreement")) {
                                        await launch("https://faem.ru/legal/agreement");
                                      }
                                    } else {
                                      noConnection(context);
                                    }
                                  },
                                ),
                              ),
                              Divider(height: 1.0, color: Colors.grey),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Политика конфиденцальности',
                                            style:
                                            TextStyle(fontSize: 17, color: Color(0xFF424242))),
                                        GestureDetector(
                                          child:
                                          SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    if (await Internet.checkConnection()) {
                                      if (await canLaunch("https://faem.ru/privacy")) {
                                        await launch("https://faem.ru/privacy");
                                      }
                                    } else {
                                      noConnection(context);
                                    }
                                  },
                                ),
                              ),
                              Divider(height: 1.0, color: Colors.grey),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 15),
                  child: Text(
                    'Таким образом новая модель организационной\nдеятельности представляет собой интересный\nэксперимент проверки. \n@ 2011-2019 ООО «Faem.Taxi»',
                    style: TextStyle(color: Color(0x97979797), fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}