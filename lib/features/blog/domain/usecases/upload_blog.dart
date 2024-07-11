import 'dart:io';
import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blogapp/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

import '../entities/blog.dart';

class UploadBlog implements useCase<Blog,UploadBlogParams>{
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async{
    return await blogRepository.uploadBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        userId: params.uid,
        topics: params.topics);
  }
  
}

class UploadBlogParams{
  final String uid;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.uid,
    required this.title,
    required this.content,
    required this.image,
    required this.topics});
}