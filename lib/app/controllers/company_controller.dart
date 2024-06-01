import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tractian/app/models/asset_model.dart';
import 'package:tractian/app/models/company_model.dart';
import 'package:tractian/app/models/location_model.dart';

class CompanyController extends GetxController {
  final _dio = Dio();
  var baseUrl = "".obs;
  List<CompanyModel> companiesList = [];

  @override
  void onInit() {
    super.onInit();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final jsonString = await rootBundle.loadString('assets/params/params.json');
    final jsonMap = json.decode(jsonString);
    baseUrl.value = jsonMap['base_url'];
    update();
  }

  Future<List<CompanyModel>> fetchCompanies() async {
    await _loadConfig();
    try {
      var response = await _dio.get("$baseUrl/companies");
      for (var element in response.data) {
        companiesList.add(CompanyModel.fromJson(element));
      }
    } catch (e) {
      throw Error();
    }
    update();
    return companiesList;
  }

  Future<List<AssetModel>> fetchAssets(String companyId) async {
    await _loadConfig();
    List<AssetModel> assetList = [];
    try {
      var response = await _dio.get("$baseUrl/companies/$companyId/assets");
      for (var json in response.data) {
        AssetModel asset = AssetModel.fromJson(json);
        if (asset.parentId == "") {
          assetList.add(asset);
        }
        update();
      }

      for (var json in response.data) {
        AssetModel asset = AssetModel.fromJson(json);
        if (asset.parentId != "") {
          for (var element in assetList) {
            if (asset.parentId == element.id) {
              element.assetList.add(asset);
            }
          }
        }
        update();
      }

      Iterable<AssetModel> noChildAssets = assetList.where((element) => element.assetList.isEmpty);
      Iterable<AssetModel> childAssets = assetList.where((element) => element.assetList.isNotEmpty);
      assetList = [...noChildAssets, ...childAssets];
    } catch (e, stackTrace) {}
    update();

    return assetList;
  }

  Future<List<LocationModel>> fetchLocations(String companyId) async {
    await _loadConfig();
    List<LocationModel> locationList = [];
    try {
      var response = await _dio.get("$baseUrl/companies/$companyId/locations");
      for (var json in response.data) {
        LocationModel location = LocationModel.fromJson(json);
        if (location.parentId == "") {
          locationList.add(location);
        }
      }

      for (var json in response.data) {
        LocationModel location = LocationModel.fromJson(json);
        if (location.parentId != "") {
          for (var element in locationList) {
            if (location.parentId == element.id) {
              element.childLocations.add(location);
            }
          }
        }
      }
      update();

      Iterable<LocationModel> noChildLocations =
          locationList.where((element) => element.childLocations.isEmpty);
      Iterable<LocationModel> childLocations =
          locationList.where((element) => element.childLocations.isNotEmpty);
      locationList = [...childLocations, ...noChildLocations];
    } catch (e) {
      throw Error();
    }
    update();

    return locationList;
  }
}
