class Blog{
  final String id;
  final String uid;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime createdAt;


  Blog(
      {required this.id,
        required this.uid,
        required this.title,
        required this.content,
        required this.imageUrl,
        required this.topics,
        required this.createdAt,
       });


}