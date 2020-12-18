import 'package:bookresell/chatperperson.dart';
import 'package:bookresell/dataofperson.dart';
import 'package:bookresell/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Chats extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Chatsdata();
  }
}

class Chatsdata extends State<StatefulWidget> {
  var message_user_id=[];
  var message_user_name=[];
  void chatwith(idx){
    CurrentChat.from_id=CurrentUser.id;
    CurrentChat.to_id=message_user_id[idx];
    Navigator.of(context).pushNamed('/chat');
  }
  Future <void> getpeople() async{
    FirebaseDatabase fd=FirebaseDatabase.instance;
    message_user_id=[];
    message_user_name=[];
    var res=await fd.reference().child('User').child(CurrentUser.id).child('messages').once();
    res.value.forEach((x,y)=>{
      if(x!=CurrentUser.id) message_user_id.add(x)
    });
    for(int i=0;i<message_user_id.length;i++) {
      message_user_name.add(await Getname.getname(message_user_id[i]));
    }
    print(message_user_id);
    print(message_user_name);
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getpeople();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Padding(
        padding: EdgeInsets.fromLTRB(0,20,0,0),
        child: LiquidPullToRefresh(
          onRefresh: getpeople,
          child:  ListView.builder(
              itemCount: message_user_name.length,
              itemBuilder: (context,idx){
                return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide()
                      ),
                    ),
                    child:ListTile(
                        leading: CircleAvatar(
                          child: Text(message_user_name[idx][0]),
                        ),
                        title: Text(message_user_name[idx]),
                        subtitle: Text("last message"),
                        onTap: ()=>{chatwith(idx)},
                    )
                );
              }
          ),
        ),
      )
    );
  }
}