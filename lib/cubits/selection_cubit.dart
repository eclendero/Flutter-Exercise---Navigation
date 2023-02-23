import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/recipe_selection_state.dart';

class RecipeSelectionCubit extends Cubit<RecipeSelectionState> {
  RecipeSelectionCubit() : super(const RecipeSelectionState());

  void selectRecipe(recipe) {
    emit(state.copyWith(selectedRecipe: () => recipe));
  }

  // void deselectRecipe() {
  //   emit(state.copyWith(selectedRecipe: () => null));
  // }
}
