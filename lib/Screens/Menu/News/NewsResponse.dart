
class NewsResponse {
  NewsResponse({
      int ecode, 
      String emsg, 
      List<Ebody> ebody,}){
    _ecode = ecode;
    _emsg = emsg;
    _ebody = ebody;
}

  NewsResponse.fromJson(dynamic json) {
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
      String title, 
      String body, 
      String image,}){
    _id = id;
    _title = title;
    _body = body;
    _image = image;
}

  Ebody.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
    _image = json['image'];
  }
  int _id;
  String _title;
  String _body;
  String _image;

  int get id => _id;
  String get title => _title;
  String get body => _body;
  String get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    map['image'] = _image;
    return map;
  }

}