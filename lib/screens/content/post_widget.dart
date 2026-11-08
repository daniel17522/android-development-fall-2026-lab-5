import 'package:android_dev/screens/content/comment_widget.dart';
import 'package:android_dev/screens/home_screen/models/comment_model.dart';
import 'package:android_dev/screens/home_screen/models/post_model.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({
    super.key,
    required this.post,
    required this.onLike,
    required this.onUnlike,
    required this.onComment,
  });

  final PostModel post;
  final VoidCallback onLike;
  final VoidCallback onUnlike;
  final ValueChanged<CommentModel> onComment;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final _commentController = TextEditingController();
  bool _isLiked = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _openComments() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * .72,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Comments',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.post.comments.length,
                    itemBuilder: (context, index) =>
                        CommentWidget(comment: widget.post.comments[index]),
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _addComment(setSheetState),
                          decoration: const InputDecoration(
                            hintText: 'Add a comment...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send_rounded),
                        color: Colors.blue,
                        tooltip: 'Post comment',
                        onPressed: () => _addComment(setSheetState),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addComment(StateSetter setSheetState) {
    final message = _commentController.text.trim();
    if (message.isEmpty) return;

    widget.onComment(
      CommentModel(
        authorName: 'You',
        avatarUrl: 'https://i.pravatar.cc/150?img=8',
        message: message,
      ),
    );
    _commentController.clear();
    setSheetState(() {});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.authorAvatarUrl),
              onBackgroundImageError: (_, __) {},
            ),
            title: Text(
              post.authorName,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            trailing: const Icon(Icons.more_horiz),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              post.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const ColoredBox(
                color: Color(0xFFEDEDED),
                child: Center(
                  child: Icon(Icons.broken_image_outlined, size: 48),
                ),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : null,
                ),
                tooltip: _isLiked ? 'Unlike' : 'Like',
                onPressed: () => setState(() {
                  _isLiked = !_isLiked;
                  _isLiked ? widget.onLike() : widget.onUnlike();
                }),
              ),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline),
                tooltip: 'Comments',
                onPressed: _openComments,
              ),
              IconButton(
                icon: const Icon(Icons.send_outlined),
                tooltip: 'Share',
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                tooltip: 'Save',
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              '${post.likeCount} likes',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 6, 14, 4),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: '${post.authorName}  ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: post.description),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: _openComments,
            child: Text('View all ${post.commentCount} comments'),
          ),
        ],
      ),
    );
  }
}
