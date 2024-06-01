import 'package:tractian/app/models/asset_model.dart';

class LocationModel {
  String id;
  String name;
  String parentId;
  List<LocationModel> childLocations;
  List<AssetModel> assetLists;

  LocationModel({
    required this.id,
    required this.name,
    required this.parentId,
    required this.childLocations,
    required this.assetLists,
  });

  static fromJson(Map<String, dynamic> data) {
    return LocationModel(
      id: data['id'],
      name: data['name'],
      parentId: data['parentId'] ?? "",
      childLocations: [],
      assetLists: [],
    );
  }
}
