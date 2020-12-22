import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Signup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SignAct();
  }
}
class SignAct extends State<StatefulWidget>{
  String email="";
  String password="";
  String name="";
  Future<void> handleSignUp(String email, String password,BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseDatabase fd=FirebaseDatabase.instance;
    if(name==""){
      showDialog(context: context, child:
      new AlertDialog(
        title: new Text("My Super title"),
        content: new Text("Hello World"),
        )
      );
      return;
    }
    try {
      var fbu=await auth.createUserWithEmailAndPassword(email: email, password: password);
      if (fbu.user !=null)  {
        email=email.replaceAll('.','_');
        print(email);
        await fd.reference().child('User').child(email).child("name").set(name);

      }
      }
      catch(e){
        showDialog(context: context, child:
        new AlertDialog(
          title: new Text("My Super title"),
          content: new Text("Hello World"),
        )
        );
      }
  }
  void updatemailpass(BuildContext context){
    print(email.length);
    handleSignUp(email, password,context);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body:Container(
            color: Colors.black12,
            width: 1000,
            height: 1000,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 600,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment(0,0),
                          colors: [
                            const Color(0xffee0000),
                            const Color(0xffeeee00)
                          ]
                          ,
                          tileMode: TileMode.repeated,
                        )
                    ),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    left:40,
                    child: Container(
                      height: 400,
                      width: 350,
                      child:Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextField(
                                onChanged: (text)=>{
                                  name=text
                                },
                                decoration:InputDecoration(
                                    icon: Icon(Icons.person),
                                    border: OutlineInputBorder(),
                                    hintText: "Username"
                                )
                            ),
                            TextField(
                              onChanged: (text)=>{
                                email=text
                              },
                                decoration:InputDecoration(
                                    icon: Icon(Icons.email),
                                    border: OutlineInputBorder(),
                                    hintText: "E-mail"
                                )
                            ),
                            TextField(
                              onChanged: (text)=> {
                                password=text
                                },
                                obscureText: true,
                                decoration:InputDecoration(
                                  icon: Icon(Icons.lock),
                                  border: OutlineInputBorder(),
                                  hintText: "Password",
                                )
                            ),
                            SizedBox(
                                width:200.0,
                                height: 50.0,
                                child:
                                RaisedButton(
                                  color: Colors.orange,
                                  onPressed: ()=>updatemailpass(context),
                                  child: Center(
                                      child:Text("Sign-Up",
                                          style:TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20
                                          )
                                      )
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:Colors.grey,
                            blurRadius: 5.0,
                          )
                        ],
                      ),
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}
