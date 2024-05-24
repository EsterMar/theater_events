class AuthenticationData {
  String? accessToken;
  String? refreshToken;
  String? error;
  int? expiresIn;
  static AuthenticationData? instance;

  AuthenticationData({this.accessToken, this.refreshToken, this.error, this.expiresIn,});


  factory AuthenticationData.fromJson(Map<String, dynamic> json) {
    return AuthenticationData(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      error: json['error_description'],
      expiresIn: json['expires_in'],
    );
  }


  static AuthenticationData getInstance() {
    if (instance == null) {
      return AuthenticationData(accessToken: "",refreshToken: "");
      //throw Exception('AuthenticationData is still not initialized');
    }
    return instance!;
  }

  String? getAccessToken() {
    return accessToken;
  }


  bool hasError() {
    return error != null;
  }

  void reset() {
    accessToken = '';
    refreshToken = '';
    expiresIn = 0;
  }
}