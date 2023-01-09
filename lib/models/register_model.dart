class RegisterModel {
  Data? data;
  String? token;
  String? message;
  int? code;
  List<void>? errors;
  RegisterModel({this.data, this.token, this.message, this.code, this.errors});
  RegisterModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?   Data.fromJson(json['data']) : null;
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
    final Map<String, dynamic> data =   <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] =    token;
    data['message'] =  message;
    data['code'] =     code;
    if ( errors != null) {
      // data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? title;
  String? address;
  String? type;
  List<void>? patientId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.email,
        this.title,
        this.address,
        this.type,
        this.patientId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    title = json['title'];
    address = json['address'];
    type = json['type'];
    if (json['patient_id'] != null) {
      patientId = <Null>[];
      json['patient_id'].forEach((v) {
        // patientId!.add(new Null.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['id'] =     id;
    data['name'] =   name;
    data['email'] =  email;
    data['title'] =  title;
    data['address'] =  address;
    data['type'] =  type;
    if ( patientId != null) {
      // data['patient_id'] = this.patientId!.map((v) => v.toJson()).toList();
    }
    data['created_at'] =  createdAt;
    data['updated_at'] =  updatedAt;
    return data;
  }
}
