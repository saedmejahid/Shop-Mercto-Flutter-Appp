class HomeModel
{
  late bool status;
  late HomeDateModel data;
  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = HomeDateModel.fromJson(json['data']);
  }
}

class HomeDateModel
{
  late List<BannerModel> banners = [];
 late  List<ProductModel> products = [];
  HomeDateModel.fromJson(Map<String,dynamic>json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });
  }
}
class BannerModel
{
   int?  id;
   String?  image;
  BannerModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel
{
   int? id;
   dynamic prIce;
   dynamic oldPrice;
   dynamic disCount;
   String? imAge;
   String? naMe;
   bool? inFavorites;
   bool? inCart;
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prIce = json['price'];
    oldPrice = json['old_price'];
    disCount = json['discount'];
    imAge = json['image'];
    naMe = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
