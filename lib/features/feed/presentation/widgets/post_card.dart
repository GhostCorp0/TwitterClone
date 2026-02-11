import 'package:flutter/material.dart';

import '../../../../core/utils.dart';
import '../../domain/entities/post_entity.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) { 
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical:8),
      elevation: 2,
       shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),
      child: Column(
         children: [
            Row(mainAxisAlignment: MainAxisAlignment .spaceBetween,children: [
              Text(post.username,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
              Text(formatDate(post.createdAt),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
            ],),
           SizedBox(height: 10),
           Text(post.content,style:TextStyle(fontSize: 15)),
           SizedBox(height:10),
           if(post.imageUrl != null && post.imageUrl!.isNotEmpty)...[
             const SizedBox(height: 10),
             ClipRRect(borderRadius:BorderRadius.circular(10),
             child:Image.network(post.imageUrl!)),
           ],
           const SizedBox(height: 10),
           Row(children: [
             _PostState(icon:Icons.favorite_border,count:post.likesCount),
             _PostState(icon:Icons.favorite_border,count:post.commentsCount ),
             _PostState(icon:Icons.favorite_border,count:post.repostsCount),
           ],)
         ],
      ),
    );
  }
}

class _PostState extends StatelessWidget {
  final IconData icon;
  final int? count; 

  const _PostState({super.key, required this.icon, this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,size: 18,color: Colors.grey),

      ],
    );
  }
}

