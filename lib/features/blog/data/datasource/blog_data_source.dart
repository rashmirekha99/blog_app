import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogDataSource {
  Future<BlogModel> addBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
  Future<List<BlogModel>> getBlogs();
}

class BlogDataSourceImpl implements BlogDataSource {
  final SupabaseClient supabaseClient;
  BlogDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> addBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();
      BlogModel res = BlogModel.fromJson(blogData.first);

      return res;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);

      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getBlogs() async {
    try {
      // final blogs =
      //     await supabaseClient.from('blogs').select().eq('poster_id', userId);

      final blogs = await supabaseClient.from('blogs').select();
      final listedBlogs =
          blogs.map((blog) => BlogModel.fromJson(blog)).toList();

      return listedBlogs;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
