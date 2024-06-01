import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/app/controllers/assets_view_controller.dart';
import 'package:tractian/utils/colors/colors.dart';
import 'package:tractian/utils/components/filter_options_button.dart';
import 'package:tractian/utils/components/custom_expansiontile_asset.dart';
import 'package:tractian/utils/components/custom_expansiontile_location.dart';
import 'package:tractian/app/models/asset_model.dart';
import 'package:tractian/app/models/location_model.dart';

class AssetsView extends StatelessWidget {
  final String companyId;

  AssetsView({
    Key? key,
    required this.companyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AssetsViewController controller = Get.put(AssetsViewController(companyId));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: bgTractianColor,
        centerTitle: true,
        title: const Text(
          "Assets",
          style: TextStyle(
            color: whiteButtonTractianColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        leadingWidth: 100,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const SizedBox(
            height: 40,
            width: 40,
            child: Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Obx(() {
              return SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 32,
                      width: 328,
                      child: TextFormField(
                        controller: controller.searchController,
                        onChanged: (value) {
                          Future.delayed(const Duration(seconds: 2), () {
                            if (value.isNotEmpty) {
                              controller.filterLocations(value);
                            }
                          });
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            size: 16,
                            color: menuAssetsButtonTractianColor,
                          ),
                          filled: true,
                          fillColor: fillColorTextFieldTractianColor,
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: "Buscar Ativo ou Local",
                          contentPadding: EdgeInsets.only(left: 30),
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: searchFieldTractianColor,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: searchFieldTractianColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 328,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FilterOptionsButton(
                            buttonText: "Sensor de Energia",
                            height: 36,
                            borderRadius: 3,
                            onTap: () => controller.toggleEnergyButton(),
                            icon: Icons.bolt,
                            iconSize: 16,
                            textColor: controller.isToggledEnergy.value
                                ? whiteButtonTractianColor
                                : menuAssetsButtonTractianColor,
                            iconColor: controller.isToggledEnergy.value
                                ? whiteButtonTractianColor
                                : menuAssetsButtonTractianColor,
                            borderColor: controller.isToggledEnergy.value
                                ? whiteButtonTractianColor
                                : menuAssetsButtonTractianColor,
                            buttonColor: controller.isToggledEnergy.value
                                ? menuButtonTractianColor
                                : Colors.transparent,
                          ),
                          const SizedBox(width: 8),
                          FilterOptionsButton(
                            buttonText: "Crítico",
                            height: 36,
                            borderRadius: 3,
                            onTap: () => controller.toggleCriticButton(),
                            icon: Icons.error_outline,
                            iconSize: 16,
                            textColor: controller.isToggledCritic.value
                                ? whiteButtonTractianColor
                                : menuAssetsButtonTractianColor,
                            iconColor: controller.isToggledCritic.value
                                ? whiteButtonTractianColor
                                : menuAssetsButtonTractianColor,
                            borderColor: controller.isToggledCritic.value
                                ? whiteButtonTractianColor
                                : menuAssetsButtonTractianColor,
                            buttonColor: controller.isToggledCritic.value
                                ? menuButtonTractianColor
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    controller.visualizationLocationList.isEmpty
                        ? controller.baseLocationList.isEmpty
                            ? const Column(
                                children: [
                                  SizedBox(height: 100),
                                  CircularProgressIndicator(
                                    color: Color.fromRGBO(23, 25, 45, 1),
                                  ),
                                ],
                              )
                            : const Text("Sem Resultados para busca...")
                        : Expanded(
                            child: ListView(
                              children: controller.visualizationLocationList
                                  .map((e) => buildTile(e))
                                  .toList(),
                            ),
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget buildAssetTile(AssetModel asset, {double leftPadding = 16}) {
    if (asset.assetList.isEmpty) {
      return ListTile(
        contentPadding: EdgeInsets.only(left: leftPadding + 42),
        title: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Image.asset("assets/icons/tractian_asset_small.png"),
            ),
            const SizedBox(width: 10),
            Text(
              asset.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: textColorAssetTractianColor,
              ),
            ),
            if (asset.sensorType == "energy")
              const Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.bolt_outlined, color: Colors.green, size: 16),
                ],
              )
            else if (asset.sensorType == "vibration")
              const Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.vibration_outlined, color: Colors.green, size: 16),
                ],
              ),
            if (asset.status == "alert")
              const Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.circle, color: Colors.red, size: 16),
                ],
              ),
          ],
        ),
      );
    } else {
      return Theme(
        data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
        child: CustomAssetExpansionTileAsset(
          asset: asset,
          leftPadding: leftPadding,
          buildTile: buildAssetTile,
        ),
      );
    }
  }

  Widget buildTile(LocationModel location, {double leftPadding = 16}) {
    if (location.childLocations.isEmpty && location.assetLists.isEmpty) {
      return ListTile(
        contentPadding: EdgeInsets.only(left: leftPadding),
        title: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Image.asset("assets/icons/tractian_location.png"),
            ),
            const SizedBox(width: 10),
            Text(
              location.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: textColorAssetTractianColor,
              ),
            ),
          ],
        ),
      );
    } else {
      return Theme(
        data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
        child: CustomExpansionTileLocation(
          location: location,
          leftPadding: leftPadding,
          buildTile: buildTile,
          buildAssetTile: buildAssetTile,
        ),
      );
    }
  }
}
