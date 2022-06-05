/// Ecode : 200
/// Emsg : "Success"

class SendExpectationResponse {
  SendExpectationResponse({
      this.ecode, 
      this.emsg,});

  SendExpectationResponse.fromJson(dynamic json) {
    ecode = json['Ecode'];
    emsg = json['Emsg'];
  }
  int ecode;
  String emsg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Ecode'] = ecode;
    map['Emsg'] = emsg;
    return map;
  }

}