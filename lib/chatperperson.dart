import 'dart:async';

import 'package:bookresell/dataofperson.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chatperperson extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ChatOne();
  }
}

class ChatOne extends State<StatefulWidget> {
  String from=CurrentChat.from_id;
  String to=CurrentChat.to_id;
  String curmessage;
  var messages=[];
  final textcontrol=TextEditingController();
  var databaseinstance=FirebaseDatabase.instance;
  Future <void> refresh_messages() async{
    messages=[];
    print(from+" "+to);
    var heremessage=await databaseinstance.reference().child('User').child(from).child("messages").child(to).once();
    Timer(Duration(seconds: 1), () {
      refresh_messages();
      var mapofmessage=heremessage.value;
      mapofmessage.forEach((a,b)=>{messages.add([a,b])});
      messages.sort((a,b)=>a[0].compareTo(b[0]));
      print(messages);
      setState(() {

      });
    });
  }

  Future <void> add_message(String text) async{
    textcontrol.clear();
    await databaseinstance.reference().child("User").child(from).child("messages").child(to).child(DateTime.now().millisecondsSinceEpoch.toString()+"_from").set(text);
    await databaseinstance.reference().child("User").child(to).child("messages").child(from).child(DateTime.now().millisecondsSinceEpoch.toString()+"_to").set(text);
  }
  @override
  void initState() {
    refresh_messages();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff444B6E),
        body: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10,30, 10, 10),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                        color: Color(0xff9AB87A),
                        child:Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: Text(CurrentChat.to_name[0].toUpperCase()) ,
                              ),
                              Text(CurrentChat.to_name, style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 30
                              )
                              ),
                            ],
                          ),
                        )
                      )
                ),
                Expanded(
                  flex: 7,
                  child: SizedBox(
                    height: 500,
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context,idx){
                            return Padding(
                              padding: messages[idx][0][messages[idx][0].length-1]=='m'?EdgeInsets.fromLTRB(100,10,10,10):EdgeInsets.fromLTRB(10,10,100,10),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffF8F991),
                                    borderRadius: messages[idx][0][messages[idx][0].length-1]=='m'?BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(0),
                                      bottomLeft:  Radius.circular(20),
                                      bottomRight:  Radius.circular(20),
                                    ):
                                    BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(20),
                                      bottomLeft:  Radius.circular(20),
                                      bottomRight:  Radius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child:  Center(
                                        child:Text(messages[idx][1])
                                    ),
                                  )
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex:1,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 100,
                          child: TextField(
                            onChanged: (text)=>{curmessage=text},
                            controller: textcontrol,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child:  SizedBox(
                            height: 50,
                            child:RaisedButton(
                                color: Color(0xff6592B8),
                                onPressed: ()=>{add_message(curmessage)},
                                child:Text("Send Message")
                            )
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}