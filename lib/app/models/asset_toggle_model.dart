import 'package:tractian/app/models/location_model.dart';

class AssetToggleModel {
  bool isToggledEnergy;
  bool isToggledCritic;
  bool isToggledVibration;
  List<LocationModel> baseLocationList;
  List<LocationModel> visualizationLocationList;

  AssetToggleModel({
    required this.isToggledCritic,
    required this.isToggledEnergy,
    required this.isToggledVibration,
    required this.baseLocationList,
    required this.visualizationLocationList,
  });
}
