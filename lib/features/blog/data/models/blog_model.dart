import 'package:blogapp/features/blog/domain/entities/blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel extends Blog{
  BlogModel({required super.id,
    required super.uid,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.createdAt,
    });


  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map["id"] as String,
      uid: map["uid"] as String,
      title: map["title"] as String,
      content: map["content"] as String,
      imageUrl: map["image_url"] as String,
      topics: List<String>.from(map['topics'] ?? []),
      createdAt: map['created_at']==null?DateTime.now() :DateTime.parse(map['created_at']),
    );
  }

  factory BlogModel.fromSnapshot(DocumentSnapshot <Map<String,dynamic>> document){

    //final data = document.data()!;
    final data = document.data()!;
    return BlogModel(
        id: data["id"],
        uid: data["uid"],
        title: data["title"],
        content: data["content"],
        imageUrl: data["image_url"],
        topics: List<String>.from(data["topics"]),
        createdAt: DateTime.parse(data["created_at"]),

    );


  }

  Map<String, dynamic> toJson() {
    return <String,dynamic>{
      "id": id,
      "uid": uid,
      "title": title,
      "content": content,
      "image_url": imageUrl,
      "topics": topics,
      "created_at": createdAt.toIso8601String(),
    };
  }

  BlogModel copyWith({
    String? id,
    String? uid,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? createdAt,

  }){
    return BlogModel(
      id: id?? this.id,
      uid: uid?? this.uid,
      title: title?? this.title,
      content: content?? this.content,
      imageUrl: imageUrl?? this.imageUrl,
      topics: topics?? this.topics,
      createdAt: createdAt ?? this.createdAt,

    );
  }
//

}