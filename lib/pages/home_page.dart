import 'package:final_project/controller/statusController.dart';
import 'package:final_project/pages/Gropup/groupPage.dart';
import 'package:final_project/pages/callHistory/callHistory.dart';
import 'package:flutter/material.dart';
import 'package:final_project/components/my_drawer.dart';
import 'package:final_project/components/tabBar.dart';
import 'package:final_project/config/string.dart';
import 'package:final_project/pages/profile/profilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../chatBot.dart';
import '../controller/profileController.dart';
import 'chatList.dart';
import 'contactPage/contactPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final ProfileController profileController = Get.put(ProfileController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StatusController statusController = Get.put(StatusController());


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Center(
          child: Text(
            AppString.appName,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              await profileController.getUserDetails();
              Get.to(ProfilePage());
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
        bottom: MyTabBar(_tabController, context),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const ContactPage());
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),*/
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10), // Adjust the padding as needed
                child: ChatList(),
              ),// Call the UserListWidget here
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10), // Adjust the padding as needed
                child: GroupPage(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10), // Adjust the padding as needed
                child: CallHistory(),
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                Get.to(const ContactPage());
              },
              backgroundColor: Colors.purple,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                Get.to(const  ChatScreen());
              },
              backgroundColor: Colors.purple,
              child: const Icon(Icons.circle_outlined, color: Colors.white,size: 40, ),
            ),
          ),

        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}
