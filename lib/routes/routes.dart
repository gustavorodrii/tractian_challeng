import 'package:get/get.dart';
import 'package:tractian/app/views/assets/assets_view.dart';
import 'package:tractian/app/views/home/home_view.dart';
import 'package:tractian/app/views/splash/splash_view.dart';

final List<GetPage> routes = [
  GetPage(
    name: '/',
    page: () => SplashView(),
  ),
  GetPage(
    name: '/home',
    page: () => HomeView(),
  ),
  GetPage(
    name: '/assets/:companyId',
    page: () => AssetsView(companyId: Get.parameters['companyId'] ?? ''),
  ),
];
