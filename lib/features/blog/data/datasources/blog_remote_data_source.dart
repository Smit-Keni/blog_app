import 'dart:io';

import 'package:blogapp/core/error/exceptions.dart';
import 'package:blogapp/features/blog/data/models/blog_json_model.dart';
import 'package:blogapp/features/blog/data/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:core';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog});
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await FirebaseFirestore.instance
          .collection("blogs")
          .add(blog.toJson());

      return BlogModel.fromJson(blog.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    try {
      //upload the image to Firebase storage
      await FirebaseStorage.instance.ref().child(blog.id).putFile(image);

      return FirebaseStorage.instance.ref().child(blog.id).getDownloadURL();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await FirebaseFirestore.instance.collection("blogs").get();

      List<BlogModel> finalRecord = [];

      // for (var element in blogs) {
      final blogRecord =
          blogs.docs.map((e) => BlogJsonModel.fromSnapshot(e)).toList();

      for (var i in blogRecord) {
        var blogInfo = await FirebaseFirestore.instance
            .collection("blogs")
            .where("uid", isEqualTo: i.toString())
            .get();
        blogInfo.docs.map((e) => BlogJsonModel.fromSnapshot(e)).single;
        var posterId =
            await FirebaseFirestore.instance.collection("users").where("uid");
      }
      // final blogRecordJson = {
      //   "created": blogRecord.createdAt,
      //   "content": blogRecord.content,
      //   "image_url": blogRecord.imageUrl,
      //   "title": blogRecord.title,
      //   "topics": blogRecord.topics,
      //   "uid": blogRecord.uid,
      //   "id": blogRecord.id
      // };
      //}
      //return blogRecord.map((blog) => BlogModel.fromJson(blog)).toList();
      print(blogRecord);

      return blogRecord;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
