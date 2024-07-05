import 'package:final_project/pages/SplacehPge/splaceh_page.dart';
import 'package:final_project/services/notification/NotificationPolling.dart';
import 'package:final_project/services/notification/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'config/pagePath.dart';
import 'controller/callController.dart';
import 'firebase_options.dart';
import 'themes/theme_provider.dart';
import 'package:final_project/services/auth/auth_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthServices()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    CallController callController = Get.put(CallController());

    // Start notification polling
    NotificationPoller notificationPoller = NotificationPoller();
    notificationPoller.startPolling();

    return GetMaterialApp(
      builder: FToastBuilder(),
      getPages: pagePath,
      debugShowCheckedModeBanner: false,
      home: const SplacePage(),
      theme: themeProvider.themeData,
    );
  }

}
