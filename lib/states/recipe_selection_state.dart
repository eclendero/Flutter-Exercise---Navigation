import 'package:flutter/material.dart';

class RecipeSelectionState {
  const RecipeSelectionState({this.selectedRecipe});

  final int? selectedRecipe;

  RecipeSelectionState copyWith({
    required ValueGetter<int>? selectedRecipe,
  }) {
    return RecipeSelectionState(
      selectedRecipe:
          selectedRecipe != null ? selectedRecipe() : this.selectedRecipe,
    );
  }
}
