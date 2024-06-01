// ignore: file_names
import 'package:get/get.dart';
import 'package:tractian/app/controllers/company_controller.dart';
import 'package:tractian/app/models/home_view_model.dart';

class HomeViewController extends GetxController {
  var homeScreenModel = HomeViewModel(companiesList: []).obs;

  CompanyController companyController = Get.put(CompanyController());

  Future<void> fetchCompanies() async {
    try {
      var companies = await companyController.fetchCompanies();
      homeScreenModel.update((val) {
        val?.companiesList = companies;
      });
    } catch (e) {
      throw Error();
    }
  }

  @override
  void onInit() {
    fetchCompanies();
    super.onInit();
  }
}
