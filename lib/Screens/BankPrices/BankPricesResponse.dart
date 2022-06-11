class BankPricesResponse {
  BankPricesResponse({
    this.ecode,
    this.emsg,
    this.ebody,
  });

  BankPricesResponse.fromJson(dynamic json) {
    ecode = json['Ecode'];
    emsg = json['Emsg'];
    if (json['Ebody'] != null) {
      ebody = [];
      json['Ebody'].forEach((v) {
        ebody.add(BankPriceModel.fromJson(v));
      });
    }
  }

  int ecode;
  String emsg;
  List<BankPriceModel> ebody;

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

class BankPriceModel {
  BankPriceModel({
    this.id,
    this.image,
    this.nameEn,
    this.nameAr,
    this.sellingPrice,
    this.buyingPrice,
    this.hotLine,
    this.webUrl,
    this.currencyId,
    this.lastUpdate,
    this.currencyImage,
    this.currencyName,
    this.currencyNameAr,
    this.oldSellingPrice,
    this.oldBuyingPrice,
    this.is_special,
  });

  BankPriceModel.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    sellingPrice = json['selling_price'];
    buyingPrice = json['buying_price'];
    hotLine = json['hot_line'];
    webUrl = json['web_url'];
    currencyId = json['currency_id'];
    lastUpdate = json['last_update'];
    currencyImage = json['currency_image'];
    currencyName = json['currency_name'];
    currencyNameAr = json['currency_name_ar'];
    oldSellingPrice = json['old_selling_price'];
    oldBuyingPrice = json['old_buying_price'];
    is_special = json['is_special'];
  }

  String id;
  String image;
  String nameEn;
  String nameAr;
  String sellingPrice;
  String buyingPrice;
  String hotLine;
  String webUrl;
  String currencyId;
  String lastUpdate;
  String currencyImage;
  String currencyName;
  String currencyNameAr;
  String oldSellingPrice;
  String oldBuyingPrice;
  String is_special;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    map['selling_price'] = sellingPrice;
    map['buying_price'] = buyingPrice;
    map['hot_line'] = hotLine;
    map['web_url'] = webUrl;
    map['currency_id'] = currencyId;
    map['last_update'] = lastUpdate;
    map['currency_image'] = currencyImage;
    map['currency_name'] = currencyName;
    map['currency_name_ar'] = currencyNameAr;
    map['old_selling_price'] = oldSellingPrice;
    map['old_buying_price'] = oldBuyingPrice;
    map['is_special'] = is_special;
    return map;
  }
}
