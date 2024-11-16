import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/show_snack_bar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    // final userId =
    //     (context.read<UserCubitCubit>().state as AppUserState).user.id;
    context.read<BlogBloc>().add(BlogReadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blog App'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add_new_blog');
                },
                icon: const Icon(Icons.add_circle))
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.messsage);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            } else if (state is BlogListSucess) {
              return ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.blogs.length,
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemBuilder: (context, index) {
                    final blog = state.blogs[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/single_blog_page',
                            arguments: blog, 
                          );
                        },
                        child: BlogCard(blog: blog));
                  });
            }
            return const SizedBox();
          },
        ));
  }
}
