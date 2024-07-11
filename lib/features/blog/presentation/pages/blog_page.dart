import 'package:blogapp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blogapp/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blogapp/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/exceptions.dart';
import '../../data/models/blog_json_model.dart';
import '../../data/models/blog_model.dart';


class BlogPage extends StatefulWidget {
  static route()=>MaterialPageRoute(
      builder: (context)=>const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  @override
  void initState() {

    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blogs"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, AddNewBlogPage.route());
              //getAllBlogs();
            },
            icon: const Icon(CupertinoIcons.add_circled),)
        ],
      ),
    );
  }
}
