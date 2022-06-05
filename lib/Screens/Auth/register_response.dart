/// Ecode : 200
/// Emsg : "Success"
/// Ebody : {"id":24,"name":"Mostafa Aboelnasr","phone":"010697618034","image":null}

class RegisterResponse {
  RegisterResponse({
      this.ecode, 
      this.emsg, 
      this.ebody,});

  RegisterResponse.fromJson(dynamic json) {
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

/// id : 24
/// name : "Mostafa Aboelnasr"
/// phone : "010697618034"
/// image : null

class Ebody {
  Ebody({
      this.id, 
      this.name, 
      this.phone, 
      this.image,});

  Ebody.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
  }
  int id;
  String name;
  String phone;
  dynamic image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['image'] = image;
    return map;
  }

}