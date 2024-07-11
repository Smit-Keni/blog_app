import '../../../../core/common/entities/user.dart';


class UserModel extends User{
  UserModel({
    required super.id,
    required super.email,
    required super.name});

  factory UserModel.fromJson(Map<String,dynamic>map){
    return UserModel(
        id: map['uid'] ?? '',
        email: map['email'] ?? '',
        name: map['name'] ?? ''
    );
  }



}