# Flutter Feed — Lab 5

An Instagram-style Flutter feed completed from the class starter project.

## Homework requirements completed

- Stories are displayed directly below the app bar with a horizontal `ListView.builder`.
- `StoryAvatar` is a separate widget and uses `CircleAvatar` plus a network image.
- Every post has its own list of `CommentModel` objects.
- `CommentWidget` renders individual comments in the comments bottom sheet.
- `PostModel` contains post metadata, likes, and a mutable comments list.
- `post_feed_data.dart` creates 20 unique `PostModel` records and `HomeTab` adds them with `PostServices.batchAddPosts`.

## Try it

```bash
flutter pub get
flutter run
```

Tap the comment icon on any post to view its independent comments or add one. Tap the heart to like or unlike a post.
