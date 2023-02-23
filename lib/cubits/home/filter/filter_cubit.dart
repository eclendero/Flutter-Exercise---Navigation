import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit<Map> {
  FilterCubit()
      : super({'ingredients': [], 'priceLimit': '', 'categories': []});

  void store(Map item) {
    String filter = item.keys.first;
    var value = item.values.first;
    Map newState = Map.of(state);
    newState[filter] = value;
    emit(newState);
  }

  void reset() {
    emit({'ingredients': [], 'priceLimit': '', 'categories': []});
  }
}
