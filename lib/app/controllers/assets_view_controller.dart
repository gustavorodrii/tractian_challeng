import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/app/controllers/company_controller.dart';
import 'package:tractian/app/models/asset_model.dart';
import 'package:tractian/app/models/location_model.dart';

class AssetsViewController extends GetxController {
  final String companyId;
  final searchController = TextEditingController();
  final companyController = CompanyController();

  var isToggledCritic = false.obs;
  var isToggledEnergy = false.obs;
  var isToggledVibration = false.obs;

  var baseLocationList = <LocationModel>[].obs;
  var visualizationLocationList = <LocationModel>[].obs;

  AssetsViewController(this.companyId);

  @override
  void onInit() {
    super.onInit();
    fetchLocationList();
  }

  Future<void> fetchLocationList() async {
    baseLocationList.value = await companyController.fetchLocations(companyId);
    List<AssetModel> assetList = await companyController.fetchAssets(companyId);
    organizeLists(assetList, baseLocationList);
    Iterable<LocationModel> noChildLocations =
        baseLocationList.where((e) => e.childLocations.isEmpty && e.assetLists.isEmpty);
    Iterable<LocationModel> childLocations =
        baseLocationList.where((e) => e.childLocations.isNotEmpty || e.assetLists.isNotEmpty);
    baseLocationList.value = [...childLocations, ...noChildLocations];
    visualizationLocationList.value = baseLocationList;
    update();
  }

  void resetList() {
    visualizationLocationList.value = baseLocationList;
    isToggledCritic.value = false;
    isToggledEnergy.value = false;
    isToggledVibration.value = false;
    update();
  }

  void organizeLists(List<AssetModel> aList, List<LocationModel> lList) {
    for (var location in lList) {
      for (var asset in aList) {
        if (location.id == asset.locationId) {
          location.assetLists.add(asset);
        }
      }
      organizeLists(aList, location.childLocations);
    }
    update();
  }

  void filterLocations(String search) {
    search = search.toLowerCase();
    visualizationLocationList.value = _filterLocationsRecursive(baseLocationList, search);
  }

  List<LocationModel> _filterLocationsRecursive(List<LocationModel> locations, String search) {
    List<LocationModel> filteredList = [];

    for (var location in locations) {
      bool matchesQuery = location.name.toLowerCase().contains(search);

      List<AssetModel> filteredAssets = _filterAssetsRecursive(location.assetLists, search);

      List<LocationModel> filteredChildLocations =
          _filterLocationsRecursive(location.childLocations, search);

      if ((matchesQuery && (filteredAssets.isNotEmpty || filteredChildLocations.isNotEmpty)) ||
          filteredAssets.isNotEmpty ||
          filteredChildLocations.isNotEmpty) {
        location = LocationModel(
          id: location.id,
          name: location.name,
          parentId: location.parentId,
          childLocations: filteredChildLocations,
          assetLists: filteredAssets,
        );
        filteredList.add(location);
      }
    }
    update();

    return filteredList;
  }

  List<AssetModel> _filterAssetsRecursive(List<AssetModel> assets, String search) {
    List<AssetModel> filteredList = [];

    for (var asset in assets) {
      bool matchesQuery = asset.name.toLowerCase().contains(search);

      bool matchesCritic = !isToggledCritic.value || asset.status == "alert";
      bool matchesEnergy = !isToggledEnergy.value || asset.sensorType == "energy";
      bool matchesVibration = !isToggledVibration.value || asset.sensorType == "vibration";

      List<AssetModel> filteredSubAssets = _filterAssetsRecursive(asset.assetList, search);

      if ((matchesQuery || search.isEmpty) && matchesCritic && matchesVibration && matchesEnergy ||
          filteredSubAssets.isNotEmpty) {
        asset = AssetModel(
          id: asset.id,
          name: asset.name,
          locationId: asset.locationId,
          assetList: filteredSubAssets,
          parentId: asset.parentId,
          sensorType: asset.sensorType,
          status: asset.status,
        );
        filteredList.add(asset);
      }
    }
    update();

    return filteredList;
  }

  // funçao feita para evitar codigo repetitivo (don't repeat yourself)
  void toggleFilter(RxBool filterValue) {
    filterValue.value = !filterValue.value;
    if (filterValue.value) {
      filterLocations(searchController.text);
    } else {
      resetList();
    }
    update();
  }

  void toggleEnergyButton() {
    toggleFilter(isToggledEnergy);
  }

  void toggleCriticButton() {
    toggleFilter(isToggledCritic);
  }

  void toggleVibrationButton() {
    toggleFilter(isToggledVibration);
  }
}
