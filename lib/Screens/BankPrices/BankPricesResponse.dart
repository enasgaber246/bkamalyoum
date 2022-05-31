
class BankPricesResponse {
  BankPricesResponse({
      int ecode, 
      String emsg, 
      List<BankPriceModel> ebody,}){
    _ecode = ecode;
    _emsg = emsg;
    _ebody = ebody;
}

  BankPricesResponse.fromJson(dynamic json) {
    _ecode = json['Ecode'];
    _emsg = json['Emsg'];
    if (json['Ebody'] != null) {
      _ebody = [];
      json['Ebody'].forEach((v) {
        _ebody.add(BankPriceModel.fromJson(v));
      });
    }
  }
  int _ecode;
  String _emsg;
  List<BankPriceModel> _ebody;

  int get ecode => _ecode;
  String get emsg => _emsg;
  List<BankPriceModel> get ebody => _ebody;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Ecode'] = _ecode;
    map['Emsg'] = _emsg;
    if (_ebody != null) {
      map['Ebody'] = _ebody.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class BankPriceModel {
  BankPriceModel({
      String id, 
      String image, 
      String nameEn, 
      String nameAr, 
      String sellingPrice, 
      String buyingPrice, 
      String lastUpdate, 
      String currencyImage, 
      String currencyName,}){
    _id = id;
    _image = image;
    _nameEn = nameEn;
    _nameAr = nameAr;
    _sellingPrice = sellingPrice;
    _buyingPrice = buyingPrice;
    _lastUpdate = lastUpdate;
    _currencyImage = currencyImage;
    _currencyName = currencyName;
}

  BankPriceModel.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _nameEn = json['name_en'];
    _nameAr = json['name_ar'];
    _sellingPrice = json['selling_price'];
    _buyingPrice = json['buying_price'];
    _lastUpdate = json['last_update'];
    _currencyImage = json['currency_image'];
    _currencyName = json['currency_name'];
  }
  String _id;
  String _image;
  String _nameEn;
  String _nameAr;
  String _sellingPrice;
  String _buyingPrice;
  String _lastUpdate;
  String _currencyImage;
  String _currencyName;

  String get id => _id;
  String get image => _image;
  String get nameEn => _nameEn;
  String get nameAr => _nameAr;
  String get sellingPrice => _sellingPrice;
  String get buyingPrice => _buyingPrice;
  String get lastUpdate => _lastUpdate;
  String get currencyImage => _currencyImage;
  String get currencyName => _currencyName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['name_en'] = _nameEn;
    map['name_ar'] = _nameAr;
    map['selling_price'] = _sellingPrice;
    map['buying_price'] = _buyingPrice;
    map['last_update'] = _lastUpdate;
    map['currency_image'] = _currencyImage;
    map['currency_name'] = _currencyName;
    return map;
  }

}