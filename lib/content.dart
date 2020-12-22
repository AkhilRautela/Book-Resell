import 'dart:io';
import 'package:bookresell/dataofperson.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Content extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ContentData();
  }
}

class ContentData extends State<StatefulWidget> {
  var arrdownloadlink=[];
  var arrname=[];
  var arrid=[];
  var arrbookname=[];
  var arrlocation=[];
  void letsbuy(idx) {
    print(arrid);
    CurrentChat.to_id=arrid[idx];
    CurrentChat.to_name=arrname[idx];
    Navigator.of(context).pushNamed('/chat');
  }
  void getdatafirst() async{
    arrname=[];
    arrid=[];
    arrdownloadlink=[];
    arrbookname=[];
    arrlocation=[];
    FirebaseDatabase fd=FirebaseDatabase.instance;
    FirebaseStorage fs=FirebaseStorage.instance;
    var res=await fd.reference().child("User").once();
    var alluserdata=res.value;
    for(var x in alluserdata.keys){
        var y=alluserdata[x];
        if(!y.containsKey('Uploads')) {
          continue;
        }
        for(var z in y["Uploads"].keys){
          var w=y['Uploads'][z];
        //  print(z); print(w);
          String downloadurl=await fs.ref().child("bookresellapp").child(x).child(z).getDownloadURL();
          arrid.add(x);
          arrname.add(y['name']);
          arrdownloadlink.add(downloadurl);
          arrbookname.add(w['bookname']);
          arrlocation.add(w['location']);
          //print("pehle");
        }
    }
    //print(arrdownloadlink);
    //print("baad main");
    if (arrdownloadlink.length==0){
      arrdownloadlink.add("https://i.pinimg.com/originals/c9/22/68/c92268d92cf2dbf96e3195683d9e14fb.png");
    }
    setState(() {
    });
  }
  Future<void> updateData() async{
    return getdatafirst();
  }
  void initState(){
    getdatafirst();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0 , 10),
            child: LiquidPullToRefresh(
                onRefresh: updateData,
                child:ListView.builder(
                    itemCount: arrbookname.length,
                    itemBuilder: (context,idx){
                      return Container(
                          margin: EdgeInsets.fromLTRB(0,10,0,10),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      child: Text(arrname[idx][0]),
                                      foregroundColor: Colors.red,
                                    ),
                                    Text(arrname[idx]),
                                    Text(arrlocation[idx])
                                  ],
                                ),
                                Text(arrbookname[idx]),
                                SizedBox(
                                  height:10,
                                ),
                                Image.network(arrdownloadlink[idx]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RaisedButton(
                                        color: Color(0xff6592B8),
                                        onPressed: ()=>{letsbuy(idx)},
                                        child: Text("Buy")
                                    )
                                  ],
                                )
                              ],
                            )
                          )
                      );
                    }
                )
            )
        ),
    );
  }

}