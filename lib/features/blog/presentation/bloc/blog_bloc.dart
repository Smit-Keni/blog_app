import 'dart:io';

import 'package:blogapp/features/auth/domain/usecases/current_user.dart';
import 'package:blogapp/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blogapp/features/blog/domain/usecases/upload_blog.dart';

import '../../domain/entities/blog.dart';
import '../../domain/usecases/get_all_blogs.dart';


part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs
}) : _uploadBlog= uploadBlog,
    _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit)=>emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllblogs);


  }

  void _onBlogUpload(
      BlogUpload event,
      Emitter<BlogState>emit)async{
    final res = await _uploadBlog(UploadBlogParams(
        uid: event.uid,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics));

    res.fold((l)=>emit(BlogFailure(l.message)),(r)=>emit(BlogUploadSuccess()));
  }

  void _onFetchAllblogs(
      BlogFetchAllBlogs event,
      Emitter<BlogState> emit,
      )async{
    final res = await _getAllBlogs(noParams());

    res.fold((l)=>emit(BlogFailure(l.message)),
        (r)=>emit(BlogDisplaySuccess(r)));
  }


}
