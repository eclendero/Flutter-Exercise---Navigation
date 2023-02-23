import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarCubit extends Cubit<String> {
  SearchBarCubit() : super('');

  void storeText(String text) {
    print(text);
    emit(text);
  }

  void resetText() => emit('');
}
