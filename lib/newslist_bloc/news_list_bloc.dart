import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_newsapiorg/newslist_bloc/newslist_repository.dart';
import '../models/article_model.dart';
import './bloc.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  final NewsListRepository repository;

  NewsListBloc({@required this.repository}) : assert(repository != null);

  @override
  NewsListState get initialState => NewsListEmpty();

  @override
  Stream<NewsListState> mapEventToState(
    NewsListEvent event,
  ) async* {
    if (event is FetchNewsList) {
      yield NewsListLoading();
      try {
        List<Article> articles;

        if (event.search != null) {
          articles = await repository.fetchTopHeadLinesByKeyword(
              keyword: event.search);
        } else {
          articles = await repository.fetchTopHeadLines();
        }

        yield NewsListLoaded(articles: articles);
      } catch (_) {
        yield NewsListError();
      }
    }
  }
}
