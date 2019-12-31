import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_newsapiorg/bloc/news_list_bloc.dart';
import 'package:flutter_newsapiorg/screen/news_list_screen.dart';
import 'package:flutter_newsapiorg/services/webservice.dart';
import 'package:flutter_newsapiorg/view_models/article_list_vm.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fresh News',
      home: BlocProvider(
        create: (context) => NewsListBloc(repository: WebService()),
        child: NewsListScreen(),
      ),
    );
  }
}
