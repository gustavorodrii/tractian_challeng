class AssetModel {
  String id;
  String locationId;
  String name;
  String parentId;
  String sensorType;
  String status;
  List<AssetModel> assetList;

  AssetModel({
    required this.id,
    required this.locationId,
    required this.name,
    required this.parentId,
    required this.sensorType,
    required this.status,
    required this.assetList,
  });

  static fromJson(Map<String, dynamic> data) {
    return AssetModel(
      id: data['id'],
      locationId: data['locationId'] ?? "",
      name: data['name'],
      parentId: data['parentId'] ?? "",
      sensorType: data['sensorType'] ?? "",
      status: data['status'] ?? "",
      assetList: [],
    );
  }
}
