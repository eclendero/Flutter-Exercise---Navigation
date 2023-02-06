import 'package:app_game/src/cubits/selection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaintingsCubit extends Cubit<SelectionState> {
  PaintingsCubit() : super(const SelectionState());

  void selectPainting(painting) {
    emit(state.copyWith(selectedEntry: () => painting));
  }

  void deselectPainting() {
    emit(state.copyWith(selectedEntry: () => null));
  }
}
