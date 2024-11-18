import 'dart:io';

import 'package:blog_app/core/constant/supabase_constant.dart';
import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogDataSource {
  Future<BlogModel> addBlog(BlogModel blog);
  Future<BlogModel> updateBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
  Future<String> updateBlogImage({
    required File image,
    required BlogModel blog,
  });
  Future<List<BlogModel>> getBlogs();
}

class BlogDataSourceImpl implements BlogDataSource {
  final SupabaseClient supabaseClient;
  BlogDataSourceImpl(this.supabaseClient);
//add new blog - to table
  @override
  Future<BlogModel> addBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient
          .from(SupabaseConstant.blogTableName)
          .insert(blog.toJson())
          .select();
      BlogModel res = BlogModel.fromJson(blogData.first);

      return res;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

//upload image to storage
  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    return _uploadImage(
        image: image,
        blog: blog,
        inserFunc: () async {
          await supabaseClient.storage
              .from(SupabaseConstant.blogStorageName)
              .upload(blog.id, image);
        });
  }

//update image in storage
  @override
  Future<String> updateBlogImage(
      {required File image, required BlogModel blog}) async {
    return _uploadImage(
        image: image,
        blog: blog,
        inserFunc: () async {
          final res = await supabaseClient.storage
              .from(SupabaseConstant.blogStorageName)
              .update(blog.id, image);
          print('inserFunc' + res);
        });
  }

  @override
  Future<List<BlogModel>> getBlogs() async {
    try {
      final blogs =
          await supabaseClient.from(SupabaseConstant.blogTableName).select();
      final listedBlogs =
          blogs.map((blog) => BlogModel.fromJson(blog)).toList();

      return listedBlogs;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<BlogModel> updateBlog(BlogModel blog) async {
    try {
      final updatedBlog = await supabaseClient
          .from(SupabaseConstant.blogTableName)
          .update(blog.toJson())
          .eq('id', blog.id)
          .select();
      return BlogModel.fromJson(updatedBlog.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  //upload blog
  Future<String> _uploadImage(
      {required File image,
      required BlogModel blog,
      required Function inserFunc}) async {
    try {
      await inserFunc();

      final url = supabaseClient.storage
          .from(SupabaseConstant.blogStorageName)
          .getPublicUrl(blog.id);
      print('url' + url);
      return url;
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
