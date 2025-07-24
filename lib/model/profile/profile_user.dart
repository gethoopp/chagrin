import 'package:equatable/equatable.dart';

class ProfieUser extends Equatable {
  const ProfieUser({required this.message, required this.data});

  final String? message;
  final Data? data;

  ProfieUser copyWith({String? message, Data? data}) {
    return ProfieUser(
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory ProfieUser.fromJson(Map<String, dynamic> json) {
    return ProfieUser(
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};

  @override
  List<Object?> get props => [message, data];
}

class Data extends Equatable {
  const Data({
    required this.tokenType,
    required this.accessToken,
    required this.user,
  });

  final String? tokenType;
  final String? accessToken;
  final User? user;

  Data copyWith({String? tokenType, String? accessToken, User? user}) {
    return Data(
      tokenType: tokenType ?? this.tokenType,
      accessToken: accessToken ?? this.accessToken,
      user: user ?? this.user,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      tokenType: json["token_type"],
      accessToken: json["access_token"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "token_type": tokenType,
    "access_token": accessToken,
    "user": user?.toJson(),
  };

  @override
  List<Object?> get props => [tokenType, accessToken, user];
}

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.countryCode,
    required this.phoneNum,
    required this.phoneNumVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.avatar,
    required this.birthDate,
    required this.gender,
    required this.province,
    required this.suspendedAt,
    required this.tagId,
  });

  final String? id;
  final String? name;
  final String? email;
  final DateTime? emailVerifiedAt;
  final String? countryCode;
  final String? phoneNum;
  final dynamic phoneNumVerifiedAt;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic address;
  final dynamic avatar;
  final dynamic birthDate;
  final dynamic gender;
  final dynamic province;
  final dynamic suspendedAt;
  final dynamic tagId;

  User copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? emailVerifiedAt,
    String? countryCode,
    String? phoneNum,
    dynamic phoneNumVerifiedAt,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic address,
    dynamic avatar,
    dynamic birthDate,
    dynamic gender,
    dynamic province,
    dynamic suspendedAt,
    dynamic tagId,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      countryCode: countryCode ?? this.countryCode,
      phoneNum: phoneNum ?? this.phoneNum,
      phoneNumVerifiedAt: phoneNumVerifiedAt ?? this.phoneNumVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      province: province ?? this.province,
      suspendedAt: suspendedAt ?? this.suspendedAt,
      tagId: tagId ?? this.tagId,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      emailVerifiedAt: DateTime.tryParse(json["email_verified_at"] ?? ""),
      countryCode: json["country_code"],
      phoneNum: json["phone_num"],
      phoneNumVerifiedAt: json["phone_num_verified_at"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      address: json["address"],
      avatar: json["avatar"],
      birthDate: json["birth_date"],
      gender: json["gender"],
      province: json["province"],
      suspendedAt: json["suspended_at"],
      tagId: json["tag_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "country_code": countryCode,
    "phone_num": phoneNum,
    "phone_num_verified_at": phoneNumVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "address": address,
    "avatar": avatar,
    "birth_date": birthDate,
    "gender": gender,
    "province": province,
    "suspended_at": suspendedAt,
    "tag_id": tagId,
  };

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    emailVerifiedAt,
    countryCode,
    phoneNum,
    phoneNumVerifiedAt,
    createdAt,
    updatedAt,
    address,
    avatar,
    birthDate,
    gender,
    province,
    suspendedAt,
    tagId,
  ];
}
