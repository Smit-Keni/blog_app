import 'dart:io';

import 'package:blogapp/core/error/exceptions.dart';
import 'package:blogapp/features/auth/data/models/user_json_model.dart';
import 'package:blogapp/features/blog/data/models/blog_json_model.dart';
import 'package:blogapp/features/blog/data/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:core';

import '../models/blog_fetch_model.dart';

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
      final blogsQuery = await FirebaseFirestore.instance
          .collection("blogs")
          .get();
      //     .then((onValue) {
      //   onValue.docs.forEach((record) {
      //         final e= record.data();
      //         //(record) => BlogModel.fromSnapshot(record);
      //   });
      // });

      // final blogRecord =
      //     blogsQuery.docs.map((e) => (e.data()));

      final blogRecord =
         blogsQuery.docs.map((e)=>BlogModel.fromSnapshot(e)).toList();

      // final blogRecord =
      // blogsQuery.toList();

      // final blogR =
      // blogsQuery.docs.map((e) => print(e));

      //print(blogRecord);

      return blogRecord;
      //return blogRecord.map((e)=>BlogModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
