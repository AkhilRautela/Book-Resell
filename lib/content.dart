import 'dart:io';
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
  var arr=[];
  void getdatafirst() async{
    arr=[];
    final FirebaseStorage inst=FirebaseStorage.instance;
    var res=await inst.ref().child('bookresellapp').listAll();
    var allitems=res.items;
    for(int i=0;i<allitems.length;i++){
      arr.add(await allitems[i].getDownloadURL());
    }
    arr.reversed;
    if (arr.length==0){
      arr.add("https://i.pinimg.com/originals/c9/22/68/c92268d92cf2dbf96e3195683d9e14fb.png");
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
                    itemCount: arr.length,
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
                                      child: Text("A"),
                                      foregroundColor: Colors.red,
                                    ),
                                    Text("Location")
                                  ],
                                ),
                                Text("Book Name"),
                                SizedBox(
                                  height:10,
                                ),
                                Image.network(arr[idx]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RaisedButton(
                                        color: Color(0xff6592B8),
                                        onPressed: ()=>print("buy"),
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