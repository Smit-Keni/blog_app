part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent{
  final String uid;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  BlogUpload({
    required this.uid,
    required this.title,
    required this.content,
    required this.image,
    required this.topics});

}

final class BlogFetchAllBlogs extends BlogEvent{}
