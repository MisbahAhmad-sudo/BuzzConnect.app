import 'package:final_project/pages/contactPage/contactPage.dart';
import 'package:final_project/pages/profile/profilePage.dart';
import 'package:get/get.dart';

import '../components/full_screen_video.dart';
import '../pages/Gropup/NewGroup/groupTittle.dart';
import '../pages/Gropup/NewGroup/newGroup.dart';
import '../pages/GroupChat/groupChat.dart';
import '../pages/home_page.dart';
import '../pages/settings_page.dart';
import '../pages/userProfile/UserUpdateProfile.dart';
import '../services/auth/auth_gate.dart';


var pagePath = [
  GetPage(name: "/authGate", page:()=> AuthGate()),
  GetPage(name: "/profilePage", page:()=> const ProfilePage()),
  GetPage(name: "/contactPage", page:()=> ContactPage()),
  GetPage(name: "/newGroup", page:()=> NewGroup()),
  GetPage(name: "/settingPage", page:()=> SettingPage()),
  GetPage(name: "/userUpdateProfile", page:()=> UserUpdateProfile()),
  GetPage(name: "/homePage", page:()=> HomePage()),
  GetPage(name: "/groupTitle", page:()=> GroupTitle()),
];