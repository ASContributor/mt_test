import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mt_test/data/repositories/posts_respository.dart';

import '../data/models/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository repository;
  PostsBloc(this.repository) : super(PostsInitial()) {
    int page = 1;
    on<PostsEvent>((event, emit) async {
      if (event is LoadPostEvent) {
        if (state is PostsLoading) return;

        final currentState = state;

        var oldPosts = <Post>[];

        if (currentState is PostsLoaded) {
          oldPosts = currentState.posts;
        }

        emit(PostsLoading(oldPosts, isFirstFetch: page == 1));
        // print('page$page');
        try {
          await repository.fetchPosts(page).then((newPosts) {
            page++;
            // print('page numner $page');
            var posts = (state as PostsLoading).oldPosts;

            posts.addAll(newPosts);
            emit(PostsLoaded(posts));
          });
        } catch (e) {
          emit(FailedToLoadPost(e));
        }
      }
    });
  }
}
