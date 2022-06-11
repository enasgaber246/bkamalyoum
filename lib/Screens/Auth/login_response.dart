/// Ecode : 200
/// Emsg : "Success"
/// Edata : {"accessToken":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiN2NkNWE5YTEzZWNkNjIzNDQyNTZjZDI3MDUyZTljOGVmMWYzY2U4YTkwMThjOTgyNjA4MWQ0ODYwOTI5YmZiMTFkYTBmNTdhY2ZmYjAwNTEiLCJpYXQiOjE2NTQ3NzYwMTIuNDkyNjAyMTA5OTA5MDU3NjE3MTg3NSwibmJmIjoxNjU0Nzc2MDEyLjQ5MjYwODA3MDM3MzUzNTE1NjI1LCJleHAiOjE2ODYzMTIwMTIuNDcwNzgzOTQ4ODk4MzE1NDI5Njg3NSwic3ViIjoiMzMiLCJzY29wZXMiOltdfQ.iLrBWa9BFJZmL-cXYPnnNQbsAgSiJsAGdPQfGQBMPWXsinWVk1kECkoPD5IPnPpyTZunC-n4gGBAEan_xX2QwCmcY9QQ4LlvW4GqZ-cVR7W-59vVQRg3tOWtEJ9nNAEpnT0hw1NhnrEts9x55xM3rz4xFideaYH9glrxqKfMmM-WoY4dNviSJx6zTRJZBSjv-NqHiOJt9lX_NFldiX7K_r1NDnwJFydlxVtGDl-lPwXaHIyFM-rG0cL-7mBJ8bY2-YR4umx0vVumw9g9yZFWzoriGnevtEvof3s4ag5lsCx9U2kQxzJiRUUtjt4V2DwbbxZ9sAFAV1AxYZRVmoe41IHeadtCa_bNaDuLTfMbTjRtpfCInqH_x0GMytB9EnVbhbIu9wEFRd6dFk2rUDiPicxx42mAu5Ig05HKXLy0Pnn-kbJUlozfOvYF-efdLqfbQIFwoiUIQ3MyT8JogyotaNunNSvzlf6Nf1imPqhuYityjuQ7Y7-mvnuSqrgMjX6Zk1OF-ZITbe8Q8eRZm05nf9WXTnln5sbMZTf1duYWcEyKS8AFTCcuHKWy3aRLiIrFoJqCPIvRXtbDhIhv6fqd7QbzWJvr6rCLaOM_-nkjpwQpfShYh79pSxiERD30zlR_Avy-qqlCTjjt4mfndUs2JJrhz1_YkEWRPV3-b3gSao4","user":{"id":33,"name":"Mostafa Aboelnasr","phone":"2183789122","image":null,"phone_verified_at":null}}

class LoginResponse {
  LoginResponse({
      this.ecode, 
      this.emsg, 
      this.edata,});

  LoginResponse.fromJson(dynamic json) {
    ecode = json['Ecode'];
    emsg = json['Emsg'];
    edata = json['Edata'] != null ? Edata.fromJson(json['Edata']) : null;
  }
  int ecode;
  String emsg;
  Edata edata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Ecode'] = ecode;
    map['Emsg'] = emsg;
    if (edata != null) {
      map['Edata'] = edata.toJson();
    }
    return map;
  }

}

/// accessToken : "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiN2NkNWE5YTEzZWNkNjIzNDQyNTZjZDI3MDUyZTljOGVmMWYzY2U4YTkwMThjOTgyNjA4MWQ0ODYwOTI5YmZiMTFkYTBmNTdhY2ZmYjAwNTEiLCJpYXQiOjE2NTQ3NzYwMTIuNDkyNjAyMTA5OTA5MDU3NjE3MTg3NSwibmJmIjoxNjU0Nzc2MDEyLjQ5MjYwODA3MDM3MzUzNTE1NjI1LCJleHAiOjE2ODYzMTIwMTIuNDcwNzgzOTQ4ODk4MzE1NDI5Njg3NSwic3ViIjoiMzMiLCJzY29wZXMiOltdfQ.iLrBWa9BFJZmL-cXYPnnNQbsAgSiJsAGdPQfGQBMPWXsinWVk1kECkoPD5IPnPpyTZunC-n4gGBAEan_xX2QwCmcY9QQ4LlvW4GqZ-cVR7W-59vVQRg3tOWtEJ9nNAEpnT0hw1NhnrEts9x55xM3rz4xFideaYH9glrxqKfMmM-WoY4dNviSJx6zTRJZBSjv-NqHiOJt9lX_NFldiX7K_r1NDnwJFydlxVtGDl-lPwXaHIyFM-rG0cL-7mBJ8bY2-YR4umx0vVumw9g9yZFWzoriGnevtEvof3s4ag5lsCx9U2kQxzJiRUUtjt4V2DwbbxZ9sAFAV1AxYZRVmoe41IHeadtCa_bNaDuLTfMbTjRtpfCInqH_x0GMytB9EnVbhbIu9wEFRd6dFk2rUDiPicxx42mAu5Ig05HKXLy0Pnn-kbJUlozfOvYF-efdLqfbQIFwoiUIQ3MyT8JogyotaNunNSvzlf6Nf1imPqhuYityjuQ7Y7-mvnuSqrgMjX6Zk1OF-ZITbe8Q8eRZm05nf9WXTnln5sbMZTf1duYWcEyKS8AFTCcuHKWy3aRLiIrFoJqCPIvRXtbDhIhv6fqd7QbzWJvr6rCLaOM_-nkjpwQpfShYh79pSxiERD30zlR_Avy-qqlCTjjt4mfndUs2JJrhz1_YkEWRPV3-b3gSao4"
/// user : {"id":33,"name":"Mostafa Aboelnasr","phone":"2183789122","image":null,"phone_verified_at":null}

class Edata {
  Edata({
      this.accessToken, 
      this.user,});

  Edata.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String accessToken;
  User user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    if (user != null) {
      map['user'] = user.toJson();
    }
    return map;
  }

}

/// id : 33
/// name : "Mostafa Aboelnasr"
/// phone : "2183789122"
/// image : null
/// phone_verified_at : null

class User {
  User({
      this.id, 
      this.name, 
      this.phone, 
      this.image, 
      this.phoneVerifiedAt,});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    phoneVerifiedAt = json['phone_verified_at'];
  }
  int id;
  String name;
  String phone;
  dynamic image;
  dynamic phoneVerifiedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['image'] = image;
    map['phone_verified_at'] = phoneVerifiedAt;
    return map;
  }

}