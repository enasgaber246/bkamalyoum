
class currencylistResponse {
  currencylistResponse({
      int ecode, 
      String emsg, 
      List<Ebody> ebody,}){
    _ecode = ecode;
    _emsg = emsg;
    _ebody = ebody;
}

  currencylistResponse.fromJson(dynamic json) {
    _ecode = json['Ecode'];
    _emsg = json['Emsg'];
    if (json['Ebody'] != null) {
      _ebody = [];
      json['Ebody'].forEach((v) {
        _ebody.add(Ebody.fromJson(v));
      });
    }
  }
  int _ecode;
  String _emsg;
  List<Ebody> _ebody;

  int get ecode => _ecode;
  String get emsg => _emsg;
  List<Ebody> get ebody => _ebody;

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

class Ebody {
  Ebody({
      int id, 
      String nameEn, 
      String nameAr, 
      String image,}){
    _id = id;
    _nameEn = nameEn;
    _nameAr = nameAr;
    _image = image;
}

  Ebody.fromJson(dynamic json) {
    _id = json['id'];
    _nameEn = json['name_en'];
    _nameAr = json['name_ar'];
    _image = json['image'];
  }
  int _id;
  String _nameEn;
  String _nameAr;
  String _image;

  int get id => _id;
  String get nameEn => _nameEn;
  String get nameAr => _nameAr;
  String get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name_en'] = _nameEn;
    map['name_ar'] = _nameAr;
    map['image'] = _image;
    return map;
  }

}