import 'package:app_game/src/models/painting_model.dart';
import 'package:equatable/equatable.dart';

enum PostStatus { initial, success, failure }

class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <PaintingModel>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<PaintingModel> posts;
  final bool hasReachedMax;

  PostState copyWith({
    PostStatus? status,
    List<PaintingModel>? posts,
    bool? hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }''';
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}
