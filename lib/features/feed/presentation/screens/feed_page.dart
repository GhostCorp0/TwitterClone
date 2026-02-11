import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/feed_event.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/feed_state.dart';

import '../../../../core/utils.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feed")),
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
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.username),
                  subtitle: Text(post.content),
                  trailing: Text(formatDate(post.createdAt)),
                );
              },
            );
          } else if (state is FeedFailure) {
            return Center(child: Text("Error : ${state.message}"));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
