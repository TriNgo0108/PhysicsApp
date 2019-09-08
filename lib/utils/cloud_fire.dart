import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFire{
  final data =Firestore.instance;
  void createUserRecord(String user,String name,String grade) async{
    await data.collection("user").document(user).setData({
      'name':name,
      'grade':grade
    });
  }
  void getData() {
    data.collection("user")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }
}