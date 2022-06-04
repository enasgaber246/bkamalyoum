/// token_type : "Bearer"
/// expires_in : 31536000
/// access_token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiMDExYzU1MDlhMDhkZDkxZjU2Y2M5N2IzMDVjNTgxYzNlYWFhODFlMGI0YWNiZmRhNGNmMWNlYzJjNzM1MTZjYTkwMWYwMzU0OWZmZmJlODMiLCJpYXQiOjE2NTQzMTAzMDAuNzI0NjM2MDc3ODgwODU5Mzc1LCJuYmYiOjE2NTQzMTAzMDAuNzI0NjQzOTQ1NjkzOTY5NzI2NTYyNSwiZXhwIjoxNjg1ODQ2MzAwLjY3OTc2MzA3ODY4OTU3NTE5NTMxMjUsInN1YiI6IjIwIiwic2NvcGVzIjpbXX0.21-Jb38vwAjogH5hm-KRwSD8QlhEqbeqJzgAn3ZhY9YuuKkYoWDEb4XPTseZuQi586mE_FByMO3ugm6qHjFywdbKe4cSqnK6sk4UMg21jYdz9aZHje63DyGz-oL6cX0r1AE8nYZ2BsXh_CFV6RkwhC87ymjt2EFyaKMnSuYc1aqLEkPpExN4DdYLZc61PIqIzrVkFy-N6VR9EgbEvrxhjkMQ0MaN2dZ1QM5cfN0SRVDz9SUxAXDqm8-66nITFCB0cqjZaOFodCRbi1GeI2aO-nm3sdHMgXyarrY4WixfsmPw2gXIooL7X7JU_md_jyqrzQJ66ScvMJipeAxFQkK2AXIPjDbdypU9B_4hiWrTAA5BqvOH51JPOookbj1xdl9aGx6nMUdarSwu8qhjHZWh0q_AKJfDtV7pvI10kfqWuf_nWURbTG1f-0TiFEwAvH3GqLuVzM7SmDR8dqYyxcVcXV0S0l4wyUujbnzN8XjQ1c1u1xct5n_7eiyUJRbWhEAjqHQlXpOFNj1HkwqNH98oX12XhnDVRfH7AjrsDQESRCLynlLMF5_FFXpKeks8RWDWCepDw_dPph6H0xuqVGW00EmWCt7Ahkgup3Zg8bsFuL2f0y9YhyFKEOqIJYCwOPxQH-SqGWNs5CfMUMgB-C8cfPCsfD3fNLcZ-cukKqDIBv8"
/// refresh_token : "def50200fb888f5e78176e52063688573c0873b4f618042ff8409f4a3506f31765793668657ad15f3e5525d39b85d6fc69a4b3cc51b19756d1e225075eaa220a762784e9c01e454190f574149556aeef66e6ee7e1ade9118b0ed06142ece117c5158eb5d6190ea1f5e00f6ea4d97b0039faa820dcd1b4520f4f963134bca55145bf21270daca1a60e0117b301ee08d1952b40ad69acec7b66202e0d1c2d73708042dea46fbc797b98ef044f55dcdaa2433aa2d49bf68d87c4cbb00514624d15e9d76989c41cb2f3723d1f67adbc4677819a8a779e1bf85e4d11d32a8471bba14e2ee09eac87127494c982b06bd8781b1cba863a4f614e978e4c02ca8c21477b80ef00060ba7768f893b289c204c15de21c26bf6db781392116b6203ba5469b8f3cee51e22475b47acee7363edab3075182fdd9996e197f05e87f1e4d6b0206920c04389c1fa1b40f512a368ca6e096d41d2a32d01670f732c46de936093d714e2954"

class LoginResponse {
  LoginResponse({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
    this.message,
  });

  LoginResponse.fromJson(dynamic json) {
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    message = json['message'];
  }

  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;
  String message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token_type'] = tokenType;
    map['expires_in'] = expiresIn;
    map['access_token'] = accessToken;
    map['refresh_token'] = refreshToken;
    map['message'] = message;
    return map;
  }
}
