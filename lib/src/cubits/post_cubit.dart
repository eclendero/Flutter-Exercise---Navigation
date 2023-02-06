import 'dart:convert';
import 'package:app_game/src/models/painting_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' show get;

class PostCubit extends Cubit<List> {
  PostCubit() : super([]);

  void fetchList() async {
    final response = await get(Uri.parse(
        'https://collectionapi.metmuseum.org/public/collection/v1/search?q=painting&&medium=Paintings&&q=canvas&&hasImages=true'));

    if (response.statusCode == 200) {
      bool isComplete = false;
      int index = 0;
      final body = json.decode(response.body);
      List idList = body['objectIDs'];
      // Takes the first 20 entries of the list
      while (isComplete == false) {
        Map<String, String> instance = await _fetchEntry(idList[index]);
        //Skip entries without image
        if (instance['primaryImage'] != '') {
          List<Map> details = [...state, instance];
          emit(details);
          if (details.length == 20) {
            break;
          }
        }
        index++;
      }
    } else {
      throw Exception('Error fetching list');
    }
  }

  Future<Map<String, String>> _fetchEntry(int objectID) async {
    //Get the details of the specific painting from the list
    final response = await get(Uri.parse(
        'https://collectionapi.metmuseum.org/public/collection/v1/objects/$objectID'));
    if (response.statusCode == 200) {
      final details = json.decode(response.body);
      // Create a map of parameters for each painting (title, artistDisplayName, etc.)
      var instance = PaintingModel.fromJson(details);
      return instance.createMap();
    } else {
      throw Exception('Error fetching list');
    }
  }
}
