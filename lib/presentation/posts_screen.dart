import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mt_test/presentation/second_tab.dart';

import '../cubit/posts_cubit.dart';
import '../data/models/post.dart';

class PostsView extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PostsCubit>(context).loadPosts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<PostsCubit>(context).loadPosts();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 81, 81),
        centerTitle: true,
        title: Text("Posts"),
      ),
      body: _postList(),
    );
  }

  Widget _postList() {
    return BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
      if (state is PostsLoading && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<Post> posts = [];
      bool isLoading = false;

      if (state is PostsLoading) {
        posts = state.oldPosts;
        isLoading = true;
      } else if (state is PostsLoaded) {
        posts = state.posts;
      }

      return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < posts.length)
            return _post(posts[index], context);
          else {
            Timer(Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });

            return _loadingIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: posts.length + (isLoading ? 1 : 0),
      );
    });
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _post(Post post, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SecondTab(
                      postData: post,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: 'profile',
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage('${post.avatar}'),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.first_name + ' ' + post.last_name,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Color.fromARGB(255, 91, 91, 91)),
                  ),
                  Text(
                    '  ' + post.email,
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 91, 91, 91)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}