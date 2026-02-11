import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/post/create_post_event.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/post/create_post_state.dart';

import '../bloc/feed/feed_bloc.dart';
import '../bloc/feed/feed_event.dart';
import '../bloc/feed/feed_state.dart';
import '../bloc/post/create_post_bloc.dart';
import '../widgets/post_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    context.read<FeedBloc>().add(FetchPostsRequested());
    super.initState();
  }

  void _showCreatePostDialog(BuildContext context) {
    final TextEditingController contentController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final feedContext = context;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocConsumer<CreatePostBloc, CreatePostState>(
          listener: (_, state) {
            if (state is CreatePostSuccess) {
              Navigator.pop(dialogContext);
              feedContext.read<FeedBloc>().add(FetchPostsRequested());
              ScaffoldMessenger.of(
                feedContext,
              ).showSnackBar(const SnackBar(content: Text("Post Created")));
            } else if (state is CreatePostFailure) {
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(
                feedContext,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return AlertDialog(
              title: Text("Create Post"),
              content: Form(
                key: formKey,
                child: TextFormField(
                  controller: contentController,
                  decoration: InputDecoration(hintText: "What's happening?"),
                  maxLines: 5,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Content is required'
                      : null,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: state is CreatePostLoading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            context.read<CreatePostBloc>().add(
                              CreatePostRequested(
                                imageUrl: "",
                                username: 'Aman Singh',
                                content: contentController.text.trim(),
                                userId: '127',
                              ),
                            );
                          }
                        },
                  child: state is CreatePostLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Post"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(onPressed:(){}, icon:Icon(Icons.mail_outline,color:Colors.white))
        ],
        title:Image.asset("assets/images/logo.png",width: 32,height:32),
        backgroundColor: Colors.black,
        elevation: 0.5,
        leading: Padding(padding: EdgeInsets.all(8.0),
        child: CircleAvatar(backgroundColor: Colors.grey[800])),
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FeedLoaded) {
            final posts = state.posts;
            if (posts.isEmpty) {
              return const Center(child: Text("No posts found"));
            }
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) => PostCard(post: posts[index]),
            );
          } else if (state is FeedFailure) {
            return Center(child: Text("Error : ${state.message}"));
          }
          return SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePostDialog(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add,color: Colors.white),
      ),
    );
  }
}
