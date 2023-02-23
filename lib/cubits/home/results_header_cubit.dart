import 'package:flutter_bloc/flutter_bloc.dart';

//Monitor the appearance of search tags
class ResultsHeaderCubit extends Cubit<Map> {
  ResultsHeaderCubit() : super({});

  void storeTags(Map tags) {
    emit(tags);
  }

  void resetTags() {
    emit({});
  }
}
