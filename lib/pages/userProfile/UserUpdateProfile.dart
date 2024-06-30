import 'package:flutter/material.dart';
import '../../components/my_button.dart';
import '../../components/my_text_field.dart';

class UserUpdateProfile extends StatelessWidget {
  const UserUpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.purple,
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              child:  Center(
                                child: Icon(
                                  Icons.image,
                                  size: 40,
                                ),
                              ),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: Colors.white38),
                            ),
                            const SizedBox(height: 20,),
                            Row(children: [
                              Text("Personal Info", style: Theme.of(context).textTheme.labelLarge,),
                            ],),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text('Name', style: Theme.of(context).textTheme.bodyLarge,),
                              ],
                            ),
                            const SizedBox(height: 10),
                            MyTextField(controller: _messageController, hintText: 'example', obscureText: false, icon: Icons.person, fill: true,),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Email', style: Theme.of(context).textTheme.bodyLarge,),
                              ],
                            ),
                            const SizedBox(height: 10),
                            MyTextField(controller: _messageController, hintText: 'example@gmail.com', obscureText: false, icon: Icons.alternate_email, fill: true,),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Phone Number', style: Theme.of(context).textTheme.bodyLarge,),
                              ],
                            ),
                            const SizedBox(height: 10),
                            MyTextField(controller: _messageController, hintText: '12345678901', obscureText: false, icon: Icons.phone, fill: true,),
                            const SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyButton(text:'save', onTap:(){}, color: Colors.white,),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
