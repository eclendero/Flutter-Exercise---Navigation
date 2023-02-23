import 'package:flutter/material.dart';

class PageSelectionState {
  const PageSelectionState({required this.selectedPage});

  final int selectedPage;

  PageSelectionState copyWith({
    required ValueGetter<int> selectedPage,
  }) {
    return PageSelectionState(
      selectedPage: selectedPage(),
    );
  }
}
