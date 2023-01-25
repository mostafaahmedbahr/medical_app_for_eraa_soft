class LoginModel {
  Data? data;
  String? token;
  String? message;
  int? code;
  dynamic errors;

  LoginModel({this.data, this.token, this.message, this.code, this.errors});

  LoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?   Data.fromJson(json['data']) : null;
    token = json['token'];
    message = json['message'];
    code = json['code'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] =    token;
    data['message'] =  message;
    data['code'] =     code;
    data['errors'] =   errors;
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
  List<PatientId>? patientId;
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
      patientId = <PatientId>[];
      json['patient_id'].forEach((v) {
        patientId!.add(  PatientId.fromJson(v));
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
    data['type'] =     type;
    if ( patientId != null) {
      data['patient_id'] =  patientId!.map((v) => v.toJson()).toList();
    }
    data['created_at'] =  createdAt;
    data['updated_at'] =  updatedAt;
    return data;
  }
}

class PatientId {
  int? id;
  String? name;
  String? dateOfBirth;
  String? diagnosis;
  String? address;
  String? visitTime;
  int? userId;
  String? createdAt;
  String? updatedAt;

  PatientId(
      {this.id,
        this.name,
        this.dateOfBirth,
        this.diagnosis,
        this.address,
        this.visitTime,
        this.userId,
        this.createdAt,
        this.updatedAt});

  PatientId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
    diagnosis = json['diagnosis'];
    address = json['address'];
    visitTime = json['visit_time'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['id'] =    id;
    data['name'] =  name;
    data['date_of_birth'] =  dateOfBirth;
    data['diagnosis'] =  diagnosis;
    data['address'] =  address;
    data['visit_time'] =  visitTime;
    data['user_id'] =     userId;
    data['created_at'] =  createdAt;
    data['updated_at'] =  updatedAt;
    return data;
  }
}
