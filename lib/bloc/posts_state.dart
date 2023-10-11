part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;

  PostsLoaded(this.posts);
}

class PostsLoading extends PostsState {
  final List<Post> oldPosts;
  final bool isFirstFetch;

  PostsLoading(
    this.oldPosts, {
    this.isFirstFetch = false,
  });
}

class FailedToLoadPost extends PostsState {
  var error;
  FailedToLoadPost(this.error);
}

class AllIteamLoaded extends PostsState {
  String msg;
  AllIteamLoaded(this.msg);
}
