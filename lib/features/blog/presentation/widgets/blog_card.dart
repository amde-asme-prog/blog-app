import 'package:blog_app/core/utils/app_navigator.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_details_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog, required this.color});

  final Blog blog;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(
          context,
          BlogDetailsPage(blog: blog),
        );
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: blog.topics
                    .map(
                      (topic) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Chip(
                          label: Text(
                            topic,
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.blue.shade100,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Text('${calculateReadingTime(blog.content).toString()} min'),
          ],
        ),
      ),
    );
  }
}
