import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return LoginAct();
  }
}
class LoginAct extends State<StatefulWidget>{
  String email;
  String password;
  Future <void> checklogin() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    var res=await auth.signInWithEmailAndPassword(email: email, password: password);
    if (res.user!=null){
      print('logged in as ');
      print(res.user.email);
      SharedPreferences.setMockInitialValues({});
      SharedPreferences sp=await SharedPreferences.getInstance();
      sp.setBool("islogged", true);
      sp.setString("id",email);
    }
  }
  void attemptlogin(){
    checklogin();
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
                    height: 380,
                    width: 350,
                    child:Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextField(
                            onChanged: (text)=>{email=text},
                            decoration:InputDecoration(
                              icon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                              hintText: "E-mail"
                            )
                          ),
                          TextField(
                            onChanged: (text)=>{password=text},
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
                                onPressed: attemptlogin,
                                color: Colors.orange,
                                child: Center(
                                    child:Text("Login",
                                      style:TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                      )
                                    )
                                ),
                            )
                          ),
                          SizedBox(
                              width:200.0,
                              height: 50.0,
                              child:
                              RaisedButton(
                                onPressed: ()=>print("move to signup"),
                                color: Colors.orange,
                                child: Center(
                                    child:Text("Sign UP",
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