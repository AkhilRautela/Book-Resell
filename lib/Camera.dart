import 'dart:io';

import 'package:bookresell/dataofperson.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CameraData();
  }

}

class CameraData extends State<StatefulWidget> {
  String bookname;
  String location;
  bool chk = false;
  var myimage;
  Future <void> select_image() async{
    var picker=ImagePicker();
    PickedFile imagefile= await picker.getImage(source: ImageSource.camera);
    if(imagefile!=null){
      setState(() {
        myimage=File(imagefile.path);
        chk=true;
      });
    }
  }
  Future  <void> select_image_gallery() async{
    var picker=ImagePicker();
    PickedFile imagefile= await picker.getImage(source: ImageSource.gallery);
    if(imagefile!=null){
      setState(() {
        myimage=File(imagefile.path);
        chk=true;
      });
    }
  }
  Future <void> upload_image() async{
    if(myimage!=null){
      var storeinstance=FirebaseStorage.instance;
      print(CurrentUser.id);
      var filenametoupload=DateTime.now().millisecondsSinceEpoch.toString();
      await storeinstance.ref().child("bookresellapp").child(CurrentUser.id).child(filenametoupload).putFile(myimage);
      FirebaseDatabase fd=FirebaseDatabase.instance;
      await fd.reference().child("User").child(CurrentUser.id).child("Uploads").child(filenametoupload).child("bookname").set(bookname);
      await fd.reference().child("User").child(CurrentUser.id).child("Uploads").child(filenametoupload).child("location").set(location);
      print('done');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child:Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width:300,
                child:TextField(
                    onChanged: (text)=>{bookname=text},
                    decoration:InputDecoration(
                        icon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        hintText: "Book Name"
                    )
                ),
              ),
              SizedBox(
                width:300,
                child:TextField(
                    onChanged: (text)=>{location=text},
                    decoration:InputDecoration(
                      icon: Icon(Icons.map),
                      border: OutlineInputBorder(),
                      hintText: "Location",
                    )
                ),
              ),
              Container(
                height: 500,
                child: chk?Image.file(myimage):Center(
                    child:Text("Image Not Selected")
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        child: RaisedButton(
                          color: Color(0xff6592B8),
                          onPressed: ()=> {select_image()},
                          child: Text("Camera"),
                        )
                    ),
                    SizedBox(
                        child:RaisedButton(
                            color: Color(0xff6592B8),
                            onPressed: () => {select_image_gallery()},
                            child: Text("Gallery")
                        )
                    ),
                    SizedBox(
                        child:RaisedButton(
                            color: Color(0xff6592B8),
                            onPressed: ()=> {upload_image()},
                            child: Text("Upload")
                        )
                    )
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }

}