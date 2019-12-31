import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_newsapiorg/bloc/news_list_bloc.dart';
import 'package:flutter_newsapiorg/bloc/news_list_event.dart';
import 'package:flutter_newsapiorg/bloc/news_list_state.dart';
import 'package:flutter_newsapiorg/models/article_model.dart';
import 'package:flutter_newsapiorg/screen/news_article_detail_screen.dart';
import 'package:flutter_newsapiorg/widgets/news_list_widget.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsListBloc>(context).add(
      FetchNewsList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                print('enter pressed');
                BlocProvider.of<NewsListBloc>(context).add(
                  FetchNewsList(search: value),
                );
              }
            },
            decoration: InputDecoration(
              labelText: 'Enter search term',
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.search),
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  print('suffixIcon pressed');
                  _controller.text = '';
                },
              ),
            ),
          ),
          BlocBuilder<NewsListBloc, NewsListState>(
            builder: (context, state) {
              if (state is NewsListLoading) {
                return Expanded(
                  child: Align(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is NewsListLoaded) {
                return Expanded(
                  child: NewsListWidget(
                    articles: state.articles,
                    onTapArticle: (Article article) {
                      _showNewsArticleDetails(context, article);
                    },
                  ),
                );
              } else if (state is NewsListEmpty) {
                return Expanded(
                  child: Align(
                    child: Text('No results found!'),
                  ),
                );
              } else {
                return Expanded(
                  child: Align(
                    child: Text(
                      'Something went wrong!',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _showNewsArticleDetails(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsArticleDetailScreen(article: article),
      ),
    );
  }
}
