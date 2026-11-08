import 'comment_model.dart';

class PostModel {
  PostModel({
    required this.id,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.imageUrl,
    required this.description,
    this.likeCount = 0,
    List<CommentModel>? comments,
  }) : comments = comments ?? [];

  final String id;
  final String authorName;
  final String authorAvatarUrl;
  final String imageUrl;
  final String description;
  int likeCount;
  final List<CommentModel> comments;

  int get commentCount => comments.length;

  void addLike(int newCount) => likeCount = newCount;

  void addComment(CommentModel comment) => comments.add(comment);
}
