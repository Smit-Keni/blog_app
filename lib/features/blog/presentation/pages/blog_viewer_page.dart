import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:blogapp/core/utils/calculate_reading_time.dart';
import 'package:blogapp/core/utils/format_date.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/blog.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog)=>MaterialPageRoute(builder: (context)=>BlogViewerPage(blog: blog,));
  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(blog.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),),
                const SizedBox(height: 20,),
                Text("By ${blog.uid}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                ),),
                const SizedBox(height: 5,),
                Text("${formatDatebyDMMMYYYY(blog.createdAt)} . ${calculateReadingTime(blog.content)} min",
                style: const TextStyle(
                  fontSize: 16,
                  color: AppPallete.greyColor
                ),),
                const SizedBox(height: 20,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:Image.network(blog.imageUrl),
                ),
                const SizedBox(height: 20,),
                Text(blog.content,style: const TextStyle(
                  fontSize: 16,
                  height: 2
                ),)
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
