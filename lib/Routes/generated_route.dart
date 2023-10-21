import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mt_test/data/models/post.dart';
import 'package:mt_test/presentation/second_tab.dart';

import '../bloc/posts_bloc.dart';
import '../data/repositories/posts_respository.dart';
import '../presentation/posts_screen.dart';

class RouteGenerated {
  final PostsRepository repository;

  RouteGenerated({required this.repository});
  Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => PostsBloc(repository),
                  child: PostsView(),
                ));
      case '/Secondpage':
        Post data = settings.arguments as Post;

        return MaterialPageRoute(
            builder: (context) => SecondTab(
                  postData: data,
                ));
      default:
        return errorpage();
    }
  }

  errorpage() {
    MaterialPageRoute(
        builder: (cpntexrt) => Scaffold(
              body: Center(child: Text('Error')),
            ));
  }
}
