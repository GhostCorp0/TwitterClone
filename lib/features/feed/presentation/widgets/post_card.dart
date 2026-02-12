import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/features/auth/domain/services/user_session_service.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:twitter_clone/features/feed/presentation/bloc/feed/feed_event.dart';

import '../../../../core/utils.dart';
import '../../domain/entities/post_entity.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 20, backgroundColor: Colors.grey,backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSr7V6XIZadjlKNetL-VZRaqkCOFBXMEUwEBw&s"),),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post.username,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 5),
                        Spacer(),
                        Text(
                          formatDate(post.createdAt),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      post.content,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),

                    if (post.imageUrl != null && post.imageUrl!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(post.imageUrl!,fit: BoxFit.cover,width: double.infinity,),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PostState(
                icon: post.isLikedByCurrentUser ==true?Icons.favorite:Icons.favorite_border,
                iconColor: post.isLikedByCurrentUser == true?Colors.red:Colors.grey,
                count: post.likesCount,
                onTap: () {
                  final userSessionService = context.read<UserSessionService>();
                  userSessionService.getUserSession().then((session) {
                    if (session != null) {
                      context.read<FeedBloc>().add(
                        LikePostRequested(postId: post.id!, userId: session.id),
                      );
                    }
                  });
                },
              ),
              _PostState(
                icon: Icons.comment,
                count: post.commentsCount,
                onTap: () {},
              ),
              _PostState(
                icon: Icons.loop,
                count: post.repostsCount,
                onTap: () {},
              ),
              Icon(Icons.share, color: Colors.grey, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class _PostState extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final int? count;
  final VoidCallback onTap;

  const _PostState({
    required this.icon,
    this.count,
    required this.onTap, this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 10),
          Text(
            '${count ?? 0}',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
