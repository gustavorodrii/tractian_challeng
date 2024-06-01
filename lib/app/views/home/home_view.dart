import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/app/controllers/home_view_controller.dart';
import 'package:tractian/utils/components/company_menu_button.dart';
import 'package:tractian/utils/colors/colors.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

final HomeViewController homeController = Get.find();

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgTractianColor,
        title: Image.asset('assets/icons/tractian_logo_icon.png'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: Obx(() {
            if (homeController.homeScreenModel.value.companiesList.isEmpty) {
              return const CircularProgressIndicator();
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 30),
                itemCount: homeController.homeScreenModel.value.companiesList.length,
                itemBuilder: (context, index) {
                  var company = homeController.homeScreenModel.value.companiesList[index];
                  return CompanyMenuButton(
                    name: "${company.name} Unit",
                    onTap: () => Get.toNamed('/assets/${company.id}'),
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
