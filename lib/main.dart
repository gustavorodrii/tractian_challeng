import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/app/controllers/home_view_controller.dart';
import 'package:tractian/routes/routes.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tractian Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: routes,
      initialBinding: BindingsBuilder.put(() => HomeViewController()),
    );
  }
}
