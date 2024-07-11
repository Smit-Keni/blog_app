import 'package:blogapp/core/common/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserJsonModel extends User{
  UserJsonModel({
    required super.id,
    required super.email,
    required super.name});


  factory UserJsonModel.fromSnapshot(DocumentSnapshot <Map<String,dynamic>> document){

    final data = document.data()!;
    return UserJsonModel(
        id: data["uid"],
        name:data["name"],
        email:data["email"]

    );
  }
}