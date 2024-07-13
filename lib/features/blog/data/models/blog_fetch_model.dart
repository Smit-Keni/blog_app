import 'package:blogapp/core/common/entities/user.dart';
import 'package:blogapp/features/blog/data/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlogFetchModel extends BlogModel{
  BlogFetchModel({
    required super.uid,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.createdAt,
    required super.id});


  factory BlogFetchModel.fromSnapshot(QueryDocumentSnapshot <Map<String,dynamic>> document){

    final data = document.data()!;
    return BlogFetchModel(
        uid: data["uid"],
        title: data["title"],
        content: data["content"],
        imageUrl: data["image_url"],
        topics: data["topics"],
        createdAt: data["created"],
        id: data["id"]
    );


  }
}