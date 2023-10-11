import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mt_test/data/models/post.dart';
import 'package:mt_test/data/repositories/posts_respository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.repository) : super(PostsInitial());

  int page = 1;
  final PostsRepository repository;

  void loadPosts(isActivePage) {
    if (state is PostsLoading) return;

    final currentState = state;

    var oldPosts = <Post>[];
    var AllPosts = <Post>[];
    if (currentState is PostsLoaded) {
      oldPosts = currentState.posts;
    }

    emit(PostsLoading(oldPosts, isFirstFetch: page == 1));

    repository.fetchPosts(page).then((newPosts) {
      page++;

      var posts = (state as PostsLoading).oldPosts;
      //   posts.add(newPosts);
      posts.addAll(newPosts);
      posts = [];
      emit(PostsLoaded(posts));
      //  print('object ${posts[0][0]}');
    });
  }
}
