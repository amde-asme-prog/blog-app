import 'dart:io';

import 'package:blog_app/config/theme/app_palette.dart';
import 'package:blog_app/core/common/widgets/loading.dart';
import 'package:blog_app/core/cubits/app_user/user_cubit.dart';
import 'package:blog_app/core/utils/app_navigator.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlogHandler() {
    if (formKey.currentState!.validate() &&
        image != null &&
        selectedTopics.isNotEmpty) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;

      context.read<BlogBloc>().add(
            UploadBlog(
              title: titleController.text.trim(),
              content: contentController.text.trim(),
              topics: selectedTopics,
              posterId: posterId,
              image: image!,
            ),
          );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            AppNavigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.chevron_back,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              uploadBlogHandler();
            },
            icon: const Icon(
              Icons.done_rounded,
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is BlogSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Blog uploaded successfully'),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
            AppNavigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return Loading();
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    child: image != null
                        ? SizedBox(
                            width: double.infinity,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : DottedBorder(
                            color: AppPalette.borderColor,
                            dashPattern: const [10, 6],
                            radius: Radius.circular(10),
                            borderType: BorderType.RRect,
                            strokeCap: StrokeCap.round,
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Icon(
                                    CupertinoIcons.folder_open,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Select your image",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        'Technology',
                        'Business',
                        'Programming',
                        'Entertainment',
                      ]
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                if (selectedTopics.contains(e)) {
                                  selectedTopics.remove(e);
                                } else {
                                  selectedTopics.add(e);
                                }
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Chip(
                                  label: Text(e),
                                  color: WidgetStatePropertyAll(
                                    selectedTopics.contains(e)
                                        ? AppPalette.gradient1
                                        : null,
                                  ),
                                  side: selectedTopics.contains(e)
                                      ? null
                                      : const BorderSide(
                                          color: AppPalette.borderColor,
                                        ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlogEditor(
                    hintText: 'Blog Title',
                    controller: titleController,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlogEditor(
                    hintText: 'Blog Content',
                    controller: contentController,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
