import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDetailsCubit extends Cubit<Map> {
  SearchDetailsCubit() : super({});

  void storeSearchDetails(Map item) {
    String searchDetail = item.keys.first;
    var value = item.values.first;
    //Create a copy of state
    Map newState = Map.of(state);
    //Check if there is a preexisting search detail, e.g., recipe
    //If there is, overwrite the entry
    if (newState.containsKey(searchDetail)) {
      newState[searchDetail] = value;
    } else {
      newState.addAll(item);
    }
    emit(newState);
  }

  void reset() => emit({});
}
