import 'package:equatable/equatable.dart';
import 'package:brevity/models/article_model.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class ToggleBookmarkEvent extends BookmarkEvent {
  final Article article;
  const ToggleBookmarkEvent(this.article);

  @override
  List<Object> get props => [article];
}

class LoadBookmarksEvent extends BookmarkEvent {
  const LoadBookmarksEvent();
}