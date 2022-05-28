
class PrivacyPolicyResponse {
  PrivacyPolicyRequest({
      int ecode, 
      String emsg, 
      List<Ebody> ebody,}){
    _ecode = ecode;
    _emsg = emsg;
    _ebody = ebody;
}

  PrivacyPolicyResponse.fromJson(dynamic json) {
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
      String name, 
      String value,}){
    _id = id;
    _name = name;
    _value = value;
}

  Ebody.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _value = json['value'];
  }
  int _id;
  String _name;
  String _value;

  int get id => _id;
  String get name => _name;
  String get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['value'] = _value;
    return map;
  }

}