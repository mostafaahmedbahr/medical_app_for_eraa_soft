class AddPatientModel {
  Data? data;
  String? message;
  int? code;
  String? errors;

  AddPatientModel({this.data, this.message, this.code, this.errors});

  AddPatientModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?   Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['code'] =    code;
    data['errors'] =  errors;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? dateOfBirth;
  String? diagnosis;
  String? address;
  String? visitTime;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.dateOfBirth,
        this.diagnosis,
        this.address,
        this.visitTime,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
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
    data['address'] =    address;
    data['visit_time'] =  visitTime;
    data['user_id'] =     userId;
    data['created_at'] =  createdAt;
    data['updated_at'] =  updatedAt;
    return data;
  }
}
