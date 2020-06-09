import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  // colection reference 
  final CollectionReference orderCollection = Firestore.instance.collection('orders');
  
  Future insertOrder(String name, String amount,String price,String tablenumber) async{
    return await orderCollection.document(uid).setData({
      'tablenumber' : tablenumber,
      'name' : name,
      'amount' : amount,
      'price' : price,
    });
  }

}