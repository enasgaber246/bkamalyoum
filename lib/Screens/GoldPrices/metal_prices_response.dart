class MetalPricesResponse {
  MetalPricesResponse({
    this.ecode,
    this.emsg,
    this.ebody,
  });

  MetalPricesResponse.fromJson(dynamic json) {
    ecode = json['Ecode'];
    emsg = json['Emsg'];
    if (json['Ebody'] != null) {
      ebody = [];
      json['Ebody'].forEach((v) {
        ebody.add(MetalCategoryModel.fromJson(v));
      });
    }
  }

  int ecode;
  String emsg;
  List<MetalCategoryModel> ebody;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Ecode'] = ecode;
    map['Emsg'] = emsg;
    if (ebody != null) {
      map['Ebody'] = ebody.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class MetalCategoryModel {
  MetalCategoryModel({
    this.id,
    this.nameEn,
    this.nameAr,
    this.image,
    this.metals,
  });

  MetalCategoryModel.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    if (json['metals'] != null) {
      metals = [];
      json['metals'].forEach((v) {
        metals.add(MetalModel.fromJson(v));
      });
    }
  }

  int id;
  String nameEn;
  String nameAr;
  String image;
  List<MetalModel> metals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    map['image'] = image;
    if (metals != null) {
      map['metals'] = metals.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name_en : "Caliber 09"
/// name_ar : "عيار 09"
/// price : "34.239"

class MetalModel {
  MetalModel({
    this.id,
    this.nameEn,
    this.nameAr,
    this.price,
  });

  MetalModel.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    price = json['price'];
  }

  int id;
  String nameEn;
  String nameAr;
  String price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    map['price'] = price;
    return map;
  }
}
