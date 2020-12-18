import 'dart:async';

import 'package:bookresell/dataofperson.dart';
import 'package:firebase_database/firebase_database.dart';
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
    var heremessage=await databaseinstance.reference().child('User').child(from).child("messages").child(to).once();
    Timer(Duration(seconds: 3), () {
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
      home: Scaffold(
        body: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0,30, 0, 10),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text(to)
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 500,
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context,idx){
                            return Container(
                                child: Center(
                                    child:Text(messages[idx][1])
                                )
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
                            height: 100,
                            child:RaisedButton(
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