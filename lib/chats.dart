import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Chats extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Chatsdata();
  }
}

class Chatsdata extends State<StatefulWidget> {
  var message_user=["Akhil","Aditya","Akhil"];
  Future getnewmessage() async{
    return ;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Padding(
        padding: EdgeInsets.fromLTRB(0,20,0,0),
        child: LiquidPullToRefresh(
          onRefresh: getnewmessage,
          child:  ListView.builder(
              itemCount: message_user.length,
              itemBuilder: (context,idx){
                return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide()
                      ),
                    ),
                    child:ListTile(
                        leading: CircleAvatar(
                          child: Text(message_user[idx][0]),
                        ),
                        title: Text(message_user[idx]),
                        subtitle: Text("last message"),
                    )
                );
              }
          ),
        ),
      )
    );
  }
}