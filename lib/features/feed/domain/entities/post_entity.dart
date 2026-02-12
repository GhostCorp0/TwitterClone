class   PostEntity {
  final String? id;
  final String userId;
  final String username;
  final String content;
  final DateTime createdAt;
  final int? likesCount;
  final int? commentsCount;
  final int? repostsCount;
  final String? imageUrl;

  PostEntity({
    this.id,
    required this.userId,
    required this.username,
    required this.content,
    required this.createdAt,
    this.likesCount,
    this.commentsCount,
    this.repostsCount,
    this.imageUrl,
  }) {
    if (username.trim().isEmpty) {
      throw Exception("Username cannot be empty");
    }

    if (content.trim().isEmpty) {
      throw Exception("Post content cannot be empty");
    }
  }

  //Serialization layer
  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      id:json['id'],
      userId: json['user_id'],
      username: json['username'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      imageUrl: json['image_url'],
      likesCount: json['likes_count'],
      commentsCount:json['comments_count'],
      repostsCount: json['reposts_count']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      if(id != null) 'id':id,
      'user_id':userId,
      'user_name':username,
      'content':content,
      'created_at':createdAt.toIso8601String(),
      'image_url':imageUrl,
      'likes_count':likesCount,
      'comments_count':commentsCount,
      'reposts_count':repostsCount
    };
  }

  bool hasImage() => imageUrl!=null && imageUrl!.isNotEmpty;

}
