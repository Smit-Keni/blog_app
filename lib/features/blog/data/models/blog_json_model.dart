import 'package:blogapp/core/common/entities/user.dart';
import 'package:blogapp/features/blog/data/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/blog.dart';

class BlogJsonModel extends Blog{
  BlogJsonModel({
     required super.uid,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.createdAt,
    required super.id,
    });


  factory BlogJsonModel.fromSnapshot(DocumentSnapshot <Map<String,dynamic>> document){

    //final data = document.data()!;
    final data = document.data()!;
    return BlogJsonModel(
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