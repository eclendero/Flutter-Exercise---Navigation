import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SelectionState extends Equatable {
  const SelectionState({this.selectedEntry});

  final Map<String, String>? selectedEntry;

  @override
  List<Object?> get props => [selectedEntry];

  SelectionState copyWith({
    ValueGetter<Map<String, String>?>? selectedEntry,
  }) {
    return SelectionState(
      selectedEntry:
          selectedEntry != null ? selectedEntry() : this.selectedEntry,
    );
  }
}
