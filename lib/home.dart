import 'dart:io';

import 'package:bookresell/chatperperson.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'content.dart';
import 'package:bookresell/Camera.dart';
import 'chats.dart';
import 'package:bookresell/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dataofperson.dart';
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeAct();
  }
}
class HomeAct extends State<StatefulWidget>{
  int curidx=0;
  dynamic currentpage=Content();
  void makehimlogout(){
    print("logout");
  }
  void set_idx_back(int idx){
    if(idx==0){
      setState(() {
        currentpage=Content();
      });
    }
    else if(idx==1){
      setState(() {
        currentpage=Camera();
      });
    }
    else{
      setState(() {
        currentpage=Chats();
      });
    }
  }
  Future <void> Logincheck() async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    if(sp.containsKey("islogged")) {
      if(sp.getBool("islogged")==true) {
        String fetched=sp.getString("id");
        CurrentUser.id=fetched.replaceAll(".", "_");
        CurrentChat.from_id=CurrentUser.id;
        FirebaseDatabase db=FirebaseDatabase.instance;
        var res=await db.reference().child("User").child(CurrentUser.id).once();
        CurrentUser.name=res.value['name'];
       // print(CurrentUser.id+" "+CurrentUser.name);
        setState(() {

        });
      }
    }
    else{
      Navigator.of(context).popAndPushNamed('/login');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    print("start");
    Logincheck();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: currentpage,
        backgroundColor: Color(0xffCCDAD1),
        drawer: Drawer(
          child:ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(CurrentUser.id.replaceAll('_', '.')),
                currentAccountPicture: CircleAvatar(
                  child: Text(CurrentUser.id[0].toUpperCase()),
                ),
              ),
              Divider(
                thickness: 0.5,
              ),
              RaisedButton(
                color: Color(0xff6592B8),
                onPressed: ()=>{makehimlogout()},
                child: Text(
                  "Logout"
                ),
              )
            ],
          )
        ),

        bottomNavigationBar: FluidNavBar(
          onChange: (idx) => set_idx_back(idx),
          icons: [
            FluidNavBarIcon(
              icon: Icons.home,
            ),
            FluidNavBarIcon(
              icon: Icons.camera,
            ),
            FluidNavBarIcon(
              icon:Icons.chat,
            ),
          ],
          style: FluidNavBarStyle(
            barBackgroundColor: Color(0xff9CAEA9),
            iconBackgroundColor: Color(0xff6F6866),
          ),
        ),
        );
  }

}