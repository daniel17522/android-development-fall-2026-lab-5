class CommentModel {
  const CommentModel({
    required this.authorName,
    required this.avatarUrl,
    required this.message,
  });

  final String authorName;
  final String avatarUrl;
  final String message;
}
