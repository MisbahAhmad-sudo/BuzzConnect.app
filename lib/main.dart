import 'package:final_project/config/pagePath.dart';
import 'package:final_project/controller/callController.dart';
import 'package:final_project/pages/SplacehPge/splaceh_page.dart';
import 'package:final_project/services/auth/auth_service.dart';
import 'package:final_project/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthServices()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()), // Add ThemeProvider here
        ],
    child: const  MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    CallController callController = Get.put(CallController());
    return  GetMaterialApp(
      builder: FToastBuilder(),
      getPages: pagePath,
      debugShowCheckedModeBanner: false,
      home:  const SplacePage(),
      theme:themeProvider.themeData,
    );
  }
}
