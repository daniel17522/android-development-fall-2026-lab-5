# Lab 5 quick study guide

## Explain the app flow

`HomeTab` owns one `PostServices` instance. In `initState`, it calls
`batchAddPosts(createDemoPosts())`. The feed is a vertical `ListView.builder`:
item zero is the stories area and every later item is a `PostWidget`.

## Likely questions and short answers

1. **Why use `ListView.builder`?** It creates only the visible items instead of
   building the whole feed at once. The horizontal stories list uses the same
   builder pattern with `scrollDirection: Axis.horizontal`.
2. **Why is `HomeTab` stateful?** Likes and new comments change data, so it calls
   `setState` to rebuild the visible counts and comment list.
3. **Why have a `CommentModel`?** A comment has its own data (`authorName`,
   `avatarUrl`, and `message`). A model makes comments structured and reusable.
4. **How does each post keep separate comments?** Each `PostModel` owns a
   different `List<CommentModel>`; the post service adds a comment to the post
   that was tapped.
5. **Why use a separate `CommentWidget` and `StoryAvatar`?** Small focused
   widgets make the screen easier to read, test, and reuse.
6. **What does `initState` do here?** It runs once when `HomeTab` is inserted,
   which prevents the 20 demo posts from being added again on every rebuild.
7. **Why use `Image.network` and `CircleAvatar`?** `Image.network` loads remote
   content; `CircleAvatar` gives profile images a ready-made circular avatar UI.
8. **What is the role of `PostServices`?** It centralizes operations such as
   batching posts, liking/unliking, and adding a comment so UI widgets do not
   need to know the data-update details.

## Demo checklist

- Scroll the horizontal stories row.
- Scroll the 20-post feed.
- Like and unlike a post; the count changes.
- Open comments on two different posts to show their comments are different.
- Add a comment and show that only the selected post's count changes.
