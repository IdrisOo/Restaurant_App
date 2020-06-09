import 'db.dart';

class OrderModel{
  int id;
  String name;
  String assetpic;
  int amount;
  int totalPrice;

  OrderModel({this.id,this.name,this.assetpic,this.amount,this.totalPrice});




Future<List<OrderModel>> queryRowCount1() async {
    final dbHelper = DatabaseHelper.instance;
    final List<Map<String, dynamic>> maps = await dbHelper.queryAllRows();
    return List.generate(maps.length, (i){
      return OrderModel(
        id: maps[i]['_id'],
        name: maps[i]['name'],
        assetpic: maps[i]['pic'],
        amount: maps[i]['amount'],
        totalPrice: maps[i]['price'],
      );
    });
  }
}