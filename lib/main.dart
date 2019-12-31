import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_newsapiorg/newslist_bloc/bloc.dart';
import 'package:flutter_newsapiorg/newslist_bloc/newslist_repository.dart';
import 'package:flutter_newsapiorg/screen/news_list_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fresh News',
      home: BlocProvider(
        create: (context) => NewsListBloc(repository: NewsListRepository()),
        child: NewsListScreen(),
      ),
    );
  }
}
