import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // colection reference
  final CollectionReference orderCollection =
      Firestore.instance.collection('orders');

  Future sendingPrice(String tablenumber,String price) async{
    final DocumentReference documentReference = Firestore.instance.collection('orders').document(tablenumber);
    documentReference.setData({
      'totalprice' : price
    });
  }
  Future isWaiting(String tablenumber) async {
    final CollectionReference orderwaitingCollectgion =
        Firestore.instance.collection('waiting');
    return await orderwaitingCollectgion.document(uid).setData({
      'tablenumber': tablenumber,
    });
  }
  /*createData(int number,List orders, String tablenumber) {
  final DocumentReference documentReference = Firestore.instance.collection('orders').document(tablenumber);

    /*Map<String , dynamic> orders = {
      'number': number,
      'name': name,
      'amount': amount,
      'price' : price,
      'tablenumber': tablenumber
    };
    */
    documentReference.setData({
      'number' : number,
      'items' : [orders],
      'tablenumber' : tablenumber,
    }).whenComplete(() => print('created!'));
  }*/

  Future insertOrder(String name, String amount, String price,
      String tablenumber) async {
    return await orderCollection.document(uid).setData({
      'tablenumber': tablenumber,
      'name': name,
      'amount': amount,
      'price': price,
      
    });
  }
}
