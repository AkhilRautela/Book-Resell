import 'package:firebase_database/firebase_database.dart';

class CurrentUser{
  static String id;
  static String name;
}
class CurrentChat{
  static String from_name;
  static String to_name;
  static String from_id;
  static String to_id;
}
class Getname{
  static Future<String> getname(String id) async{
    FirebaseDatabase fd=FirebaseDatabase.instance;
    var res=await fd.reference().child('User').child(id).child('name').once();
    print(res.value);
    return res.value;
  }
}