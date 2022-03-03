class HomeModel
{
  late bool status;
  late HomeDataModel data;
  HomeModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data = HomeDataModel.fromjson(json['data']);
  }

}
class HomeDataModel
{
  List<BunnerModel>bunners=[];
  List<ProductModel>products=[];
  HomeDataModel.fromjson(Map<String,dynamic>json){
    json['bunners'].forEach((element){
      bunners.add(element);
    });
    json['products'].forEach((element){
      products.add(element);
    });
  }
}
class BunnerModel
{
  late int id;
  late String image;

  BunnerModel.fromjson(Map<String,dynamic>json){
    id = json['id'];
    image = json['image'];
  }
}
class ProductModel
{
  late int id ;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool isFav;
  late bool inCart;



  ProductModel.fromjson(Map<String,dynamic>json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    isFav = json['in_favorites'];
    inCart = json['in_cart'];
  }
}