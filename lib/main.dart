import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mt_test/bloc/posts_bloc.dart';
import 'package:mt_test/presentation/posts_screen.dart';
import 'package:toast/toast.dart';
import 'Routes/generated_route.dart';
import 'cubit/posts_cubit.dart';
import 'data/repositories/posts_respository.dart';
import 'data/services/posts_service.dart';

void main() {
  runApp(MyApp(
    repository: PostsRepository(PostsService()),
  ));
}

class MyApp extends StatelessWidget {
  final PostsRepository repository;

  const MyApp({required this.repository, super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MaterialApp(
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey)),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerated(repository: repository).generatedRoute,
    );
  }
}
