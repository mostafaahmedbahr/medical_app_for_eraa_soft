class GetAllPatientModel {
  Data? data;
  String? message;
  int? code;
  String? errors;

  GetAllPatientModel({this.data, this.message, this.code, this.errors});

  GetAllPatientModel.fromJson(Map<String, dynamic> json) {
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
    data['message'] =  message;
    data['code'] =     code;
    data['errors'] =   errors;
    return data;
  }
}

class Data {
  List<Data>? data;
  Links? links;
  Meta? meta;

  Data({this.data, this.links, this.meta});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(  Data.fromJson(v));
      });
    }
    links = json['links'] != null ?   Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ?     Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    return data;
  }
}

class Data2 {
  int? id;
  String? name;
  String? dateOfBirth;
  String? diagnosis;
  String? address;
  String? visitTime;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Data2(
      {this.id,
        this.name,
        this.dateOfBirth,
        this.diagnosis,
        this.address,
        this.visitTime,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Data2.fromJson(Map<String, dynamic> json) {
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
    data['diagnosis'] =      diagnosis;
    data['address'] =        address;
    data['visit_time'] =     visitTime;
    data['user_id'] =     userId;
    data['created_at'] =  createdAt;
    data['updated_at'] =  updatedAt;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  void prev;
  void next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    // prev = json['prev'];
    // next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['first'] = first;
    data['last'] =  last;
    // data['prev'] =  prev;
    // data['next'] =  next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.links,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(  Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['current_page'] =  currentPage;
    data['from'] =  from;
    data['last_page'] =  lastPage;
    if ( links != null) {
      data['links'] =  links!.map((v) => v.toJson()).toList();
    }
    data['path'] =     path;
    data['per_page'] = perPage;
    data['to'] =     to;
    data['total'] =  total;
    return data;
  }
}

class Links2 {
  String? url;
  String? label;
  bool? active;

  Links2({this.url, this.label, this.active});

  Links2.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['url'] =     url;
    data['label'] =   label;
    data['active'] =  active;
    return data;
  }
}
