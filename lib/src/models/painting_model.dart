import 'package:equatable/equatable.dart';

class PaintingModel extends Equatable {
  PaintingModel.fromJson(parsedJson) {
    title = parsedJson['title'];
    medium = parsedJson['medium'];
    dimensions = parsedJson['dimensions'];
    artistDisplayName = parsedJson['artistDisplayName'];
    objectEndDate = parsedJson['objectEndDate'];
    primaryImage = parsedJson['primaryImage'];
  }

  late final String title;
  late final String medium;
  late final String dimensions;
  late final String artistDisplayName;
  late final int objectEndDate;
  late final String primaryImage;

  Map<String, String> createMap() {
    return {
      "title": title,
      "medium": medium,
      "dimensions": dimensions,
      "artistDisplayName":
          artistDisplayName.isEmpty ? 'Unknown Artist' : artistDisplayName,
      "objectEndDate": objectEndDate.toString(),
      "primaryImage": primaryImage
    };
  }

  @override
  List<Object> get props => [title, artistDisplayName];
}
