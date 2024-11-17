import 'dart:io';

import 'package:blog_app/core/common/cubits/user_cubit/user_cubit_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/constant/routes.dart';
import 'package:blog_app/core/utils/image_picker.dart';
import 'package:blog_app/core/utils/show_snack_bar.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_field.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_form_image_container.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_topic_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlog extends StatefulWidget {
  const AddNewBlog({super.key, this.blog});
  final dynamic blog;
  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final file = await imagePicker();
    if (file != null) {
      setState(() {
        image = file;
      });
    }
  }

  //on update request
  void textFieldValueInitialize(Blog blog) {
    titleController.text = blog.title;
    contentController.text = blog.content;
    selectedTopics = blog.topics;
  }

  @override
  void initState() {
    if (widget.blog != null) {
      textFieldValueInitialize(widget.blog);
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();

    super.dispose();
  }

  void addBlog(BuildContext context) {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final userId =
          (context.read<UserCubitCubit>().state as AppUserState).user.id;
      context.read<BlogBloc>().add(BlogAddEvent(
          title: titleController.text,
          content: contentController.text,
          posterId: userId,
          topics: selectedTopics,
          image: image!));
    }
  }

  void updateBlog(BuildContext context) {
    if (formKey.currentState!.validate() && selectedTopics.isNotEmpty) {
      Blog blogData = widget.blog as Blog;
      
      context.read<BlogBloc>().add(BlogUpdateEvent(
          image: image,
          id: blogData.id,
          updatedAt: blogData.updatedAt,
          title: titleController.text,
          content: contentController.text,
          posterId: blogData.posterId,
          imageUrl: blogData.imageUrl,
          topics: selectedTopics));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (widget.blog != null) {
                  updateBlog(context);
                } else {
                  addBlog(context);
                }
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.messsage);
          } else if (state is BlogSucess) {
            Navigator.pushNamedAndRemoveUntil(context,
                RouteNames.initialRouteName, (Route<dynamic> route) => false);
          } else if (state is BlogUpdateSucess) {
            showSnackBar(context, state.message);
            Navigator.pushNamedAndRemoveUntil(context,
                RouteNames.initialRouteName, (Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    BlogFormImageContainer(
                        image: image,
                        selectImage: selectImage,
                        blog: widget.blog),
                    //category row
                    BlogTopicRow(selectedTopics: selectedTopics),
                    //fields
                    const SizedBox(
                      height: 10,
                    ),
                    BlogField(
                        controller: titleController,
                        hinText: Constant.blogFormFieldTitle),
                    const SizedBox(
                      height: 10,
                    ),
                    BlogField(
                        controller: contentController,
                        hinText: Constant.blogFormFieldContent)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
