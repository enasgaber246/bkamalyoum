/// Ecode : 200
/// Emsg : "Success"
/// Ebody : {"current":[{"id":1,"name_en":"USD","name_ar":"الدولار الأمريكي","image":"21328019111653606110.png","selling_price":"130","buying_price":"135"},{"id":2,"name_en":"EUR","name_ar":"اليورو","image":"15080054601653606063.png","selling_price":"120","buying_price":"125"},{"id":5,"name_en":"AED","name_ar":"الدرهم الإماراتي","image":"17058685761653606153.png","selling_price":"667","buying_price":"66"},{"id":6,"name_en":"SAR","name_ar":"الريال السعودي","image":"18551654501653606204.png","selling_price":"32","buying_price":"65"},{"id":7,"name_en":"GBP","name_ar":"الجنية الإسترليني","image":"11906445501653606245.png","selling_price":"32","buying_price":"324"}],"expectaions":[{"id":1,"name_en":"USD","name_ar":"الدولار الأمريكي","image":"21328019111653606110.png","selling_price":"130","buying_price":"135"},{"id":2,"name_en":"EUR","name_ar":"اليورو","image":"15080054601653606063.png","selling_price":"120","buying_price":"125"},{"id":5,"name_en":"AED","name_ar":"الدرهم الإماراتي","image":"17058685761653606153.png","selling_price":"667","buying_price":"66"},{"id":6,"name_en":"SAR","name_ar":"الريال السعودي","image":"18551654501653606204.png","selling_price":"32","buying_price":"65"},{"id":7,"name_en":"GBP","name_ar":"الجنية الإسترليني","image":"11906445501653606245.png","selling_price":"32","buying_price":"324"}]}

class CurrencylistResponse {
  CurrencylistResponse({
      this.ecode, 
      this.emsg, 
      this.ebody,});

  CurrencylistResponse.fromJson(dynamic json) {
    ecode = json['Ecode'];
    emsg = json['Emsg'];
    ebody = json['Ebody'] != null ? Ebody.fromJson(json['Ebody']) : null;
  }
  int ecode;
  String emsg;
  Ebody ebody;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Ecode'] = ecode;
    map['Emsg'] = emsg;
    if (ebody != null) {
      map['Ebody'] = ebody.toJson();
    }
    return map;
  }

}

/// current : [{"id":1,"name_en":"USD","name_ar":"الدولار الأمريكي","image":"21328019111653606110.png","selling_price":"130","buying_price":"135"},{"id":2,"name_en":"EUR","name_ar":"اليورو","image":"15080054601653606063.png","selling_price":"120","buying_price":"125"},{"id":5,"name_en":"AED","name_ar":"الدرهم الإماراتي","image":"17058685761653606153.png","selling_price":"667","buying_price":"66"},{"id":6,"name_en":"SAR","name_ar":"الريال السعودي","image":"18551654501653606204.png","selling_price":"32","buying_price":"65"},{"id":7,"name_en":"GBP","name_ar":"الجنية الإسترليني","image":"11906445501653606245.png","selling_price":"32","buying_price":"324"}]
/// expectaions : [{"id":1,"name_en":"USD","name_ar":"الدولار الأمريكي","image":"21328019111653606110.png","selling_price":"130","buying_price":"135"},{"id":2,"name_en":"EUR","name_ar":"اليورو","image":"15080054601653606063.png","selling_price":"120","buying_price":"125"},{"id":5,"name_en":"AED","name_ar":"الدرهم الإماراتي","image":"17058685761653606153.png","selling_price":"667","buying_price":"66"},{"id":6,"name_en":"SAR","name_ar":"الريال السعودي","image":"18551654501653606204.png","selling_price":"32","buying_price":"65"},{"id":7,"name_en":"GBP","name_ar":"الجنية الإسترليني","image":"11906445501653606245.png","selling_price":"32","buying_price":"324"}]

class Ebody {
  Ebody({
      this.current, 
      this.expectaions,});

  Ebody.fromJson(dynamic json) {
    if (json['current'] != null) {
      current = [];
      json['current'].forEach((v) {
        current.add(Current.fromJson(v));
      });
    }
    if (json['expectaions'] != null) {
      expectaions = [];
      json['expectaions'].forEach((v) {
        expectaions.add(Current.fromJson(v));
      });
    }
  }
  List<Current> current;
  List<Current> expectaions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (current != null) {
      map['current'] = current.map((v) => v.toJson()).toList();
    }
    if (expectaions != null) {
      map['expectaions'] = expectaions.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name_en : "USD"
/// name_ar : "الدولار الأمريكي"
/// image : "21328019111653606110.png"
/// selling_price : "130"
/// buying_price : "135"

// class Expectaions {
//   Expectaions({
//       this.id,
//       this.nameEn,
//       this.nameAr,
//       this.image,
//       this.sellingPrice,
//       this.buyingPrice,});
//
//   Expectaions.fromJson(dynamic json) {
//     id = json['id'];
//     nameEn = json['name_en'];
//     nameAr = json['name_ar'];
//     image = json['image'];
//     sellingPrice = json['selling_price'];
//     buyingPrice = json['buying_price'];
//   }
//   int id;
//   String nameEn;
//   String nameAr;
//   String image;
//   String sellingPrice;
//   String buyingPrice;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name_en'] = nameEn;
//     map['name_ar'] = nameAr;
//     map['image'] = image;
//     map['selling_price'] = sellingPrice;
//     map['buying_price'] = buyingPrice;
//     return map;
//   }
//
// }

/// id : 1
/// name_en : "USD"
/// name_ar : "الدولار الأمريكي"
/// image : "21328019111653606110.png"
/// selling_price : "130"
/// buying_price : "135"

class Current {
  Current({
      this.id, 
      this.nameEn, 
      this.nameAr, 
      this.image, 
      this.sellingPrice, 
      this.buyingPrice,});

  Current.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    sellingPrice = json['selling_price'];
    buyingPrice = json['buying_price'];
  }
  int id;
  String nameEn;
  String  nameAr;
  String image;
  String sellingPrice;
  String buyingPrice;
  bool isSubscribed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    map['image'] = image;
    map['selling_price'] = sellingPrice;
    map['buying_price'] = buyingPrice;
    return map;
  }

}