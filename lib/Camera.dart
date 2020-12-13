import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CameraData();
  }

}

class CameraData extends State<StatefulWidget> {
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
      await storeinstance.ref().child("bookresellapp").child('justnow').putFile(myimage);
      print('done');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 200,
            child: chk?Image.file(myimage):Center(
              child:Text("Image Not Selected")
            ),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  child: RaisedButton(
                    onPressed: ()=> {select_image()},
                    child: Text("Camera"),
                  )
                ),
                SizedBox(
                  child:RaisedButton(
                    onPressed: () => {select_image_gallery()},
                    child: Text("Gallery")
                  )
                ),
                SizedBox(
                  child:RaisedButton(
                    onPressed: ()=> {upload_image()},
                    child: Text("Upload")
                  )
                )
              ],
            ),
          )
        ],
      )
    );
  }

}