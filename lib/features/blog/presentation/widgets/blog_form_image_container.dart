import 'dart:io';

import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/features/blog/domain/enities/blog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class BlogFormImageContainer extends StatefulWidget {
  const BlogFormImageContainer({
    super.key,
    required this.image,
    required this.selectImage,
    required this.blog,
  });
  final File? image;
  final VoidCallback selectImage;
  final Blog? blog;

  @override
  State<BlogFormImageContainer> createState() => _BlogFormImageContainerState();
}

class _BlogFormImageContainerState extends State<BlogFormImageContainer> {
  @override
  Widget build(BuildContext context) {
    return //add image container
        GestureDetector(
      onTap: widget.selectImage,
      child: DottedBorder(
        color: AppPalette.borderColor,
        dashPattern: const [10, 4],
        radius: const Radius.circular(10),
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: widget.image != null
              ? Image.file(
                  widget.image!,
                  fit: BoxFit.cover,
                )
              : widget.blog == null
                  ? const Column(
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
                    )
                  : CachedNetworkImage(
                      useOldImageOnUrlChange: true,
                      cacheKey: widget.blog?.imageUrl,
                      fit: BoxFit.fitWidth,
                      imageUrl: widget.blog!.imageUrl,
                      placeholder: (context, url) => const Loader(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
        ),
      ),
    );
  }
}
