
class CurrencylistResponse {
  CurrencylistResponse({
    this.ecode,
    this.emsg,
    this.ebody,
  });

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

class Ebody {
  Ebody({
    this.current,
    this.expectaions,
  });

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
        expectaions.add(Expectaions.fromJson(v));
      });
    }
  }

  List<Current> current;
  List<Expectaions> expectaions;

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

class Current {
  Current({
    this.id,
    this.nameEn,
    this.nameAr,
    this.image,
    this.sellingPrice,
    this.buyingPrice,
  });

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
  String nameAr;
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

class Expectaions {
  Expectaions({
    this.id,
    this.nameEn,
    this.nameAr,
    this.image,
    this.sellingPrice,
    this.buyingPrice,});

  Expectaions.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    sellingPrice = json['selling_price'];
    buyingPrice = json['buying_price'];
  }
  String id;
  String nameEn;
  String nameAr;
  String image;
  String sellingPrice;
  String buyingPrice;

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
