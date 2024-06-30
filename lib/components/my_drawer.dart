import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../pages/settings_page.dart';
import '../services/auth/auth_service.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  void signOut() {
    final authService = Provider.of<AuthServices>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //logo
              DrawerHeader(
                  child: Center(
                      child: Icon(
                        Icons.message,
                        color: Theme.of(context).colorScheme.primary,
                        size: 40,
                      ))),
              //home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text('H O M E'),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Get.back();
                  //  Navigator.pop(context);
                  },
                ),
              ),
              //Setting list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text('S E T T I N G S'),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    //pop the drawer
                    Get.back();
                    //Navigator.pop(context);
                    //push setting page
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingPage()));*/
                    Get.offAllNamed("/settingPage");
                  },
                ),
              ),
            ],
          ),
          //logOut list tile
          Padding(
            padding: const EdgeInsets.only(
              left: 25.0,
              bottom: 25.0,
            ),
            child: ListTile(
              title: const Text('L O G O U T'),
              leading: const Icon(Icons.logout),
              onTap:signOut,
            ),
          ),
        ],
      ),
    );
  }
}
