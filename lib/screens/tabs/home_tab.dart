import 'package:android_dev/screens/content/post_widget.dart';
import 'package:android_dev/screens/content/stories_list.dart';
import 'package:android_dev/screens/home_screen/data/post_feed_data.dart';
import 'package:android_dev/screens/home_screen/data/story_feed_data.dart';
import 'package:android_dev/screens/home_screen/models/comment_model.dart';
import 'package:android_dev/screens/home_screen/models/post_model.dart';
import 'package:android_dev/screens/home_screen/services/post_services.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final PostServices _postServices = PostServices();

  @override
  void initState() {
    super.initState();
    // The assignment asks for the prepared list to be added via this method.
    _postServices.batchAddPosts(createDemoPosts());
  }

  void _like(PostModel post) => setState(() => _postServices.likePost(post));

  void _unlike(PostModel post) =>
      setState(() => _postServices.unlikePost(post));

  void _addComment(PostModel post, CommentModel comment) =>
      setState(() => _postServices.commentOnPost(post, comment));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text(
          'Instagram',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            tooltip: 'Activity',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.send_outlined),
            tooltip: 'Messages',
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _postServices.posts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              color: Colors.white,
              child: StoriesList(stories: demoStories),
            );
          }

          final post = _postServices.posts[index - 1];
          return PostWidget(
            key: ValueKey(post.id),
            post: post,
            onLike: () => _like(post),
            onUnlike: () => _unlike(post),
            onComment: (comment) => _addComment(post, comment),
          );
        },
      ),
    );
  }
}
