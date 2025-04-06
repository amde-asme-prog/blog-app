import 'package:blog_app/config/theme/app_palette.dart';
import 'package:blog_app/core/utils/app_navigator.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_details_page.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/core/utils/format_date.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog, required this.color});

  final Blog blog;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        AppNavigator.push(
          context,
          BlogDetailsPage(blog: blog),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: color,
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            if (blog.imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  blog.imagePath!,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppPalette.primaryGradient,
                    ),
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: AppPalette.whiteColor,
                      size: 40,
                    ),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title section
                  Text(
                    blog.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: isDark
                          ? AppPalette.whiteColor
                          : AppPalette.textDarkColor,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  // Author and date section
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: isDark
                            ? AppPalette.gradient2.withValues(alpha: 0.3)
                            : AppPalette.gradient1.withValues(alpha: 0.3),
                        child: Text(
                          blog.posterName?.isNotEmpty == true
                              ? blog.posterName![0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppPalette.gradient2
                                : AppPalette.gradient1,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          blog.posterName ?? 'Anonymous',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        formatDateByDDMMYYYY(blog.updatedAt),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppPalette.greyColor.withValues(alpha: 0.8)
                              : AppPalette.greyColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Topic chips and reading time
                  Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: blog.topics
                                .map(
                                  (topic) => Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Chip(
                                      label: Text(
                                        topic,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppPalette.textDarkColor,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 0),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppPalette.gradient2.withValues(alpha: 0.1)
                              : AppPalette.gradient1.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 14,
                              color: isDark
                                  ? AppPalette.gradient2
                                  : AppPalette.gradient1,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${calculateReadingTime(blog.content)} min',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? AppPalette.gradient2
                                    : AppPalette.gradient1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
