import 'package:blog_app/config/theme/app_palette.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';

class BlogDetailsPage extends StatelessWidget {
  const BlogDetailsPage({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: isDark
                  ? AppPalette.backgroundColor
                  : AppPalette.lightBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                background: blog.imagePath != null
                    ? Image.network(
                        blog.imagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          decoration: BoxDecoration(
                            gradient: AppPalette.primaryGradient,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: AppPalette.whiteColor,
                              size: 60,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          gradient: AppPalette.primaryGradient,
                        ),
                        child: Center(
                          child: Text(
                            blog.title.substring(0,
                                blog.title.length > 2 ? 2 : blog.title.length),
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: AppPalette.whiteColor,
                            ),
                          ),
                        ),
                      ),
              ),
              leading: IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppPalette.cardDarkColor.withValues(alpha: 0.7)
                        : AppPalette.whiteColor.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: isDark
                        ? AppPalette.whiteColor
                        : AppPalette.textDarkColor,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            // Content
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      blog.title,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Topics
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: blog.topics
                          .map((topic) => Chip(
                                label: Text(topic),
                              ))
                          .toList(),
                    ),

                    const SizedBox(height: 24),

                    // Author info and reading time
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: isDark
                              ? AppPalette.gradient2.withValues(alpha: 0.3)
                              : AppPalette.gradient1.withValues(alpha: 0.3),
                          child: Text(
                            blog.posterName?.isNotEmpty == true
                                ? blog.posterName![0].toUpperCase()
                                : '?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? AppPalette.gradient2
                                  : AppPalette.gradient1,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                blog.posterName ?? 'Anonymous',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${formatDateByDDMMYYYY(blog.updatedAt)} • ${calculateReadingTime(blog.content)} min read',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.hintColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Share button
                        IconButton(
                          icon: Icon(Icons.share_outlined),
                          onPressed: () {
                            // Implement share functionality
                          },
                        ),
                        // Bookmark button
                        IconButton(
                          icon: Icon(Icons.bookmark_border_outlined),
                          onPressed: () {
                            // Implement bookmark functionality
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Divider
                    Divider(height: 1, thickness: 1),

                    const SizedBox(height: 24),

                    // Content
                    Text(
                      blog.content,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.8,
                        letterSpacing: 0.3,
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Floating action button for quick actions
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show comment section or other actions
        },
        backgroundColor: isDark ? AppPalette.gradient2 : AppPalette.gradient1,
        child: Icon(Icons.comment_outlined, color: AppPalette.whiteColor),
      ),
    );
  }
}
