import 'package:app_game/states/page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageSelectionCubit extends Cubit<PageSelectionState> {
  PageSelectionCubit() : super(const PageSelectionState(selectedPage: 0));

  void selectPage(int index) {
    emit(state.copyWith(selectedPage: () => index));
  }
}
