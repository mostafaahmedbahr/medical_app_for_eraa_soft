class LogoutModel {
  String? data;
  String? token;
  String? message;
  int? code;
  List<void>? errors;

  LogoutModel({this.data, this.token, this.message, this.code, this.errors});

  LogoutModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    token = json['token'];
    message = json['message'];
    code = json['code'];
    if (json['errors'] != null) {
      errors = <Null>[];
      json['errors'].forEach((v) {
        // errors!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['token'] = this.token;
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.errors != null) {
      // data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
