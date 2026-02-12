import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twitter_clone/features/feed/domain/entities/post_entity.dart';
import 'package:twitter_clone/features/feed/domain/repository/post_repository.dart';

class SupabasePostsRepository implements PostRepository {
  final SupabaseClient client;
  SupabasePostsRepository({required this.client});
  String tableName = "posts";


  @override
  Future<bool> createPost({required PostEntity post}) async {
    try {
      final data = post.toJson();
      await client.from(tableName).insert(data);
      return true;
    } catch (e) {
      throw Exception("Failed to create post : $e");
    }
  }

  @override
  Future<List<PostEntity>> fetchPost() async {
    try {
      final response = await client
          .from(tableName)
          .select()
          .order('created_at', ascending: false);

      return (response as List).map((json){
        return PostEntity.fromJson(json);
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch posts");
    }
  }

}
