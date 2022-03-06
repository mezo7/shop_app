class HomeModel {
  late bool status;
  late HomeDataModel data;


  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromjson(json['data'].cast<String,dynamic>());
  }
}

class HomeDataModel {
  List<dynamic> banners = [];
  List<dynamic> products = [];

  HomeDataModel.fromjson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(element);
    });
    json['products'].forEach((element) {
      products.add(element);
    });
  }
}

class BunnerModel {
   int? id;
   String? image;

  BunnerModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'].cast<String>();
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late List<String> image;
  late String name;
  late bool isFav;
  late bool inCart;

  ProductModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'].cast<String>();
    name = json['name'];
    isFav = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
