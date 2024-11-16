import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void saveBlogsInLocal({required List<BlogModel> blog});
  List<BlogModel> readBlogsFromLocal();
}

class BlogLocalDataSourceImp implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImp(this.box);
  @override
  List<BlogModel> readBlogsFromLocal() {
    List<BlogModel> blogs = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        blogs.add(BlogModel.fromJson(box.get(i.toString())));
      }
    });
    return blogs;
  }

  @override
  void saveBlogsInLocal({required List<BlogModel> blog}) {
    box.clear();
    box.write(() {
      for (int i = 0; i < blog.length; i++) {
        box.put(i.toString(), blog[i].toJson());
      }
    });
  }
}
