import 'dart:io';
import 'package:blog_app/core/common/cubits/user_cubit/user_cubit_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/constant/routes.dart';
import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/core/utils/image_picker.dart';
import 'package:blog_app/core/utils/show_snack_bar.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_field.dart';
import 'package:dotted_border/dotted_border.dart';
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

  void _selectImage() async {
    final file = await imagePicker();
    if (file != null) {
      setState(() {
        image = file;
      });
    }
  }
Widget imageOrImageIconDisplay() {
    if (widget.blog == null) {
      //imageIconAndText
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 40,
          ),
          SizedBox(
            height: 15,
          ),
          Text(Constant.blogFormAddImage)
        ],
      );
    } else {
      //image from link
      return Image.network(
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return const Loader();
          }
        },
        widget.blog.imageUrl,
        fit: BoxFit.cover,
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (formKey.currentState!.validate() &&
                    selectedTopics.isNotEmpty &&
                    image != null) {
                  final userId =
                      (context.read<UserCubitCubit>().state as AppUserState)
                          .user
                          .id;
                  context.read<BlogBloc>().add(BlogAddEvent(
                      title: titleController.text,
                      content: contentController.text,
                      posterId: userId,
                      topics: selectedTopics,
                      image: image!));
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
            Navigator.pushNamedAndRemoveUntil(
                context,RouteNames.initialRouteName, (Route<dynamic> route) => false);
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
                    //add image container
                    GestureDetector(
                      onTap: () {
                        _selectImage();
                      },
                      child: DottedBorder(
                        color: AppPalette.borderColor,
                        dashPattern: const [10, 4],
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: image == null
                              ? imageOrImageIconDisplay()
                              : Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    //category row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: Constant.topics
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (selectedTopics.contains(e)) {
                                        selectedTopics.remove(e);
                                      } else {
                                        selectedTopics.add(e);
                                      }

                                      setState(() {});
                                    },
                                    child: Chip(
                                      label: Text(e),
                                      color: selectedTopics.contains(e)
                                          ? const WidgetStatePropertyAll(
                                              AppPalette.gradient2)
                                          : null,
                                      side: const BorderSide(
                                          color: AppPalette.borderColor),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
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
