

class HomeModel {
   bool ?status;
   HomeDataModel ?data;

   HomeModel({this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeDataModel.fromjson(json['data']):null;
  }
}

class HomeDataModel {
   List<BannerModel>? banners;
   List<ProductModel>? products;


   HomeDataModel(this.banners, this.products);

  HomeDataModel.fromjson(Map<String, dynamic> json) {
    if(json['banners']!=null){
      banners=[];
      json['banners'].forEach((v) {
        banners?.add(BannerModel.fromjson(v));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductModel.fromjson(v));
      });
    }

  }
}

class BannerModel {
    int? id;
    String? image;

    BannerModel.fromjson(Map<String,dynamic>json){
      id = json['id'];
      image = json['image'];
    }
}

class ProductModel {
   int? id;
   dynamic price;
   dynamic oldPrice;
   dynamic discount;
   String? image;
   String? name;
   bool? isFav;
   bool? inCart;

  ProductModel.fromjson(Map<String, dynamic> json) {
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

