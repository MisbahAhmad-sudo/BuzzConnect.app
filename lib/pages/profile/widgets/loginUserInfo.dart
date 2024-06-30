import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/profileController.dart';

class LoginUserInfo extends StatelessWidget {
  final String profileImage;
  final String userName;
  final String userEmail;
  const LoginUserInfo({super.key, required this.profileImage, required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController=Get.put(ProfileController()) ;
    print(profileController.currentUser.value.name);

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.purple,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Image(image: AssetImage('assets/Images/profile.png'), height: 50, width: 50,),
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(100),
                      child: Image.network(
                        profileImage,
                        height: 150,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display the current user's email
                    Text(
                      userEmail,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.call, color: Colors.white, weight: 50,),
                          const SizedBox(width: 10,),
                          Text('Audio', style: Theme.of(context).textTheme.labelLarge,),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.video_call, color: Colors.white, weight: 50,),
                          const SizedBox(width: 10,),
                          Text('Video', style: Theme.of(context).textTheme.labelLarge,),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.chat, color: Colors.white, weight: 50,),
                          const SizedBox(width: 10,),
                          Text('Chat', style: Theme.of(context).textTheme.labelLarge,),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
