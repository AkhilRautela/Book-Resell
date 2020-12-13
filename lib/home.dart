import 'package:bookresell/chatperperson.dart';
import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'content.dart';
import 'package:bookresell/Camera.dart';
import 'chats.dart';
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeAct();
  }
}
class HomeAct extends State<StatefulWidget>{
  int curidx=0;
  dynamic currentpage=Content();
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
        currentpage=Chatperperson();
      });

    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: currentpage,
        backgroundColor: Color(0xffCCDAD1),
        drawer: Drawer(
          child: UserAccountsDrawerHeader(
            accountEmail: Text("fkdjfkjd"),
            accountName: Text("dfdskafs"),
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
        ),
      );
  }

}