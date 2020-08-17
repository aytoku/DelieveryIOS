import 'package:flutter/material.dart';
import 'package:flutter_app/PostData/getTicketByUuid.dart';
import 'package:flutter_app/PostData/sendTicketMessage.dart';
import 'package:flutter_svg/svg.dart';

import '../Internet/check_internet.dart';
import '../PostData/chat.dart';
import '../data/data.dart';
import '../data/data.dart';
import '../models/ChatHistoryModel.dart';
import '../models/TicketModel.dart';
import '../models/TicketModel.dart';
import 'home_screen.dart';

class TicketsChatScreen extends StatefulWidget {
  String order_uuid;

  TicketsChatScreen({Key key, this.order_uuid}) : super(key: key);

  @override
  TicketsChatScreenState createState() {
    return new TicketsChatScreenState(order_uuid);
  }
}

class TicketsChatScreenState extends State<TicketsChatScreen>
    with WidgetsBindingObserver {
  List<TicketsChatMessageScreen> chatMessageList;
  String order_uuid;

  TicketsChatScreenState(this.order_uuid);

  TextEditingController messageField = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

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

  buildChat() {
    //TicketsList ticketsList;
    /*List<String> messagedUuid = new List<String>();
    chatMessageList.forEach((element) {
      if (element.comment.to == 'client' &&
          element.comment.ack == false) {
        element.comment.ack = false;
        messagedUuid.add(element.comment.uuid);
      }
    });
    if (messagedUuid.length > 0) {
      Chat.readMessage(messagedUuid);
    }*/
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Stack(children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: 0, top: 30),
                              child: Container(
                                  height: 40,
                                  width: 60,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 12, bottom: 12, right: 10),
                                    child: SvgPicture.asset(
                                        'assets/svg_images/arrow_left.svg'),
                                  )))),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => new HomeScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 40, left: 0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Обращение',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ))
              ]),
            ),
            Align(
                alignment: Alignment.center,
                child: Container(
                  height: 470,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: chatMessageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return chatMessageList[index];
                      },
                      //chatMessageList
                    ),
                  ),
                )),
            Positioned(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: MediaQuery.of(context).viewInsets.left,
              right: MediaQuery.of(context).viewInsets.right,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: 40, bottom: 0, right: 15, left: 15),
                      child: Container(
                        height: 40,
                        child: TextField(
                          controller: messageField,
                          decoration: InputDecoration(
                            suffix: GestureDetector(
                              child: SvgPicture.asset(
                                  'assets/svg_images/send_message.svg'),
                              onTap: () async {
                                if (await Internet.checkConnection()) {
                                  var message = await sendTicketMessage(
                                    order_uuid,
                                    messageField.text,
                                  );
                                  setState(() {
                                    GlobalKey<TicketsChatMessageScreenState>
                                    chatMessageScreenStateKey = new GlobalKey<
                                        TicketsChatMessageScreenState>();
                                    //ticketsChatMessagesStates[message.uuid] =
                                    //    chatMessageScreenStateKey;
                                    chatMessageList.add(
                                        new TicketsChatMessageScreen(
                                            key: chatMessageScreenStateKey,
                                            comment: new Comment(
                                                createdAtUnix: DateTime.now().microsecond,
                                                message: messageField.text,
                                                senderType: 'client')));
                                  });
                                } else {
                                  noConnection(context);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (chatMessageList != null) {
      print(chatMessageList.length);
      return buildChat();
    }
    return FutureBuilder<TicketsListRecord>(
      future: getTicketByUuid(order_uuid),
      builder:
          (BuildContext context, AsyncSnapshot<TicketsListRecord> snapshot) {
        print('tututuwapatututuwapa ' + order_uuid);
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          //ticketsChatMessagesStates.clear();
          chatMessageList = new List<TicketsChatMessageScreen>();
          chatMessageList.add(new TicketsChatMessageScreen(comment: new Comment(
              senderType: 'client',
              message: snapshot.data.description,
              createdAtUnix: snapshot.data.createdAtUnix
          ),));
          if(snapshot.data.comments != null)
            snapshot.data.comments.forEach((element) {
              GlobalKey<ChatMessageScreenState> chatMessageScreenStateKey =
              new GlobalKey<ChatMessageScreenState>();
              //ticketsChatMessagesStates[element.uuid] = chatMessageScreenStateKey;
              chatMessageList.add(new TicketsChatMessageScreen(
                  comment: element, key: chatMessageScreenStateKey));
            });
          return buildChat();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// ignore: must_be_immutable
class TicketsChatMessageScreen extends StatefulWidget {
  Comment comment;

  TicketsChatMessageScreen({Key key, this.comment}) : super(key: key);

  @override
  TicketsChatMessageScreenState createState() {
    return new TicketsChatMessageScreenState(comment);
  }
}

class TicketsChatMessageScreenState extends State<TicketsChatMessageScreen> {
  Comment chatMessage;

  TicketsChatMessageScreenState(this.chatMessage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          (chatMessage.senderType != 'client')
              ? Padding(
            padding: EdgeInsets.only(right: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFE5E6EA),
                        borderRadius: BorderRadius.circular(17.0),
                        border: Border.all(
                            width: 1.0, color: Color(0xFFE5E6EA))),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        chatMessage.message,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            decoration: TextDecoration.none),
                      ),
                    )),
              ),
            ),
          )
              : Padding(
            padding: EdgeInsets.only(left: 15),
            child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFFC5B58),
                          borderRadius: BorderRadius.circular(17.0),
                          border: Border.all(
                              width: 1.0, color: Color(0xFFFC5B58))),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          chatMessage.message,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              decoration: TextDecoration.none),
                        ),
                      )),
                )),
          ),
        ],
      ),
    );
  }
}