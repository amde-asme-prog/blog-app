import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  List<BlogModel> getAllLocalBlogs();
  void uploadBlogsLocally({required List<BlogModel> blogs});
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  BlogLocalDataSourceImpl(this.box);

  final Box box;

  @override
  List<BlogModel> getAllLocalBlogs() {
    final blogs = <BlogModel>[];

    box.read(() {
      for (var key in box.keys) {
        final blog = box.get(key);
        if (blog != null) {
          blogs.add(BlogModel.fromJson(blog));
        }
      }
    });
    return blogs;
  }

  @override
  void uploadBlogsLocally({required List<BlogModel> blogs}) {
    box.clear();
    box.write(() {
      for (var blog in blogs) {
        box.put(blog.id, blog.toJson());
      }
    });
  }
}
