import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mt_test/presentation/second_tab.dart';
import 'package:toast/toast.dart';
import '../cubit/posts_cubit.dart';
import '../data/models/post.dart';

class PostsView extends StatelessWidget {
  final scrollController = ScrollController();
  bool IsActivePage = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostsCubit>(context).loadPosts(IsActivePage);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 40,
          color: Color.fromARGB(255, 132, 97, 97),
          child: Row(
            children: [
              Expanded(
                  child: IconButton(
                onPressed: () {
                  IsActivePage = true;
                  BlocProvider.of<PostsCubit>(context).loadPosts(IsActivePage);
                },
                icon: Icon(Icons.arrow_back_ios),
              )),
              Expanded(child: Text('Total Iteam')),
              Expanded(
                  child: IconButton(
                onPressed: () {
                  IsActivePage = true;
                  BlocProvider.of<PostsCubit>(context).loadPosts(IsActivePage);
                },
                icon: Icon(Icons.arrow_forward_ios),
              ))
            ],
          ),
        ),
      )),
      // floatingActionButton: FloatingActionButton.extended(
      //     label: const Row(
      //       children: [
      //         Text('Load Next 6 Item'),
      //         Icon(Icons.arrow_forward_ios),
      //       ],
      //     ),
      //     backgroundColor: Colors.grey,
      //     onPressed: () => {
      //           BlocProvider.of<PostsCubit>(context).loadPosts(),
      //         }),
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

      if (state is PostsLoading) {
        posts = state.oldPosts;
      } else if (state is PostsLoaded) {
        posts = state.posts;
      }

      return ListView.builder(
        itemBuilder: (context, index) => _post(posts[index], context),
        itemCount: posts.length,
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.black87,
        color: Colors.grey,
      )),
    );
  }

  Widget _post(Post post, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 100),
                pageBuilder: (context, _, ___) => SecondTab(
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
