import 'dart:ffi';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twitter_clone/features/feed/domain/entities/post_entity.dart';
import 'package:twitter_clone/features/feed/domain/repository/post_repository.dart';

class SupabasePostsRepository implements PostRepository {
  final SupabaseClient client;

  SupabasePostsRepository({required this.client});

  String postsTableName = "posts";
  String likeTableName = "likes";

  @override
  Future<bool> createPost({required PostEntity post}) async {
    try {
      final data = post.toJson();
      await client.from(postsTableName).insert(data);
      return true;
    } catch (e) {
      throw Exception("Failed to create post : $e");
    }
  }

  @override
  Future<List<PostEntity>> fetchPost() async {
    try {
      final response = await client
          .from(postsTableName)
          .select()
          .order('created_at', ascending: false);

      return (response as List).map((json) {
        return PostEntity.fromJson(json);
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch posts");
    }
  }

  @override
  Future<bool> likePost({
    required String userId,
    required String postId,
  }) async {
    try {
      final response = await client
          .from(postsTableName)
          .select('likes_count')
          .eq('id', postId)
          .single();

      final currentLikes = response['likes_count'] ?? 0;

      final existingLike = await client
          .from(likeTableName)
          .select()
          .eq('user_id', userId)
          .eq('post_id', postId)
          .maybeSingle();

      if (existingLike != null) {
        await client
            .from(likeTableName)
            .delete()
            .eq('user_id', userId)
            .eq('post_id', postId);

        await client
            .from(postsTableName)
            .update({"likes_count": currentLikes - 1})
            .eq('id', postId);
      } else {
        await client.from(likeTableName).insert({
          'user_id':userId,
          'post_id':postId,
        });

        await client
            .from(postsTableName)
            .update({'likes_count': currentLikes + 1})
            .eq('id', postId);
      }

      return true;
    } catch (e) {
      throw Exception("Failed to like post: $e");
    }
  }
}
