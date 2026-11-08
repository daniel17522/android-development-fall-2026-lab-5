class StoryModel {
  const StoryModel({
    required this.name,
    required this.avatarUrl,
    this.isCurrentUser = false,
  });

  final String name;
  final String avatarUrl;
  final bool isCurrentUser;
}
